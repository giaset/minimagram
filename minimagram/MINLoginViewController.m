//
//  MINLoginViewController.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINLoginViewController.h"
#import "MINLoginView.h"
#import "MINWebViewController.h"
#import "MINTimelineTableViewController.h"

@interface MINLoginViewController ()

@property (nonatomic, strong) MINLoginView *view;

@end

@implementation MINLoginViewController

- (void)loadView {
    self.view = [[MINLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (token) {
        [self.navigationController pushViewController:[MINTimelineTableViewController new] animated:NO];
    }
}

- (void)loginButtonPressed {
    MINWebViewController *webViewController = [[MINWebViewController alloc] initWithSuccessBlock:^(NSString *token) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:[MINTimelineTableViewController new] animated:YES];
    }];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

@end
