//
//  MINTimelineTableViewController.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-28.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINTimelineTableViewController.h"
#import "MINTimelineView.h"
#import "MINTimelineTableViewCell.h"
#import "MINWebService.h"
#import "UIColor+minimagram.h"
#import "UIImageView+AFNetworking.h"
#import "MINPhoto.h"

@interface MINTimelineTableViewController ()

@property (nonatomic, strong) MINTimelineView *view;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

@implementation MINTimelineTableViewController

#pragma mark - View controller lifecycle

- (void)loadView {
    self.view = [[MINTimelineView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.results = [[MINPhoto allObjects] sortedResultsUsingProperty:@"photoId" ascending:NO];
    [self.view.tableView reloadData];
    
    __weak typeof(self) welf = self;
    self.notification = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [welf.view.tableView reloadData];
    }];
    
    [self setupPullToRefresh];
    
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    
    [self loadNewData];
}

/* You can only assign a UIRefreshControl to a UITableViewController, so we create a "fake" one to control our tableView */
- (void)setupPullToRefresh {
    UITableViewController *tableViewController = [UITableViewController new];
    tableViewController.tableView = self.view.tableView;
    
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.backgroundColor = [UIColor minimagramBlueColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(loadNewData) forControlEvents:UIControlEventValueChanged];
    tableViewController.refreshControl = self.refreshControl;
}

#pragma mark - Table view data source

- (void)loadNewData {
    MINPhoto *newestPhoto = [self.results firstObject];
    [[MINWebService sharedInstance] getFeedWithMinId:newestPhoto.photoId maxId:nil andCompletion:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

- (void)loadMoreData {
    MINPhoto *lastPhoto = [self.results lastObject];
    [[MINWebService sharedInstance] getFeedWithMinId:nil maxId:lastPhoto.photoId andCompletion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellIdentifier = @"Cell";
     
     MINTimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (!cell) {
         cell = [[MINTimelineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }
     
     // Configure the cell...
     MINPhoto *photo = self.results[indexPath.row];
     
     if (photo.imageData) {
         cell.asyncImageView.image = [UIImage imageWithData:photo.imageData.image];
     } /*else {
         __weak MINTimelineTableViewCell *wCell = cell;
         [cell.asyncImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:photo.url]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             wCell.asyncImageView.image = image;
             [self saveImage:image forPhotoId:photo.photoId];
         } failure:nil];
     }*/
     
     cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", photo.user];
     cell.captionLabel.text = photo.caption;
     
     return cell;
}

- (void)saveImage:(UIImage *)image forPhotoId:(NSString *)photoId {
    NSLog(@"%@", photoId);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MINImageData *imageData = [MINImageData new];
        imageData.image = UIImagePNGRepresentation(image);
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:imageData];
        [realm commitWriteTransaction];
    });
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.results.count-3) {
        [self loadMoreData];
    }
}

@end
