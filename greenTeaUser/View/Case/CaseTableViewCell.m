//
//  CaseTableViewCell.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "CaseTableViewCell.h"

@implementation CaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
