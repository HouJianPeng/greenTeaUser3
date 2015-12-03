//
//  lawyerCatViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "lawyerCatViewController.h"
#import "ConsultViewController.h"
@interface lawyerCatViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation lawyerCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
    self.title = @"法律直通车";
    _tableview.separatorStyle=NO;//分割线
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


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

- (IBAction)chatBtn:(id)sender {
    NSLog(@"立即咨询");
    ConsultViewController *OnlineVC = [[ConsultViewController alloc]init];
    [self.navigationController pushViewController:OnlineVC animated:YES];
}
@end
