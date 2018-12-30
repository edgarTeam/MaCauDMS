//
//  User.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *communityId;
@property (nonatomic,copy) NSString *countryCode;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,assign) Boolean *deleted;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *englishName;
@property (nonatomic,copy) NSString *idCard;
@property (nonatomic,copy) NSString *marriageSystem;
@property (nonatomic,copy) NSString *mateName;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *portrait;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *updateTime;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *username;


+ (User *)shareUser;
+ (void)clear;
@end

NS_ASSUME_NONNULL_END
