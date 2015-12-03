//
//  CaseModel+CoreDataProperties.h
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/11/26.
//  Copyright © 2015年 com.cn.lawcheck. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CaseModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *businessType;
@property (nullable, nonatomic, retain) NSString *businessTypeLabel;
@property (nullable, nonatomic, retain) NSString *caseId;
@property (nullable, nonatomic, retain) NSString *caseName;
@property (nullable, nonatomic, retain) NSString *caseNo;
@property (nullable, nonatomic, retain) NSString *caseTitle;
@property (nullable, nonatomic, retain) NSString *createTime;
@property (nullable, nonatomic, retain) NSString *descriptionStr;
@property (nullable, nonatomic, retain) NSString *districtId;
@property (nullable, nonatomic, retain) NSString *lawyerNum;
@property (nullable, nonatomic, retain) NSString *mobile;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *statusLabel;
@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSString *attachment;

@end

NS_ASSUME_NONNULL_END
