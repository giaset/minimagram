//
//  GSButton.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "GSButton.h"

@interface GSButton()

@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

@end

@implementation GSButton

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            _normalBackgroundColor = backgroundColor;
            self.backgroundColor = backgroundColor;
            _highlightedBackgroundColor = [self generateSlightlyDarkerColor:backgroundColor];
            break;
            
        case UIControlStateHighlighted:
            _highlightedBackgroundColor = backgroundColor;
            break;
            
        default:
            break;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = (highlighted) ? self.highlightedBackgroundColor : self.normalBackgroundColor;
}

// Generate a color that is slightly darker than the given one
- (UIColor *)generateSlightlyDarkerColor:(UIColor *)originalColor {
    CGFloat hue, saturation, brightness, alpha;
    if ([originalColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness*0.75 alpha:alpha];
    } else {
        return nil;
    }
}

@end
