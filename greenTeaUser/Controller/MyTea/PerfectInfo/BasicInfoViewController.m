//
//  BasicInfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "PersonTableViewCell.h"
#import "ChangeEmailViewController.h"

@interface BasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource, ChangeEmailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *theDetialTableView;
@property(nonatomic,retain) NSArray *array;
@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theDetialTableView.delegate = self;
    self.theDetialTableView.dataSource = self;
    self.navigationController.navigationBar.hidden= YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _theDetialTableView.tableFooterView = [[UIView alloc]init];
    NSString *userType = [AccountManager sharedInstance].account.userType;
    
    if ([userType isEqualToString:@"individual"]) {
        self.array = @[@"用户名",@"账户类型",@"姓名",@"身份证号",@"出生日期",@"邮箱地址"];
    } else {
        self.array = @[@"用户名",@"账户类型",@"公司名称",@"法人代表",@"注册号",@"注册资本",@"公司地址",@"邮箱地址"];
    }
    [self.theDetialTableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString*cellidentifer = @"PersonTableViewCell";
    PersonTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellidentifer owner:nil options:nil ] firstObject];
    }
    cell.theDescriptionLabel.text = self.array[indexPath.row];
    cell.theDetialLabel.text = self.infoArray[indexPath.row] ;
    return  cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.infoArray.count - 1) {
        ChangeEmailViewController *emailVC = [[ChangeEmailViewController alloc] init];
        emailVC.emailStr = [self.infoArray lastObject];
        emailVC.delegate = self;
        [self.delegate intoPushToViewController:emailVC];
    }
}

#pragma mark - ChangeEmailViewControllerDelegate
- (void)sendToBasicInfoWithMessage:(NSString *)message
{
    [self.infoArray replaceObjectAtIndex:self.infoArray.count - 1 withObject:message];
    [self.theDetialTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
