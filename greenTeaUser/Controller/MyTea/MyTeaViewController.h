//
//  MyTeaViewController.h
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BaseViewController.h"

/// 我的绿茶VC
@interface MyTeaViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UIButton *MyPay;
@property (weak, nonatomic) IBOutlet UIButton *perfectInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *theUserName;

@property (weak, nonatomic) IBOutlet UILabel *theUserPhone;



#pragma mark- 点击事件
- (IBAction)caseBtn:(id)sender;
- (IBAction)phonePay:(id)sender;
- (IBAction)infoPerfect:(id)sender;


@end
