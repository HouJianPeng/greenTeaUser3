//
//  QiyeRegistViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/29.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "QiyeRegistViewController.h"
#import "ChangeSuccessViewController.h"
#import "NSString+Validation.h"
#import "NetWork.h"
#import "NetworkMacro.h"

@interface QiyeRegistViewController ()

@end

@implementation QiyeRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业用户注册";
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.companyNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.legalTexField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.registNumberTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.registCapitalTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.addressTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
}


#pragma mark - 立即注册
- (IBAction)registNowAction:(id)sender
{
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
                                   @"accountType":@"company",
                                   @"companyName":self.companyNameTextField.text,
                                   @"legalRepresentative":self.legalTexField.text,
                                   @"registrationNumber":self.registNumberTextField.text,
                                   @"registeredAssets":self.registCapitalTextField.text,
                                   @"residence":self.addressTextField.text};
    NSString *extensionsStr = [self transformWithDictionary:extensionsDic];
    
    NSDictionary *parmater = @{@"mcode":self.verification,
                               @"validateEvent":@"register",
                               @"validateObject":self.phoneNumber,
                               @"validateType":@"mobile",
                               @"userName":self.phoneNumber,
                               @"userType":@"company",
                               @"mobile":self.phoneNumber,
                               @"userPassword":self.password,
                               @"isMobileChecked":@"true",
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
    if ([self.companyNameTextField.text length]) {
        if ([self.legalTexField.text length]) {
            if ([self.registNumberTextField.text length]) {
                if ([self.registCapitalTextField.text length]) {
                    if ([self.addressTextField.text length]) {
                        return YES;
                    }else {
                        [self showAlertWithTitle:@"请输入住所" cancelButtonTitle:@"确定"];
                        return NO;
                    }
                }else {
                    [self showAlertWithTitle:@"请输入注册资本" cancelButtonTitle:@"确定"];
                    return NO;
                }
            }else {
                [self showAlertWithTitle:@"请输入注册号" cancelButtonTitle:@"确定"];
                return NO;
            }
        }else {
            [self showAlertWithTitle:@"请输入法人代表" cancelButtonTitle:@"确定"];
            return NO;
        }
    }else {
        [self showAlertWithTitle:@"请输入公司名" cancelButtonTitle:@"确定"];
        return NO;
    }
    
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
