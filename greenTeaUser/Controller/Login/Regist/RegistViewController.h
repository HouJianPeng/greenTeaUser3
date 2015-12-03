//
//  RegistViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/14.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RegistViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;     // 手机号
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;    // 验证码
@property (weak, nonatomic) IBOutlet UITextField *setupPasswordTextField;   // 设置密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField; // 确认密码
@property (weak, nonatomic) IBOutlet UIButton *gainVerificationButton;      // 获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *nextButton;                  // 下一页按钮
@property (weak, nonatomic) IBOutlet UITextField *accountTypeTextField;     // 账户类型
@property (strong, nonatomic) UIPickerView *accountTypePicker;

@end
