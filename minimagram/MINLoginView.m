//
//  MINLoginView.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-29.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINLoginView.h"
#import "UIFont+minimagram.h"
#import "UIColor+minimagram.h"

@interface MINLoginView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation MINLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"minimagr*m";
        self.titleLabel.font = [UIFont minimagramBoldFontWithSize:44];
        [self addSubview:self.titleLabel];
        
        self.subtitleLabel = [UILabel new];
        self.subtitleLabel.text = @"Get lost in your feed.";
        self.subtitleLabel.font = [UIFont minimagramRegularFontWithSize:18];
        [self addSubview:self.subtitleLabel];
        
        self.loginButton = [GSButton new];
        [self.loginButton setTitle:@"Sign in with Instagram" forState:UIControlStateNormal];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.titleLabel.font = [UIFont minimagramRegularFontWithSize:20];
        [self.loginButton setBackgroundColor:[UIColor minimagramBlueColor] forState:UIControlStateNormal];
        self.loginButton.layer.borderWidth = 1;
        self.loginButton.layer.borderColor = [UIColor minimagramBlueColor].CGColor;
        self.loginButton.layer.cornerRadius = 5;
        [self addSubview:self.loginButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(self.center.x, (1.0f/3.0f)*self.frame.size.height);
    
    [self.subtitleLabel sizeToFit];
    self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+10, self.subtitleLabel.frame.size.width, self.subtitleLabel.frame.size.height);
    self.subtitleLabel.center = CGPointMake(self.center.x, self.subtitleLabel.center.y);
    
    [self.loginButton sizeToFit];
    self.loginButton.frame = CGRectMake(0, 0, self.loginButton.frame.size.width+30, self.loginButton.frame.size.height+20);
    self.loginButton.center = CGPointMake(self.center.x, (2.0f/3.0f)*self.frame.size.height);
}

@end
