//
//  accountViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/30.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "accountViewController.h"
#import "PhoneViewController.h"
@interface accountViewController ()

@end

@implementation accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.title = @"我的账户";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

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

- (IBAction)chongzhiBtn:(id)sender {
    NSLog(@"充值");
    NSLog(@"%@",self.navigationController);
    PhoneViewController *phoneVC = [[PhoneViewController alloc]init];
    [self.navigationController pushViewController:phoneVC animated:YES];
    
}
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
