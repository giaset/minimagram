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
    }
    return self;
}

- (void)getFeedWithMinId:(NSString *)minId maxId:(NSString *)maxId andCompletion:(void (^)(NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"access_token"] = self.token;
    
    if (minId) {
        params[@"min_id"] = minId;
    }
    
    if (maxId) {
        params[@"max_id"] = maxId;
    }
    
    [self GET:@"users/self/feed" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSArray *mediaArray = responseDict[@"data"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            for (NSDictionary *mediaItem in mediaArray) {
                NSString *url = mediaItem[@"images"][@"standard_resolution"][@"url"];
                NSString *user = mediaItem[@"user"][@"username"];
                NSString *caption = @"";
                if (mediaItem[@"caption"] != [NSNull null]) {
                    caption = mediaItem[@"caption"][@"text"];
                }
                NSString *photoId = mediaItem[@"id"];
                
                [MINPhoto createOrUpdateInRealm:realm withObject:@{@"url": url, @"user": user, @"caption": caption, @"photoId": photoId}];
            }
            [realm commitWriteTransaction];
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil);
                });
            }
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(error);
        }
    }];
}

@end
