//
//  HomePageTableViewCell.m
//  greenTeaLawyer
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (UINib *)nibWithHomePageCell {
    UINib *nib = [UINib nibWithNibName:kHomePageTableViewCell bundle:nil];
    return nib;
}
@end
