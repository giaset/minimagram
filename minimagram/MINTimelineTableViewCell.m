//
//  MINTimelineTableViewCell.m
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import "MINTimelineTableViewCell.h"

@implementation MINTimelineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat imageViewSize = [UIScreen mainScreen].bounds.size.width;
        self.asyncImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewSize, imageViewSize)];
        [self addSubview:self.asyncImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
