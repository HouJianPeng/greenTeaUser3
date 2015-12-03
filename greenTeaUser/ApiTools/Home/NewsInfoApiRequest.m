//
//  NewsInfoApiRequest.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "NewsInfoApiRequest.h"

@implementation NewsInfoApiRequest

- (NSString *)urlAction {
    return HomeInfoAction;
}

- (void)setApiParamsWithPostName:(NSString *)postName PageLimit:(NSString *)pageLimit CurrentPage:(NSString *)currentPage {
    [self.params setObject:postName forKey:@"positionName"];
    [self.params setObject:pageLimit forKey:@"pageLimit"];
    [self.params setObject:currentPage forKey:@"page"];
}

@end
