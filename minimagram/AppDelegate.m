//
//  AppDelegate.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-28.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "AppDelegate.h"
#import "MINLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *rootNavController = [[UINavigationController alloc] initWithRootViewController:[MINLoginViewController new]];
    rootNavController.navigationBarHidden = YES;
    
    self.window.rootViewController = rootNavController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
