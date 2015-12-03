//
//  MenuCell.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/21.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (UINib *)nibWithCell {
    UINib *nib = [UINib nibWithNibName:kMenuCell bundle:[NSBundle mainBundle]];
    return nib;
}
@end
