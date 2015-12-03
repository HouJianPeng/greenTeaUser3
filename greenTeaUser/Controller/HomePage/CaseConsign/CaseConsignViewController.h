//
//  CaseConsignViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

/// 案件委托VC
@interface CaseConsignViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *lowcaseId; // 所在区域
@property (weak, nonatomic) IBOutlet UITextField *businessType; // 案件类型
@property (weak, nonatomic) IBOutlet UITextField *caseTitle; // 案件标题
@property (weak, nonatomic) IBOutlet UITextView *thedescriptionLabel; // 案件描述
@property (weak, nonatomic) IBOutlet UITextField *accessoryTextField;// 附件
@property (nonatomic, copy) NSString *assetId; // 附件的值

@end
