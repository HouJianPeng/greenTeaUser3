//
//  HomePageTableViewCell.h
//  greenTeaLawyer
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHomePageTableViewCell @"HomePageTableViewCell"

@interface HomePageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tf_imageView;
@property (weak, nonatomic) IBOutlet UILabel *tf_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tf_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tf_dateLabel;


+ (UINib *)nibWithHomePageCell;
@end
