//
//  MINWebViewController.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINWebViewController.h"
#import "UIColor+minimagram.h"

@interface MINWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) void (^successBlock)(NSString *token);

@end

@implementation MINWebViewController

- (instancetype)initWithSuccessBlock:(void (^)(NSString *token))successBlock {
    self = [super init];
    if (self) {
        self.successBlock = successBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign in with Instagram";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor minimagramBlueColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *clientId = @"5365f32edd7740b593f822f652211882";
    NSString *redirectUri = @"http://www.miltonandparc.com";
    NSString *loginUrl = [NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token", clientId, redirectUri];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loginUrl]]];
}

- (void)cancelButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    
    if ([url.host isEqualToString:@"www.miltonandparc.com"]) {
        NSString *token = [[url.fragment componentsSeparatedByString:@"="] lastObject];
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.successBlock) {
                self.successBlock(token);
            }
        }];
        return NO;
    }
    
    return YES;
}

@end
