//
//  PhoneViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"支付中心";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


#pragma mark -Button点击事件


/**
 *  微信支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)weiChatBtn:(id)sender
{
    NSLog(@"微信支付");
    
}
/**
 *  支付宝支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)AirPayBtn:(id)sender
{
    NSLog(@"支付宝支付");
    
}
/**
 *  财付通支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)tenPayBtn:(id)sender
{
    NSLog(@"财付通支付");
    
}
/**
 *  返回按钮
 *
 *  @param sender @author 侯建鹏
 */


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
