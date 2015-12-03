//
//  DetailInfoApiRequest.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/22.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "DetailInfoApiRequest.h"

@implementation DetailInfoApiRequest
- (NSString *)urlAction {
    return DetailInfoAction;
}

- (void)setApiParamsWithAdvertisementId:(NSString *)advertisementId
{
    [self.params setObject:advertisementId forKey:@"AdvertisementId"];
    
}

@end
