//
//  MINWebService.h
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "AFNetworking.h"

@interface MINWebService : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (void)getFeedWithMinId:(NSString *)minId maxId:(NSString *)maxId andCompletion:(void (^)(NSError *error, NSArray *feedItems))completion;

@end
