//
//  BusinessAreaCollectionViewCell.m
//  greenTeaUser
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "BusinessAreaCollectionViewCell.h"

@implementation BusinessAreaCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect cellFrame = self.contentView.superview.bounds;
    [self.imageView setFrame:cellFrame];
    [self.contentView addSubview:self.imageView];
}

#pragma mark - getter & setters
- (UIImageView *)imageView {
    if (_businessImage == nil) {
        //_businessImage = [[UIImageView alloc] init];
    }
    return _businessImage;
}


@end
