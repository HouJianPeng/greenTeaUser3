//
//  InfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InfoViewController.h"
#import "ChangeEmailViewController.h"
#import "NetWorkMacro.h"
#define kContentScrollerViewHeight self.contentScrollView.frame.size.height
#define SERVER_HOST_PRODUCT_Info  @"http://www.lawcheck.com.cn"
@interface InfoViewController ()<UIScrollViewDelegate, BasicInfoViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *infoArray;
@property (nonatomic, retain) NSMutableArray *idCardArray;

@end

@implementation InfoViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self.basicInfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.infoArray = [NSMutableArray array];
    self.idCardArray = [NSMutableArray array];

    self.title = @"资料完善";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    //设置scrollView
    self.contentScrollView.contentSize = CGSizeMake(kScreenBoundWidth * 2, 0);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    self.contentScrollView.scrollEnabled = NO;
    self.contentScrollView.delegate = self;
    [self netWork];
}


     
- (void)netWork
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_ACCOUNT_GET&userId=%@", SERVER_HOST_PRODUCT, userId];
    
    [NetWork POST:url parmater:nil Block:^(NSData *data) {
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        NSDictionary *infoDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_ACCOUNT_GET"] objectForKey:@"list"] firstObject] firstObject];
        NSLog(@"infoDic = %@", infoDic);
        
        Account *account = [Account initAccount:infoDic];
        
        if ([account.gender isEqualToString:@"1"]) {
            account.gender = @"女";
        } else {
            account.gender = @"男";
        }
        
        NSString * userType = [AccountManager sharedInstance].account.userType;
        if ([userType isEqualToString:@"individual"]) {
            //            self.array = @[@"用户名",@"账户类型",@"姓名",@"身份证号",@"出生日期",@"邮箱地址"];
            self.infoArray = [NSMutableArray arrayWithObjects:account.userName, account.userTypeLabel, account.displayName, account.idCard, account.birthday, account.email, nil];
            NSLog(@"%@", self.infoArray);
            
            if ([account.idCardPicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardPicUrl];
                NSLog(@"1");
            } else {
                [self.idCardArray addObject:@"idcard1"];
            }
            if ([account.idCardReversePicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardReversePicUrl];
            } else {
                [self.idCardArray addObject:@"idcard2"];
            }
            if ([account.idCardHandPicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardHandPicUrl];
            } else {
                [self.idCardArray addObject:@"idcard3"];
            }
            NSLog(@"%@", self.idCardArray);

            
        } else {
            //            self.array = @[@"用户名",@"账户类型",@"公司名称",@"法人代表",@"注册号",@"注册资本",@"公司地址",@"邮箱地址"];
            self.infoArray = [NSMutableArray arrayWithObjects:account.userName, account.userTypeLabel, account.companyName, account.legalRepresentative, account.registrationNumber, account.registeredAssets, account.residence, account.email, nil];
            NSLog(@"%@", self.infoArray);
            
            if ([account.idCardPicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardPicUrl];
            } else {
                [self.idCardArray addObject:@"idcard1"];
            }
            if ([account.idCardReversePicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardReversePicUrl];
            } else {
                [self.idCardArray addObject:@"idcard2"];
            }
            if ([account.idCardHandPicUrl length] != 0) {
                [self.idCardArray addObject:account.idCardHandPicUrl];
            } else {
                [self.idCardArray addObject:@"idcard3"];
            }
            if ([account.certificatePicUrl length] != 0) {
                [self.idCardArray addObject:account.certificatePicUrl];
            } else {
                [self.idCardArray addObject:@"idcard3"];
            }

            NSLog(@"%@", self.idCardArray);

        }
        
        //将二个页面添加到ContentScrollView上面
        self.infoVC = [[BasicInfoViewController alloc] init];
        self.infoVC.infoArray = self.infoArray;
        self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
        self.infoVC.delegate = self;
        [self.contentScrollView addSubview:self.infoVC.view];
        self.certicateVC = [[CertificateViewController alloc] init];
        self.certicateVC.idCardArray = self.idCardArray;
        self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
        self.certicateVC.certDelegate = self;
        [self.contentScrollView addSubview:self.certicateVC.view];
        

        
        NSLog(@"%@", self.infoArray);
        
    }];

}

- (void)viewWillLayoutSubviews {
    self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
}


#pragma mark - 基本资料
- (IBAction)basicInfoBtn:(id)sender
{
    NSLog(@"基本资料");
    [self.basicInfo setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.certificate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    
}


#pragma mark - 相关证件
- (IBAction)certificateBtn:(id)sender
{
    NSLog(@"相关证件");
    [self.basicInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.certificate setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(kScreenBoundWidth, 0);
}


#pragma mark - BasicInfoViewControllerDelegate
- (void)intoPushToViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

//- (void)sendToInfoWithMessage:(NSString *)message
//{
//    [self.infoArray replaceObjectAtIndex:self.infoArray.count - 1 withObject:message];
//}


#pragma mark - 返回
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
