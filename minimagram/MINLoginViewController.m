//
//  MINLoginViewController.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINLoginViewController.h"
#import "MINLoginView.h"

@interface MINLoginViewController ()

@property (nonatomic, strong) MINLoginView *view;

@end

@implementation MINLoginViewController

- (void)loadView {
    self.view = [[MINLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
