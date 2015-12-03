//
//  AccountManager.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "AccountManager.h"
#import "Account.h"

#import "LoginViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import <MMDrawerVisualState.h>
#import "EntrustSuccessViewController.h"
#import "CaseViewController.h"
#import "InCaseViewController.h"
#import "PersonINfo.h"
#import "MyTeaViewController.h"


@implementation AccountManager

static AccountManager *sharedInstance;
#pragma mark Singleton Model
+ (AccountManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AccountManager alloc]init];
        sharedInstance.account = [[Account alloc] init];
        sharedInstance.userInfo = [[PersonINfo alloc] init];
        [sharedInstance loadAccountInfoFromDisk];
        
    });
    return sharedInstance;
}

- (BOOL)isLogin
{
    return [self.account.isLogin isEqualToString:@"yes"] ? YES : NO;
}


#pragma mark - Save user info

- (void)saveAccountInfoToDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:self.account.userId forKey:@"userId"];
    [ud setValue:self.account.displayName forKey:@"displayName"];
    [ud setValue:self.account.userType forKey:@"userType"];
    [ud setValue:self.account.isLogin forKey:@"isLogin"];
    [ud setValue:self.account.isAudited forKey:@"isAudited"];
    [ud setValue:self.account.districtId forKey:@"districtId"];
    [ud synchronize];
}

- (void)loadAccountInfoFromDisk
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.account.userId = [ud objectForKey:@"userId"];
    self.account.userType = [ud objectForKey:@"userType"];
    self.account.displayName = [ud objectForKey:@"displayName"];
    self.account.isLogin = [ud objectForKey:@"isLogin"];
    self.account.isAudited = [ud objectForKey:@"isAudited"];
    [ud setValue:self.account.districtId forKey:@"districtId"];
}

+ (void)changeRootVCWithMMDrawer {
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc] init];
//    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    MMDrawerController *drawerVC = [[MMDrawerController alloc] initWithCenterViewController:mainVC leftDrawerViewController:leftVC];
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    kRootViewController = drawerVC;
}

+ (void)changeRootVCWithLogin {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *loginNavigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    kRootViewController = loginNavigation;
}





@end
