//
//  MINTimelineTableViewCell.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINTimelineTableViewCell.h"
#import "UIColor+minimagram.h"
#import "UIFont+minimagram.h"

@interface MINTimelineTableViewCell()

@property (nonatomic, strong) UIView *coloredOverlayView;
@property (nonatomic, strong) UIView *dashView;

@end

@implementation MINTimelineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.asyncImageView = [UIImageView new];
        [self addSubview:self.asyncImageView];
        
        self.coloredOverlayView = [UIView new];
        self.coloredOverlayView.alpha = 0.7;
        [self addSubview:self.coloredOverlayView];
        
        self.dashView = [UIView new];
        [self addSubview:self.dashView];
        
        self.usernameLabel = [UILabel new];
        self.usernameLabel.textColor = [UIColor whiteColor];
        self.usernameLabel.font = [UIFont minimagramBoldFontWithSize:28];
        self.usernameLabel.alpha = 0;
        self.usernameLabel.hidden = YES;
        [self addSubview:self.usernameLabel];
        
        self.captionLabel = [UILabel new];
        self.captionLabel.textColor = [UIColor whiteColor];
        self.captionLabel.font = [UIFont minimagramRegularFontWithSize:18];
        self.captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.captionLabel.numberOfLines = 0;
        self.captionLabel.textAlignment = NSTextAlignmentCenter;
        self.captionLabel.alpha = 0;
        self.captionLabel.hidden = YES;
        [self addSubview:self.captionLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    BOOL realSelected = (self.selected && selected) ? NO : selected;
    
    [super setSelected:realSelected animated:animated];
    
    /* This works because when a UITableViewCell is set to selected, all its subviews' background colors are set to nil in the default implementation, so all I need to do is set the selected cell's background color here */
    if (realSelected) {
        self.usernameLabel.hidden = NO;
        self.captionLabel.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.coloredOverlayView.backgroundColor = [UIColor minimagramBlueColor];
            self.dashView.backgroundColor = [UIColor whiteColor];
            self.usernameLabel.alpha = 1;
            self.captionLabel.alpha = 1;
        }];
    } else {
        self.usernameLabel.alpha = 0;
        self.usernameLabel.hidden = YES;
        self.captionLabel.alpha = 0;
        self.captionLabel.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.asyncImageView.frame = self.bounds;
    self.coloredOverlayView.frame = self.bounds;
    
    CGSize dashSize = CGSizeMake(self.bounds.size.width/8.0f, self.bounds.size.height/64.0f);
    self.dashView.frame = CGRectMake((self.bounds.size.width/2.0f)-(dashSize.width/2.0f), (self.bounds.size.height/2.0f)-(dashSize.height/2.0f), dashSize.width, dashSize.height);
    
    [self.usernameLabel sizeToFit];
    self.usernameLabel.frame = CGRectMake((self.bounds.size.width/2.0f)-(self.usernameLabel.frame.size.width/2.0f), (self.bounds.size.height/3.0f)-(self.usernameLabel.frame.size.height/2.0f), self.usernameLabel.frame.size.width, self.usernameLabel.frame.size.height);
    
    self.captionLabel.frame = CGRectMake(0, 0, self.bounds.size.width-20, 0); // set a fixed with for this label
    [self.captionLabel sizeToFit];
    self.captionLabel.frame = CGRectMake((self.bounds.size.width/2.0f)-(self.captionLabel.frame.size.width/2.0f), (2.0f*self.bounds.size.height/3.0f)-(self.captionLabel.frame.size.height/2.0f), self.captionLabel.frame.size.width, self.captionLabel.frame.size.height);
}

@end
