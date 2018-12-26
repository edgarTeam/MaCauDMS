//
//  Notice.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Notice : NSObject
@property (nonatomic,copy)NSString *communityId;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *noticeDetails;
@property (nonatomic,copy)NSString *noticeEnglishDetails;
@property (nonatomic,copy)NSString *noticeEnglishTitle;
@property (nonatomic,copy)NSString *noticeId;
@property (nonatomic,copy)NSString *noticeImage;
@property (nonatomic,copy)NSString *noticeTitle;
@property (nonatomic,copy)NSString *noticeTraditionalDetails;
@property (nonatomic,copy)NSString *noticeTraditionalTitle;
@property (nonatomic,copy)NSString *noticeType;
@property (nonatomic,copy)NSString *updateTime;
@end

NS_ASSUME_NONNULL_END
