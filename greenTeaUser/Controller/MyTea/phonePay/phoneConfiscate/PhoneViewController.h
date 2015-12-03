//
//  PhoneViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "BaseViewController.h"

@interface PhoneViewController : BaseViewController

@property(nonatomic, strong)IBOutlet UILabel *phonePayLabel;//手机充值

@property(nonatomic, strong)IBOutlet UILabel *payInfoLabel;//支付信息

@property(nonatomic, strong)IBOutlet UILabel *payNumLabel;//充值账户
@property(nonatomic, strong)IBOutlet UILabel *payNumLab;//充值号码****需要传值（用户注册账号）
@property(nonatomic, strong)IBOutlet UILabel *payMoneyLabel;//充值金额
@property(nonatomic ,strong)IBOutlet UITextField *payMoneyField;//金额数量****
@property (weak, nonatomic) IBOutlet UILabel *payLabel;//元

@property(nonatomic, strong)IBOutlet UILabel *payStyleLabel;//支付方式

@property(nonatomic, strong)IBOutlet UILabel *weiChatPayLabel;//微信支付
@property(nonatomic, strong)IBOutlet UIImageView *weiChatImg;//微信头像
@property(nonatomic, strong)IBOutlet UIButton *weiChatPayBtn;//微信支付按钮

@property(nonatomic, strong)IBOutlet UILabel *AirPayLabel;//支付宝
@property(nonatomic, strong)IBOutlet UIImageView *AirPayImg;//支付宝头像
@property(nonatomic, strong)IBOutlet UIButton *AirPayBtn;//支付宝支付按钮

@property(nonatomic, strong)IBOutlet UILabel *tenPayLabel;//财付通
@property(nonatomic, strong)IBOutlet UIImageView *tenPayImg;//财付通头像
@property(nonatomic, strong)IBOutlet UIButton *tenPayBtn;//财付通支付按钮


/**
 *  微信支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)weiChatBtn:(id)sender;
/**
 *  支付宝支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)AirPayBtn:(id)sender;
/**
 *  财付通支付
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)tenPayBtn:(id)sender;
/**
 *  返回按钮
 *
 *  @param sender @author 侯建鹏
 */
-(IBAction)turnBackBtn:(id)sender;


@end
