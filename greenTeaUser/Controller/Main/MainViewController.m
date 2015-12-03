//
//  MainViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MyTeaViewController.h"
#import "ConsultViewController.h"
#import "LeftViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MyTeaViewController *myTeaVC;
@property (nonatomic, strong) ConsultViewController *consultVC;
@property (nonatomic, strong) ConsultViewController *leftVC;

@property (nonatomic, strong) UINavigationController *homeNavigation;
@property (nonatomic, strong) UINavigationController *myTeaNavigation;
@property (nonatomic, strong) UINavigationController *consultNavigation;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    
    //self.tabBar.hidden = YES;//隐藏系统自带标签栏

    self.homeVC = [[HomeViewController alloc] init];
    self.homeVC.view.backgroundColor = [UIColor grayColor];
    self.homeVC.title = @"首页";
    
    self.homeVC.tabBarItem.tag = 0;
    self.homeVC.tabBarItem.image = [UIImage imageNamed:@"main1"];
    self.homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"main1"];
    

    self.myTeaVC = [[MyTeaViewController alloc] init];
    self.myTeaVC.title = @"我的绿茶";
    self.myTeaVC.tabBarItem.tag = 1;
    self.myTeaVC.tabBarItem.image = [UIImage imageNamed:@"tea"];
    self.myTeaVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tea"];
   
    
    self.consultVC = [[ConsultViewController alloc] init];
    self.consultVC.title = @"咨询";
    self.consultVC.tabBarItem.tag = 2;
    self.consultVC.tabBarItem.image = [UIImage imageNamed:@"mian3"];
    self.consultVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mian3"];
    
    self.homeNavigation= [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    self.myTeaNavigation = [[UINavigationController alloc] initWithRootViewController:self.myTeaVC];
    self.consultNavigation = [[UINavigationController alloc] initWithRootViewController:self.consultVC];
    self.viewControllers = @[self.homeNavigation, self.myTeaNavigation, self.consultNavigation];
    self.selectedIndex = 0;
    self.delegate = self;
 
      self.tabBar.selectedImageTintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.title = item.title;
}


-(void)getThePersonInfo{
    NSString* str = [NSString stringWithFormat:@"http://chat.looyuoms.com//cosmos.json?command=scommerce.LC_ACC_ACCOUNT_GET&userId%@",[AccountManager sharedInstance].account.userId];
//    NSString*userId = [AccountManager sharedInstance].account.userId;
//    NSDictionary*dic = @{@"userId":userId};
    [NetWork POST:str parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",myDic);
    }];
    
}

@end
