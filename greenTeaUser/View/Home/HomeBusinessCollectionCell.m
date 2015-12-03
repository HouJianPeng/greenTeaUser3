//
//  HomeBusinessCollectionCell.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/11/2.
//  Copyright © 2015年 com.cn.lawcheck. All rights reserved.
//

#import "HomeBusinessCollectionCell.h"

@implementation HomeBusinessCollectionCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.imageView = []
//    }
//    return self;
//}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect cellFrame = self.contentView.superview.bounds;
    [self.imageView setFrame:cellFrame];
    [self.contentView addSubview:self.imageView];
}

#pragma mark - getter & setters
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
