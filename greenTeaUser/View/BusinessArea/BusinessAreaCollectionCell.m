//
//  BusinessAreaCollectionCell.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/11/2.
//  Copyright © 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BusinessAreaCollectionCell.h"

@implementation BusinessAreaCollectionCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //CGRect cellFrame = self.contentView.superview.bounds;
    
   // [self.businessImageView setFrame:cellFrame];
    [self.businessImageView setFrame:CGRectMake(0, 0, 60, 60)];
    [self.businessNameLabel setFrame:CGRectMake(60, 60, 60, 20)];
    
    [self.contentView addSubview:self.businessImageView];
    [self.contentView addSubview:self.businessName];
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self.businessImage == nil) {
//        self.businessImage = [[UIImageView alloc]init];
//    }
//    return self;
//}

#pragma mark - getter & setters

- (UIImageView *)businessImageView{
    if (_businessImage == nil) {
        _businessImage = [[UIImageView alloc]init];
    }
    return _businessImage;
}

- (UIImageView *)businessNameLabel{
    if (_businessName == nil) {
        _businessName = [[UILabel alloc]init];
    }
    return _businessImage;
}
@end
