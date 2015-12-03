//
//  MenuCell.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/21.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMenuCell @"MenuCell"
@interface MenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

+ (UINib *)nibWithCell;

@end
