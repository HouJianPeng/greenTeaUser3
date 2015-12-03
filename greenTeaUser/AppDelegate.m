//
//  AppDelegate.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController.h>
#import "MainViewController.h"
#import "LeftViewController.h"
#import "HomeViewController.h"
#import <MMDrawerController.h>
#import "LoginViewController.h"
#import "GuidanceViewController.h"

#define kVersionKey @"version"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window  makeKeyAndVisible];
    
    [AccountManager changeRootVCWithMMDrawer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:LoginSucessedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:LogOutNotification object:nil];
    
    // MagicalRecord初始化
    [MagicalRecord setShouldAutoCreateManagedObjectModel:NO];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GreenTeaUser" withExtension:@"momd"];
    NSManagedObjectModel *objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    [NSManagedObjectModel MR_setDefaultManagedObjectModel:objectModel];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"GreenTeaUser"];
    
    [NSThread sleepForTimeInterval:2];//启动页面停留2S
    
    
    // ---- 第一次启动当前版本 ----
    // 获取Info.plist
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 获取当前用户的软件版本
    NSString *currentVersion = infoDict[@"CFBundleVersion"];
    // 获取上一次最新的版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
    
    if (![currentVersion isEqualToString:lastVersion]) {
        // 如果是新版本
        GuidanceViewController *guidanceVC = [[GuidanceViewController alloc] init];
        self.window.rootViewController = guidanceVC;
        
        // 存储新版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [AccountManager changeRootVCWithMMDrawer];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 登录通知
- (void)loginSuccessed {
    [AccountManager changeRootVCWithMMDrawer];
}

- (void)logOut {
    [AccountManager changeRootVCWithLogin];
}
@end
