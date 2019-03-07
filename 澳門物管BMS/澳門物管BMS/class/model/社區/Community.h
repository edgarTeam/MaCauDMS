//
//  Community.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/25.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Community : NSObject
@property (nonatomic,copy)NSString *communityAddress;
@property (nonatomic,copy)NSNumber *communityArea;
@property (nonatomic,copy)NSNumber *communityBuildingArea;
@property (nonatomic,copy)NSNumber *communityCommonArea;
@property (nonatomic,copy)NSString *communityContacts;
@property (nonatomic,copy)NSString *communityContactsPhone;
@property (nonatomic,assign)Boolean communityDeleted;
@property (nonatomic,copy)NSNumber *communityGarageArea;
@property (nonatomic,assign)NSInteger communityGarageCount;
@property (nonatomic,assign)NSInteger communityGreenarea;
@property (nonatomic,copy)NSString *communityId;
@property (nonatomic,copy)NSNumber *communityLocX;
@property (nonatomic,copy)NSNumber *communityLocY;
@property (nonatomic,copy)NSString *communityManagementType;
@property (nonatomic,copy)NSString *communityName;
@property (nonatomic,copy)NSString *communityNo;
@property (nonatomic,copy)NSString *communityRemark;
@property (nonatomic,copy)NSNumber *communityRoadArea;
@property (nonatomic,assign)NSInteger communityRoomCount;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *updateTime;
@end

NS_ASSUME_NONNULL_END
