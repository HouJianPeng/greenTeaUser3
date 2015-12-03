//
//  BusinessAreaCollectionCell.h
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/11/2.
//  Copyright © 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ReusableBusinessAreaCollectionCell @"ReusableBusinessAreaCollectionCell"
@interface BusinessAreaCollectionCell : UICollectionViewCell

@property(nonatomic, strong)UIImageView *businessImage;
@property(nonatomic, strong)UILabel *businessName;
@end
