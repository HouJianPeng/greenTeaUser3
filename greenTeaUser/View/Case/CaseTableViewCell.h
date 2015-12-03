//
//  CaseTableViewCell.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *theDetialButton;
@property(weak, nonatomic)IBOutlet UILabel *caseStateLabel; // 案例状态
@property(weak, nonatomic)IBOutlet UILabel *caseNumberLabel; // 案例标题
@property(weak, nonatomic)IBOutlet UILabel *caseTypeLabel; // 案例详情

@property (weak, nonatomic) IBOutlet UILabel *caseTitleLable; //案件标题

@end
