//
//  MINWebService.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINWebService.h"
#import "MINPhoto.h"

@interface MINWebService()

@property (nonatomic, strong) NSString *token;

@end

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
        self.token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
        /*self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];*/
    }
    return self;
}

- (void)getFeedWithCompletion:(void (^)(NSError *error, NSArray *feedItems))completion {
    [self GET:@"users/self/feed" parameters:@{@"access_token": self.token} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSArray *mediaArray = responseDict[@"data"];
        NSMutableArray *returnArray = [NSMutableArray new];
        for (NSDictionary *mediaItem in mediaArray) {
            NSString *url = mediaItem[@"images"][@"standard_resolution"][@"url"];
            NSString *user = mediaItem[@"user"][@"username"];
            NSString *caption = @"";
            if (mediaItem[@"caption"] != [NSNull null]) {
                caption = mediaItem[@"caption"][@"text"];
            }
            MINPhoto *photo = [[MINPhoto alloc] initWithDictionary:@{@"url": url, @"user": user, @"caption": caption}];
            [returnArray addObject:photo];
        }
        if (completion) {
            completion(nil, returnArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error, nil);
        }
    }];
}

@end
