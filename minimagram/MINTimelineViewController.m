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
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSString *latestIdFetched;

@end

@implementation MINTimelineTableViewController

#pragma mark - View controller lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.photos = [NSMutableArray new];
    }
    return self;
}

- (void)loadView {
    self.view = [[MINTimelineView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [[MINWebService sharedInstance] getFeedWithMinId:self.latestIdFetched maxId:nil andCompletion:^(NSError *error, NSArray *feedItems) {
        [self.refreshControl endRefreshing];
        if (!error) {
            self.photos = [[feedItems arrayByAddingObjectsFromArray:self.photos] mutableCopy];
            
            NSMutableArray *indexPaths = [NSMutableArray new];
            for (int i = 0; i < feedItems.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            [self.view.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            self.latestIdFetched = ((MINPhoto *)[self.photos firstObject]).photoId;
        }
    }];
}

- (void)loadMoreData {
    [[MINWebService sharedInstance] getFeedWithMinId:nil maxId:((MINPhoto *)[self.photos lastObject]).photoId andCompletion:^(NSError *error, NSArray *feedItems) {
        if (!error) {
            NSUInteger previousCount = self.photos.count;
            [self.photos addObjectsFromArray:feedItems];
            
            NSMutableArray *indexPaths = [NSMutableArray new];
            for (int i = 0; i < feedItems.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:previousCount+i inSection:0]];
            }
            
            [self.view.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellIdentifier = @"Cell";
     
     MINTimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (!cell) {
         cell = [[MINTimelineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }
     
     // Configure the cell...
     MINPhoto *photo = [self.photos objectAtIndex:indexPath.row];
     cell.asyncImageView.image = nil; // clear the previous image if the cell is being re-used
     [cell.asyncImageView setImageWithURL:photo.url];
     cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", photo.user];
     cell.captionLabel.text = photo.caption;
     
     return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.photos.count-3) {
        [self loadMoreData];
    }
}

@end
