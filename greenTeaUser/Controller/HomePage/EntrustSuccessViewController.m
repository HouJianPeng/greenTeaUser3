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
    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
    
    
    
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
