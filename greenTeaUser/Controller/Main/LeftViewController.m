//
//  LeftViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "LeftViewController.h"

@class MainViewController;
#import "MainViewController.h"
#import "AboutMeViewController.h"
#import "FeedBackViewController.h"
#import "RecommendViewController.h"
#import <MMDrawerController.h>

#import "MenuCell.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MMDrawerController *drawerVC;

@property (nonatomic, strong) AboutMeViewController *aboutVC;
@property (nonatomic, strong) FeedBackViewController *feedBackVC;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.drawerVC = (MMDrawerController *)kRootViewController;
    self.aboutVC = [[AboutMeViewController alloc] init];
    self.feedBackVC = [[FeedBackViewController alloc] init];
    

    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[MenuCell nibWithCell] forCellReuseIdentifier:kMenuCell];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuCell forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        // 首页
        cell.lable.text = @"首页";
    } else if (indexPath.row == 1) {
        // 关于我们
        cell.lable.text = @"关于我们";
    } else if (indexPath.row == 2) {
        // 推荐
        cell.lable.text = @"推荐给好友";
    } else if (indexPath.row == 3) {
        // 意见反馈
        cell.lable.text = @"意见反馈";
    }
    
    cell.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu-0%ld", (indexPath.row + 1)]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MMDrawerController *drawerC = (MMDrawerController *)kRootViewController;
    if (indexPath.row == 0) {
        // 首页
        NSLog(@"首页");
        MainViewController *mainVC = [[MainViewController alloc]init];
        [drawerC closeDrawerAnimated:YES completion:^(BOOL finished) {
            drawerC.centerViewController = mainVC;
        }];
        
    } else if (indexPath.row == 1) {
        // 关于我们
        NSLog(@"关于我们");
        AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
        UINavigationController *aboutNavigation = [[UINavigationController alloc] initWithRootViewController:aboutVC];
        [drawerC closeDrawerAnimated:YES completion:^(BOOL finished) {
            drawerC.centerViewController = aboutNavigation;
        }];
        
    } else if (indexPath.row == 2) {
        // 推荐
        NSLog(@"推荐");
        RecommendViewController *recomVC = [[RecommendViewController alloc]init];
        UINavigationController *recomNavigation = [[UINavigationController alloc] initWithRootViewController:recomVC];
        [drawerC closeDrawerAnimated:YES completion:^(BOOL finished) {
            drawerC.centerViewController = recomNavigation;
        }];
        
        
    } else if (indexPath.row == 3) {
        // 意见反馈
        NSLog(@"意见反馈");
        FeedBackViewController *feedVC = [[FeedBackViewController alloc]init];
        UINavigationController *feedNavigation = [[UINavigationController alloc] initWithRootViewController:feedVC];
        [drawerC closeDrawerAnimated:YES completion:^(BOOL finished) {
            drawerC.centerViewController = feedNavigation;
        }];
        
    }
}

@end
