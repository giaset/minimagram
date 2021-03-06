//
//  MINTimelineView.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-28.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINTimelineView.h"
#import "UIColor+minimagram.h"
#import "UIFont+minimagram.h"

@interface MINTimelineView()

@property (nonatomic, strong) UIView *statusBarBackgroundView;
@property (nonatomic, strong) UILabel *statusBarLabel;

@end

@implementation MINTimelineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [UITableView new];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
        self.statusBarBackgroundView = [UIView new];
        self.statusBarBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.statusBarBackgroundView];
        
        self.statusBarLabel = [UILabel new];
        self.statusBarLabel.text = @"minimagr*m";
        self.statusBarLabel.textColor = [UIColor minimagramBlueColor];
        self.statusBarLabel.font = [UIFont minimagramBoldFontWithSize:12];
        [self addSubview:self.statusBarLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat statusBarHeight = 28;
    
    self.statusBarBackgroundView.frame = CGRectMake(0, 0, self.frame.size.width, statusBarHeight);
    self.tableView.frame = CGRectMake(0, statusBarHeight, self.frame.size.width, self.frame.size.height-statusBarHeight);
    
    [self.statusBarLabel sizeToFit];
    self.statusBarLabel.center = CGPointMake(self.center.x, self.statusBarBackgroundView.center.y);
}

@end
