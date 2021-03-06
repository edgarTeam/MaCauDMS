//
//  PlaceRecord.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlaceRecord : NSObject
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *orderDate;
@property (nonatomic,copy)NSString *orderEndTime;
@property (nonatomic,copy)NSString *orderStartTime;
@property (nonatomic,copy)NSString *placeId;
@property (nonatomic,copy)NSString *recordId;
@property (nonatomic,copy)NSString *recordStatus;//预定状态（-1预约取消 0开始发起 1预约成功 2预约失败）
@property (nonatomic,copy)NSString *updateTime;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,assign) NSNumber *averageCharge;//每小时费用
@property (nonatomic,assign) NSNumber *totalCharge;//总费用
@property (nonatomic,assign) NSNumber *attachCharge;//附加费用

@property (nonatomic,strong)Place *place;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
