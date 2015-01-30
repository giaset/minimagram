//
//  MINWebViewController.h
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MINWebViewController : UIViewController

- (instancetype)initWithSuccessBlock:(void (^)(NSString *token))successBlock;

@end
