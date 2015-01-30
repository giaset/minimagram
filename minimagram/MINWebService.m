//
//  MINWebService.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINWebService.h"

@implementation MINWebService

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURL = @"https://api.instagram.com/v1/";
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    return _sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        /*self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];*/
    }
    return self;
}

// GET user/self/feed

@end
