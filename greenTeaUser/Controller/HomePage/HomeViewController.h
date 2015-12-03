//
//  HomeViewController.h
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/7.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BaseViewController.h"

/// 首页VC
@interface HomeViewController : BaseViewController{
    int type;
}

@property (weak, nonatomic) IBOutlet UIButton *lawBtn;//律师直通车
@property (weak, nonatomic) IBOutlet UIButton *delBtn;//案件委托
@property (weak, nonatomic) IBOutlet UILabel *Newzixun;//最新咨询
@property (weak, nonatomic) IBOutlet UIImageView *ZixunImage;//资讯图标




/**
 *  律师直通车
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)lawyerbutn:(id)sender;
/**
 *  案件委托
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)entrustbutn:(id)sender;



@end
