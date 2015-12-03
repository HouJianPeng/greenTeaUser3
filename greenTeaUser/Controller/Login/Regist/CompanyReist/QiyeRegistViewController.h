//
//  QiyeRegistViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/29.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiyeRegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;   // 公司名称
@property (weak, nonatomic) IBOutlet UITextField *legalTexField;          // 法人代表
@property (weak, nonatomic) IBOutlet UITextField *registNumberTextField;  // 注册号
@property (weak, nonatomic) IBOutlet UITextField *registCapitalTextField; // 注册资本
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;       // 住所

@property (nonatomic, copy)NSString *phoneNumber;    // 手机号
@property (nonatomic, copy)NSString *password;       // 密码
@property (nonatomic, copy)NSString *verification;   // 验证码
@property (nonatomic, copy)NSString *userType;       // 账户类型

@end
