//
//  AboutMeViewController.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//


#import "BaseViewController.h"


/// 关于我们VC
@interface AboutMeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *comPayBtn;//公司简介
@property (weak, nonatomic) IBOutlet UIButton *conUsBtn;//联系我们
@property (weak, nonatomic) IBOutlet UIImageView *bakgroundImg;//背景图片


/**
 *  @author 侯建鹏
 *
 *  @brief  公司简介
 *
 *  @param sender 公司简介按钮
 */
- (IBAction)comPayBtn:(id)sender;
/**
 *  @author 侯建鹏
 *
 *  @brief  联系我们
 *
 *  @param sender 联系我们按钮
 */
- (IBAction)conUsBtn:(id)sender;

@end
