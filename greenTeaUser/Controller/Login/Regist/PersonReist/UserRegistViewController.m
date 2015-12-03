//
//  UserRegistViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/29.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "UserRegistViewController.h"
#import "ChangeSuccessViewController.h"
#import "NSString+Validation.h"
#import "TFDatePickerView.h"
#import "NetWork.h"
#import "NetworkMacro.h"

@interface UserRegistViewController ()<TFDatePickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@end

@implementation UserRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人用户注册";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.personNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    self.genderTextField.delegate = self;
    self.borthDayTextField.delegate = self;
}


#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.genderTextField) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"性别:" message:nil delegate:self cancelButtonTitle:@"男" otherButtonTitles:@"女", nil];
        [alert show];
        return NO;
    }
    if (textField == self.borthDayTextField) {
        TFDatePickerView *datePickerView = [TFDatePickerView tfDatePickerViewWithDatePickerMode:UIDatePickerModeDate Delegate:self];
        [datePickerView tf_show];
        return NO;
    }
    return NO;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.genderTextField.text = @"男";
            break;
        case 1:
            self.genderTextField.text = @"女";
            break;
        default:
            break;
    }
}



#pragma mark - DatePickerViewDelegate
- (BOOL)submitWithSelectedDate:(NSDate *)selectedDate
{
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:selectedDate] == NSOrderedAscending) {
        return NO;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:selectedDate];
    
    NSLog(@"%@", dateStr);
    
    self.borthDayTextField.text = dateStr;
    
    
    return YES;
}


#pragma mark - 点击立即注册
- (IBAction)registNowAction:(id)sender
{
    // 检查输入 如果输入正确就发送注册请求
    if ([self checkList]) {
        
        NSDictionary *dic = [self appendParmater];
        
        [NetWork GET:RegistURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dataDic == %@", dataDic);
            
            NSDictionary *accountDic = [[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"CL_ACC_ACCOUNT_REGISTER_ACTION"] objectForKey:@"object"];
            
            NSString *success = [accountDic objectForKey:@"success"];
            NSLog(@"success = %@", success);
            
            NSNumber *result = (NSNumber *)success;
            if ([result isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                Account *account = [Account initAccount:accountDic];
                [AccountManager sharedInstance].account = account;
                [[AccountManager sharedInstance] saveAccountInfoToDisk];

                
                ChangeSuccessViewController *success = [[ChangeSuccessViewController alloc] init];
                success.showStr = @"注册成功";
                [self.navigationController pushViewController:success animated:YES];
                
                
            }else if ([result isEqualToNumber:[NSNumber numberWithInt:2]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名已经存在" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];

            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];

            }
        }];
    }
    
}


#pragma mark - 拼接请求参数
- (NSDictionary *)appendParmater
{
    NSDictionary *extensionsDic =@{
                                   @"accountType":@"individual",
                                   @"idCard":self.idNumberTextField.text,
                                   @"issuingAuthority":self.officeTextField.text};
    NSString *extensionsStr = [self transformWithDictionary:extensionsDic];
    
    NSDictionary *parmater = @{@"mcode":self.verification,
             @"gender":self.genderTextField.text,
             @"validateEvent":@"register",
             @"validateObject":self.phoneNumber,
             @"validateType":@"mobile",
             @"userName":self.phoneNumber,
             @"realName":self.personNameTextField.text,
             @"userType":@"individual",
             @"mobile":self.phoneNumber,
             @"userPassword":self.password,
             @"isMobileChecked":@"true",
             @"birthday":self.borthDayTextField.text,
             @"exts":@"{}",
             @"locked":@"false",
             @"login":@"true",
             @"extensions":extensionsStr};
    return parmater;
}


#pragma mark - 将字典转换成扩展字符串
- (NSString *)transformWithDictionary:(NSDictionary *)dic
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@<paramValue>%@<paramSplit>", key, [dic objectForKey:key]];
        [string appendString:str];
    }
    
    return string;
}


#pragma mark - 检查输入
- (BOOL)checkList
{
    if ([self.personNameTextField.text length]) {
        if ([self.genderTextField.text length] != 0) {
            
            if ([self.idNumberTextField.text length] == 18) {
                
                if ([self.borthDayTextField.text length]) {
                    if ([self.officeTextField.text length]) {
                        return YES;
                    } else {
                        [self showAlertWithTitle:@"请输入签证机关" cancelButtonTitle:@"确定"];
                        return NO;
                    }
                } else {
                    [self showAlertWithTitle:@"请输入出生日期" cancelButtonTitle:@"确定"];
                    return NO;
                }
            }else {
                [self showAlertWithTitle:@"身份证号位数不正确" cancelButtonTitle:@"确定"];
                self.idNumberTextField.text = @"";
                return NO;
            }
            
        }else {
            return NO;
        }
        
    }else {
        [self showAlertWithTitle:@"请输入完整信息" cancelButtonTitle:@"确定"];
        return NO;
        }
    
    return NO;
}


#pragma mark - 提示框
- (void)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - 返回上级页面
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
