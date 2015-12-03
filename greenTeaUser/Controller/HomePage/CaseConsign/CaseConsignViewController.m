//
//  CaseConsignViewController.m
//  greenTea
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//
#import "CaseConsignViewController.h"
#import "NetWork.h"
#import "ZHPickView.h"
#import "AFNetworking.h"
#import "AccountManager.h"
#import "LoginViewController.h"
#import "EntrustSuccessViewController.h"
#import "ProvinceViewController.h"
@interface CaseConsignViewController ()<ZHPickViewDelegate,UITextFieldDelegate,UITextViewDelegate,ProvinceViewControllerDelegate>


@property (weak, nonatomic) NSString *districtId;
@property (strong, nonatomic) ZHPickView *pickViewTwo;
@property (nonatomic, retain) NSDictionary *dict;// 参数字典

@end
@implementation CaseConsignViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTheView];
}
#pragma mark 加载视图
-(void)loadTheView{
    //[self loadTheView];
    
    self.title = @"案件委托";
    self.businessType.delegate = self;
    self.lowcaseId.delegate =self;
    self.caseTitle.delegate = self;
    self.accessoryTextField.delegate = self;
    self.thedescriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.thedescriptionLabel.layer.borderWidth = 0.5;
    self.thedescriptionLabel.layer.cornerRadius = 5;
    self.thedescriptionLabel.layer.masksToBounds = YES;
    self.thedescriptionLabel.delegate =self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doBack:(UIButton *)sender
{
    [self.pickViewTwo remove];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 案件描述代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.thedescriptionLabel.text isEqualToString:@"案件描述:"]) {
        self.thedescriptionLabel.text =nil;
    }
    return YES;
}

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    if (textView == self.thedescriptionLabel) {
//        if ([self.thedescriptionLabel.text length] < 50 || [self.thedescriptionLabel.text length] > 500) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不少于50，不多于500" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            return NO;
//        }
//    }
//    return YES;
//}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if (textField == self.caseTitle) {
//        if ([self.caseTitle.text length] > 20) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"标题不超过20" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            return NO;
//        }
//    }
//    return YES;
//}

#pragma mark选择的省市
-(void)pushTheProvince:(NSMutableArray *)array{
    self.districtId = array[1];
    NSLog(@"%@ %@",self.districtId,array[0]);
    self.businessType.text = array[0];
    
}
#pragma mark 省份选择
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.businessType) {
        [self.view endEditing:YES];
        [self.pickViewTwo remove];
        ProvinceViewController *provice = [[ProvinceViewController alloc] init];
        provice.delegate = self;
        [self.navigationController pushViewController:provice animated:YES];
        return NO;
    }
    else if(textField == self.lowcaseId){
        [self.view endEditing:YES];
        [self loadPickViewtwo];
        return NO;
    }
    else if (textField == self.accessoryTextField) {
        if (textField == self.accessoryTextField) {
            [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
                // !!
                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath RelPathEnum:RelPathApply success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
                    // 上传成功逻辑
                    [self.accessoryTextField setText:fileName];
                    self.assetId = assetId;
                } failure:^(NSString *message) {
                    // 上传失败逻辑
                    NSLog(@"message = %@", message);
                }];
            }];
        }
        return NO;
    }
    else{
        [self.pickViewTwo remove];
    return YES;
    }
    
    
}



#pragma mark 案件类型选择框
-(void)loadPickViewtwo{
    NSArray*array = @[@"公司法律事务",@"银行与金融",@"公司收购、兼并与重组",@"房地产与建筑工程",@"知识产权",@"劳动争议",@"民商事合同诉讼与仲裁",@"刑事案件",@"证券与资本市场",@"私募股权与投资基金"];
    self.pickViewTwo =[[ZHPickView alloc]initPickviewWithArray:array isHaveNavControler:YES];
    
    self.pickViewTwo.delegate =self;
    [self.pickViewTwo show];
}
#pragma mark 选择结果显示
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    self.lowcaseId.text=resultString;
     [self.pickViewTwo remove];
    }


#pragma mark提交案件
- (IBAction)submmitTheValue:(UIButton *)sender
{
    if([AccountManager sharedInstance].isLogin)
    {
        if ([self.lowcaseId.text isEqualToString:@""]) {
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件类型不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else if ([self.caseTitle.text isEqualToString:@""]){
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件标题不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }else if ([self.caseTitle.text length] > 20){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"标题不超过20" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([self.thedescriptionLabel.text length] < 50 || [self.thedescriptionLabel.text length] > 500){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不少于50，不多于500" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
        }
        else if ([self.businessType.text isEqualToString:@""]){
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"所在区域不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else if ([self.thedescriptionLabel.text isEqualToString:@""]){
            UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件描述不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else{
            [self pushTheModel];
        }
    }
    else {
        [AccountManager changeRootVCWithLogin];
    }
    
}



#pragma mark post发送数据
-(void)pushTheModel{
    
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
    NSDictionary*theDic = @{@"公司法律事务":@"A",
                            @"银行与金融":@"B",
                            @"公司收购、兼并与重组":@"C",
                            @"房地产与建筑工程":@"D",
                            @"知识产权":@"E",
                            @"劳动争议":@"F",
                            @"民商事合同诉讼与仲裁":@"G",
                            @"刑事案件":@"H",
                            @"证券与资本市场":@"I",
                            @"私募股权与投资基金":@"J"
                            };
    NSLog(@"%@",[theDic objectForKey:self.lowcaseId.text]);
    
    
    if (self.assetId) {
        self.dict = @{@"cosmosPassportId":userId, @"caseTitle": self.caseTitle.text,@"businessType":theDic[self.lowcaseId.text],@"description":self.thedescriptionLabel.text,@"attachment":self.assetId,@"districtId":self.districtId,@"street":@""};
    } else {
        self.dict = @{@"cosmosPassportId":userId, @"caseTitle": self.caseTitle.text,@"businessType":theDic[self.lowcaseId.text],@"description":self.thedescriptionLabel.text,@"districtId":self.districtId,@"street":@""};
    }

    NSString*url =[NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_SAVE_ACTION", SERVER_HOST_PRODUCT];
    [NetWork POST:url parmater:self.dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue]==0) {
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"案件发布失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
                
                
            }
            else{
                NSLog(@"%@",myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]);
                [self pushTheNextView:[NSString stringWithFormat:@"%@", myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]]];
            }
        }
    }];
}

-(void)pushTheNextView:(NSString*)string{
    EntrustSuccessViewController *entrustSuccessViewController = [[EntrustSuccessViewController alloc] init];
    entrustSuccessViewController.lawcaseNo =string;
    [self.navigationController pushViewController:entrustSuccessViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
