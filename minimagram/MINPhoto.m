//
//  MINPhoto.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINPhoto.h"

@implementation MINPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _url = [NSURL URLWithString:dict[@"url"]];
        _user = [dict[@"user"] copy];
        _caption = [dict[@"caption"] copy];
    }
    return self;
}

@end
