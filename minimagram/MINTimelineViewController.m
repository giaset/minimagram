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

@interface MINTimelineTableViewController ()

@property (nonatomic, strong) MINTimelineView *view;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MINTimelineTableViewController

#pragma mark - View controller lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.images = [NSMutableArray new];
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
    [self.view.tableView registerClass:[MINTimelineTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self loadData];
}

/* You can only assign a UIRefreshControl to a UITableViewController, so we create a "fake" one to control our tableView */
- (void)setupPullToRefresh {
    UITableViewController *tableViewController = [UITableViewController new];
    tableViewController.tableView = self.view.tableView;
    
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.backgroundColor = [UIColor minimagramBlueColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    tableViewController.refreshControl = self.refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)loadData {
    [[MINWebService sharedInstance] getFeedWithCompletion:^(NSError *error, NSArray *feedItems) {
        [self.refreshControl endRefreshing];
        if (!error) {
            [self.images addObjectsFromArray:feedItems];
            [self.view.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 MINTimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width;
}

@end
