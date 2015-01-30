//
//  MINPhoto.h
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MINPhoto : NSObject

@property (nonatomic, copy, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *user;
@property (nonatomic, copy, readonly) NSString *caption;
@property (nonatomic, copy, readonly) NSString *photoId;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
