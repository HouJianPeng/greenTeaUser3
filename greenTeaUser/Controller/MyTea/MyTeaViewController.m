//
//  MyTeaViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "MyTeaViewController.h"
#import "InfoViewController.h"
#import "CaseViewController.h"
#import "AccountManager.h"

/*!
 *  @brief  我的绿茶 董森森&付海宇
 */
@interface MyTeaViewController ()<UIAlertViewDelegate>

@property (nonatomic, retain) UIAlertView *caseManagerAlert; // 案件管理登录提示框
@property (nonatomic, retain) UIAlertView *infoAlert;        // 资料完善登录提示框
@property (nonatomic, retain) UIAlertView *myAccountAlert;   // 我的账户提示框
@property (nonatomic, retain) UIAlertView *logoutAlert;      // 退出登录提示框

@end

@implementation MyTeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的绿茶";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"" forState:(UIControlStateNormal)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.logoutButton addTarget:self action:@selector(getAlert) forControlEvents:(UIControlEventTouchUpInside)];
    [self theUserIsLogin];

}

#pragma mark - 判断登录
- (void)theUserIsLogin{
    if ( [[AccountManager sharedInstance].account.isLogin isEqualToString:@"yes"]) {
        self.theUserName.text =[AccountManager sharedInstance].account.displayName;
        [self.logoutButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tuichu"]] forState:UIControlStateNormal];
    }
    else{
        self.theUserName.text =@"未登录";
        [self.logoutButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"login4"]] forState:UIControlStateNormal];
    }
}

#pragma mark - 退出登录点击事件
- (void)getAlert{
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"yes"]) {
        self.logoutAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要退出" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        self.logoutAlert.delegate = self;
        [self.logoutAlert show];
    } else {
        [AccountManager changeRootVCWithLogin];
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 如果调用了退出登录的提示框
    if (alertView == self.logoutAlert) {
        // 如果点击确定，退出登录
        if (buttonIndex == 0) {
            [self theLogoutButtonClick];
        }
    }
    // 如果调用了案件管理的提示框
    else if (alertView == self.caseManagerAlert) {
        // 如果点击确定，跳转至登录页
        if (buttonIndex == 0) {
            [AccountManager changeRootVCWithLogin];
        }
    }
    // 如果调用了我的账户的提示框
    else if (alertView == self.infoAlert) {
        // 点击确定，跳转至登陆页
        if (buttonIndex == 0) {
            [AccountManager changeRootVCWithLogin];
        }
    } else {
    }
}


#pragma mark - 退出登录
- (void)theLogoutButtonClick{
   NSString*str = [NSString stringWithFormat:@"%@scommerce.SC_SYS_LOGOUT", SERVER_HOST_PRODUCT];
    [NetWork POST:str parmater:nil Block:^(NSData *data) {
        // 如果请求到数据
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",myDic);
            [self.logoutButton setBackgroundImage:[UIImage imageNamed:@"login4"] forState:UIControlStateNormal];
            [AccountManager sharedInstance].account.isLogin = @"no";
            [AccountManager sharedInstance].account.displayName = @"";
            [[AccountManager sharedInstance] saveAccountInfoToDisk];
            [AccountManager changeRootVCWithMMDrawer];
        }
    }];

}


#pragma mark - 案件管理点击事件
- (IBAction)caseBtn:(id)sender {
    NSLog(@"案件管理");
    // 如果账户已经登录
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"yes"]) {        CaseViewController *caseViewController = [[CaseViewController alloc] init];
        [self.navigationController pushViewController:caseViewController animated:YES];
    } else {
        self.caseManagerAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未登录, 请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [self.caseManagerAlert show];
    }
}


#pragma mark - 我的账户点击事件
- (IBAction)phonePay:(id)sender {
    NSLog(@"我的账户");
    self.myAccountAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能暂未开通" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.myAccountAlert show];
}


#pragma mark - 资料完善点击事件
- (IBAction)infoPerfect:(id)sender {
    NSLog(@"资料完善");
    if ([[AccountManager sharedInstance].account.isLogin isEqualToString:@"yes"]) {
        InfoViewController *infoVC = [[InfoViewController alloc]init];
        [self.navigationController pushViewController:infoVC animated:YES];
    } else {
        self.caseManagerAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您未登录, 请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [self.caseManagerAlert show];
    }
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
