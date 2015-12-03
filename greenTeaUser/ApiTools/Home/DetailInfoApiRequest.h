//
//  DetailInfoApiRequest.h
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/22.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "APIRequest.h"
//资讯详情接口
@interface DetailInfoApiRequest : APIRequest

- (void)setApiParamsWithAdvertisementId:(NSString *)advertisementId;
@end
