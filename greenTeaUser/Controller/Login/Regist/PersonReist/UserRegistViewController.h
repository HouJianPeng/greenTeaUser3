//
//  UserRegistViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/29.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *personNameTextField; // 姓名
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;           // 性别
@property (weak, nonatomic) IBOutlet UITextField *idNumberTextField;   // 身份证号
@property (weak, nonatomic) IBOutlet UITextField *borthDayTextField;   // 出生日期
@property (weak, nonatomic) IBOutlet UITextField *officeTextField;     // 发证机关

@property (nonatomic, copy)NSString *phoneNumber;  // 手机号
@property (nonatomic, copy)NSString *password;     // 密码
@property (nonatomic, copy)NSString *verification; // 验证码
@property (nonatomic, copy)NSString *userType;     // 账户类型


@end
