//
//  InCaseViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CaseModel.h"
@interface InCaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *caseNumLabel;//案件编号
@property (weak, nonatomic) IBOutlet UILabel *caseTypeLabel;//案例类型
@property (weak, nonatomic) IBOutlet UILabel *caseStateLabel;//案例状态
@property (weak, nonatomic) IBOutlet UITextView *caseDetailTextView;//案件管理详情
@property (nonatomic, retain) NSString *caseId;
@property (weak, nonatomic) IBOutlet UITextField *caseTitleFiled;  //案件标题
//@property (strong, nonatomic) CaseModel *caseModel; // 案件对象

@end
