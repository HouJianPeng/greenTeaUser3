//
//  AboutMeViewController.m
//  greenTeaUser
//
//  Created by chenTengfei on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *detialTextView;

@property (weak, nonatomic) IBOutlet UIView *Callwe;
@property (weak, nonatomic) IBOutlet UIView *Gsview;
@property (weak, nonatomic) IBOutlet UITextView *gsTextView;
@property (weak, nonatomic) IBOutlet UITextView *callweTextView;


@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"关于我们";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    _comPayBtn.selected=YES;//默认选择简介
    _Callwe.hidden=YES;
    self.gsTextView.editable = NO;
    self.callweTextView.editable = NO;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)doBack:(UIButton *)sender
{
    [AccountManager changeRootVCWithMMDrawer];
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

- (IBAction)comPayBtn:(id)sender {
    NSLog(@"公司简介");
    _Gsview.hidden=NO;
    _Callwe.hidden=YES;
    
    }

- (IBAction)conUsBtn:(id)sender {
    NSLog(@"联系我们");
    _Gsview.hidden=YES;
    _Callwe.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^{
       
    } completion:^(BOOL finished) {
        
    }];
   
    
}
@end
