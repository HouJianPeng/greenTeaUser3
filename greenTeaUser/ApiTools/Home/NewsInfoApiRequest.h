//
//  NewsInfoApiRequest.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "APIRequest.h"
/// 资讯接口
@interface NewsInfoApiRequest : APIRequest

- (void)setApiParamsWithPostName:(NSString *)postName PageLimit:(NSString *)pageLimit CurrentPage:(NSString *)currentPage;

@end
