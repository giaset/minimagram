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
}

- (void)loginButtonPressed {
    MINWebViewController *webViewController = [[MINWebViewController alloc] initWithSuccessBlock:^(NSString *token) {
        NSLog(@"%@", token);
    }];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:webViewController] animated:YES completion:nil];
}

@end
