//
//  MINTimelineView.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-28.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINTimelineView.h"

@interface MINTimelineView()

@property (nonatomic, strong) UIView *statusBarBackgroundView;

@end

@implementation MINTimelineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [UITableView new];
        [self addSubview:self.tableView];
        
        self.statusBarBackgroundView = [UIView new];
        self.statusBarBackgroundView.backgroundColor = [UIColor redColor];
        [self addSubview:self.statusBarBackgroundView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.frame;
    self.statusBarBackgroundView.frame = CGRectMake(0, 0, self.frame.size.width, 20);
}

@end
