//
//  CaseConsignViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//
#import "CaseConsignViewController.h"
#import "NetWork.h"
#import "ZHPickView.h"
#import "AFNetworking.h"
#import "AccountManager.h"
#import "LoginViewController.h"
#import "EntrustSuccessViewController.h"

@interface CaseConsignViewController ()<ZHPickViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lowcaseId;
@property (weak, nonatomic) IBOutlet UITextField *businessType;
@property (weak, nonatomic) IBOutlet UIButton *submmitButton;
@property (weak, nonatomic) IBOutlet UITextField *caseTitle;
@property (weak, nonatomic) IBOutlet UITextView *thedescriptionLabel;
@property (weak, nonatomic) NSString *districtId;
@property (strong, nonatomic) ZHPickView*pickView;
@property (strong, nonatomic) ZHPickView*pickViewTwo;
@end
@implementation CaseConsignViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;


    // Do any additional setup after loading the view from its nib.
    self.title = @"案件委托";
    [self.submmitButton addTarget:self action:@selector(submmitTheValue) forControlEvents:UIControlEventTouchUpInside];
    self.businessType.delegate = self;
    self.lowcaseId.delegate =self;
    _thedescriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _thedescriptionLabel.layer.borderWidth = 0.5;
    _thedescriptionLabel.layer.cornerRadius = 5;
    _thedescriptionLabel.layer.masksToBounds = YES;
}


- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 省份选择

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.businessType) {
        [self.view endEditing:YES];
        [self loadPickView];
        return NO;
    }
    else if(textField==self.lowcaseId){
        [self.view endEditing:YES];
        [self loadPickViewtwo];
        return NO;
    }
    else{
    return YES;
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
#pragma mark pickView 加载
-(void)loadPickView{
    _pickView =[[ZHPickView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:NO];
    _pickView.delegate =self;
    [_pickView show];
}

-(void)loadPickViewtwo{
    NSArray*array = @[@"公司法律事务",@"银行与金融",@"公司收购、兼并与重组",@"房地产与建筑工程",@"知识产权",@"劳动争议",@"民商事合同诉讼与仲裁",@"刑事案件",@"证券与资本市场",@"私募股权与投资基金"];
    
    _pickViewTwo =[[ZHPickView alloc]initPickviewWithArray:array isHaveNavControler:YES];
    _pickViewTwo.delegate =self;
    [_pickViewTwo show];
}
#pragma mark 选择结果显示
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView==_pickView) {
        self.businessType.text=resultString;
    }
    else{
        self.lowcaseId.text=resultString;
    }
}
#pragma mark提交案件
-(void)submmitTheValue{
    if([AccountManager sharedInstance].isLogin)
    {
        if ([_lowcaseId.text isEqualToString:@""]) {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件编号不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else{
            [self pushTheModel];
            
        }
    }
    else{
        [AccountManager changeRootVCWithLogin];
    }
}
#pragma mark post发送数据
-(void)pushTheModel{
    NSDictionary*theDic = @{@"公司法律事务":@"A",@"银行与金融":@"B",@"公司收购、兼并与重组":@"C",@"房地产与建筑工程":@"D",@"知识产权":@"E",@"劳动争议":@"F",@"民商事合同诉讼与仲裁":@"G",@"刑事案件":@"H",@"证券与资本市场":@"I",@"私募股权与投资基金":@"J"};
    
    NSLog(@"%@",[theDic objectForKey:self.lowcaseId.text]);
    
    NSDictionary *dict = @{@"cosmosPassportId":@"a68f7d531ec611e58136005056a87cbc", @"caseTitle": _caseTitle.text,@"businessType":@"A",@"description":_thedescriptionLabel.text,@"attachment":@"",@"districtId":@"7b6fefc9cb9711e3a770025041000001",@"street":@""};
    
    NSLog(@"%@",dict);
    NSString*url =@"http://www.lawcheck.com.cn/cosmos.json?command=scommerce.LC_CASE_LAWCASE_SAVE_ACTION";
    [NetWork POST:url parmater:dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue]==0) {
            }
            else{
                NSLog(@"提交成功");
                EntrustSuccessViewController *entrustSuccessViewController = [[EntrustSuccessViewController alloc] init];
                [self.navigationController pushViewController:entrustSuccessViewController animated:YES];
            }
        }
    }];
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
