//
//  EntrustSuccessViewController.m
//  greenTeaUser
//
//  Created by Herron on 15/7/9.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "EntrustSuccessViewController.h"
#import "CaseViewController.h"
#import "CaseConsignViewController.h"

@interface EntrustSuccessViewController ()

@end

@implementation EntrustSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"案件发布";
    [self loadBlackButton];
    self.navigationController.navigationBar.translucent = NO;
    NSLog(@"%@",self.lawcaseNo);
    self.theLawcaseNoLabel.text = [NSString stringWithFormat:@"案件编号: %@",self.lawcaseNo];
//    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
 
    
}
-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setTitle:@"" forState:(UIControlStateNormal)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (IBAction)publishAnotherCaseClick:(id)sender
{
    CaseConsignViewController *caseConsignViewController = [[CaseConsignViewController alloc] init];
    [self.navigationController pushViewController:caseConsignViewController animated:YES];
}

- (IBAction)dealCaseClick:(id)sender
{
    CaseViewController *caseViewController = [[CaseViewController alloc] init];
    [self.navigationController pushViewController:caseViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
