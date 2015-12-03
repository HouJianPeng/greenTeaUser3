//
//  accountViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/30.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface accountViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *touxiangimg;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//姓名
@property (weak, nonatomic) IBOutlet UILabel *callLabel;//电话号

@property (weak, nonatomic) IBOutlet UILabel *zhanghuLab;//账户
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;//余额多少

@property (weak, nonatomic) IBOutlet UILabel *hongbaoLab;//绿茶红包
@property (weak, nonatomic) IBOutlet UILabel *jineLab;//红包金额

/**
 *  充值
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)chongzhiBtn:(id)sender;


@end
