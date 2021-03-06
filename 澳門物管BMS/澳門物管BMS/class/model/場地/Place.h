//
//  Plate.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeSubList.h"
//NS_ASSUME_NONNULL_BEGIN

@interface Place : NSObject
@property (nonatomic,copy)NSString *communityId;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,assign)NSInteger *placeAdvanceOrderDay;
@property (nonatomic,copy)NSString *placeEndTime;
@property (nonatomic,copy)NSString *placeEnglishIntroduction;
@property (nonatomic,copy)NSString *placeEnglishName;
@property (nonatomic,assign)NSInteger placeFarthestOrderDay;
@property (nonatomic,copy)NSString *placeId;
//@property (nonatomic,copy)NSString *placeImage;
@property (nonatomic,copy)NSString *placeIntroduction;
@property (nonatomic,copy)NSString *placeName;
@property (nonatomic,assign)NSInteger placeNeedOrder; //需要预定（0否 1是）
@property (nonatomic,copy)NSString *placeStartTime;
@property (nonatomic,copy)NSString *placeTraditionalIntroduction;
@property (nonatomic,copy)NSString *placeTraditionalName;
@property (nonatomic,assign)NSInteger placeUpperLimit;
@property (nonatomic,copy)NSString *updateTime;
@property (nonatomic,assign) NSInteger placeStatus; //场所状态（0未开放 1开放）
@property (nonatomic,copy)NSArray<NoticeSubList *>* images;
@property (nonatomic,assign)NSInteger placeIconType;
@property (nonatomic,assign) NSNumber *placeCharge;
@property (nonatomic,assign) NSNumber *placeAttachCharge;//附加费用
- (instancetype) initWithDictionary:(NSDictionary *)dict;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

//NS_ASSUME_NONNULL_END
