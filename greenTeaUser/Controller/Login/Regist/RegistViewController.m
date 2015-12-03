//
//  RegistViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/14.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "RegistViewController.h"
#import "QiyeRegistViewController.h"
#import "UserRegistViewController.h"
#import "NSString+Validation.h"
#import "NetWork.h"
#import "NetworkMacro.h"


@interface RegistViewController ()< UITextFieldDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *accountType;
@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.accountType = @[@"个人", @"企业"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.accountTypeTextField.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.accountTypeTextField) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账户类型:" message:nil delegate:self cancelButtonTitle:@"个人" otherButtonTitles:@"企业", nil];
        alertView.tag = 11;
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11) {
        if (buttonIndex == 0) {
            self.accountTypeTextField.text = @"个人";
        } else if (buttonIndex == 1) {
            self.accountTypeTextField.text = @"企业";
        }
    } else if (alertView.tag == 12) {
        if (buttonIndex == 0) {
            self.phoneNumberTextField.text = @"";
        }
    } else {
        
    }
}

#pragma mark - 点击获取验证码
- (IBAction)gainVerification:(id)sender
{
    if ([self.phoneNumberTextField.text validateMobile:self.phoneNumberTextField.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_GET_USER_INFO_BLOCK&uname=%@", SERVER_HOST_PRODUCT, self.phoneNumberTextField.text];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSNumber *success = (NSNumber *)[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_GET_USER_INFO_BLOCK"] objectForKey:@"object"] objectForKey:@"success"];
            if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 12;
                [alert show];
            }
            else {
                NSDictionary *dic = @{@"phoneNumbers":_phoneNumberTextField.text, @"content":@"【绿茶网】尊敬的用户，您在进行绿茶网的注册验证码：<vcode>，请妥善保管。", @"validateEvent":@"register"};
                
                [NetWork GET:VerificationMessageURL parmater:dic Block:^(NSData *data) {
                    
                    NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSString *result = [[[[[myDic objectForKey:@"result"] objectForKey:@"config"] objectForKey:@"smsSender"] objectForKey:@"object"] objectForKey:@"succeed"];
                    
                    NSLog(@"succeed = %@", result);
                }];
                
                [self timeCountDown];
                
            }
        }];
    }
}


#pragma mark - 点击下一页,验证验证码
- (IBAction)registNextAction:(id)sender
{
    // 判断手机号
    if ([_phoneNumberTextField.text validateMobile:_phoneNumberTextField.text] == YES) {
        // 判断密码
        if (![_setupPasswordTextField.text length]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不能为空" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            // 判断两次密码
        } else if (![self.setupPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"两次密码不一致" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            // 判断验证码是否为空
            if (![_verificationTextField.text length]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入验证码" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else {
                // 判断是否选择用户类型
                if ([self.accountTypeTextField.text length] == 0)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择账户类型" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else {

                    NSDictionary *dic = @{@"mcode":_verificationTextField.text, @"validateEvent":@"register", @"validateObject":_phoneNumberTextField.text, @"validateType":@"mobile", @"mobile":_phoneNumberTextField.text};
                    
                    [NetWork GET:CheckVerificationURL parmater:dic Block:^(NSData *data) {
                        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                        
                        NSLog(@"dataDic == %@", dataDic);
                        
                        NSString *result = [[[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACCOUNT_VERIFYCODE_CHECK"] objectForKey:@"object"] objectForKey:@"success"];
                        NSLog(@"result = %@", result);
                        NSNumber *r = (NSNumber *)result;
                        if ([r isEqualToNumber:[NSNumber numberWithInt:1]]) {
                            if ([self.accountTypeTextField.text isEqualToString:@"个人"]) {
                                
                                UserRegistViewController *userViewController = [[UserRegistViewController alloc] init];
                                userViewController.phoneNumber = self.phoneNumberTextField.text;
                                userViewController.verification = self.verificationTextField.text;
                                userViewController.password = self.setupPasswordTextField.text;
                                userViewController.userType = self.accountTypeTextField.text;
                                [self.navigationController pushViewController:userViewController animated:YES];
                                
//
                            }else if([self.accountTypeTextField.text isEqualToString:@"企业"]){
                                QiyeRegistViewController *qiyeViewController = [[QiyeRegistViewController alloc] init];
                                qiyeViewController.phoneNumber = self.phoneNumberTextField.text;
                                qiyeViewController.verification = self.verificationTextField.text;
                                qiyeViewController.password = self.setupPasswordTextField.text;
                                qiyeViewController.userType = self.accountTypeTextField.text;
                                [self.navigationController pushViewController:qiyeViewController animated:YES];
                            }
                            else {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择账户类型" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                        }else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确验证码" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }];
                    _nextButton.userInteractionEnabled = YES;
                }
            }
        }
    } else {
    }
}


#pragma mark - 倒计时
- (void)timeCountDown
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _gainVerificationButton.userInteractionEnabled = YES;
                _gainVerificationButton.backgroundColor = [UIColor lightGrayColor];
                [_gainVerificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后重发", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                _gainVerificationButton.userInteractionEnabled = NO;
                _gainVerificationButton.backgroundColor = [UIColor lightGrayColor];
                //设置界面的按钮显示 根据自己需求设置
                [_gainVerificationButton setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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

@end
