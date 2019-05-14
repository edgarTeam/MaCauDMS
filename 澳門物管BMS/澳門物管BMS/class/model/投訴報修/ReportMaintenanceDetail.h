//
//  ReportMaintenanceDetail.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeSubList.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReportMaintenanceDetail : NSObject
@property (nonatomic,copy) NSString *communityName;//社区名
@property (nonatomic,assign) NSInteger type; //3-投诉。 4-报修
@property (nonatomic,copy) NSString *complainClassType;
@property (nonatomic,copy) NSString *complainDescribe;
@property (nonatomic,copy) NSString *complainFinishTime;
@property (nonatomic,copy) NSString *complainHandler;
@property (nonatomic,copy) NSString *complainId;
//@property (nonatomic,copy) NSString *complainImages;
@property (nonatomic,copy) NSString *complainLiaisonsEmail;
@property (nonatomic,copy) NSString *complainLiaisonsName;
@property (nonatomic,copy) NSString *complainLiaisonsSex;
@property (nonatomic,copy) NSString *complainPosition;
@property (nonatomic,copy) NSString *complainSpecificPosition;
@property (nonatomic,copy) NSString *complainStatus;
@property (nonatomic,copy) NSString *complainType;
@property (nonatomic,copy) NSString *complainVoice;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *updateTime;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSArray<NoticeSubList *>* images;
@end

NS_ASSUME_NONNULL_END
