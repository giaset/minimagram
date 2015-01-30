//
//  UIFont+minimagram.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "UIFont+minimagram.h"

@implementation UIFont (minimagram)

+ (UIFont *)minimagramBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Gotham-Black" size:size];
}

+ (UIFont *)minimagramRegularFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Gotham-Book" size:size];
}

@end
