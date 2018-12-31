//
//  CommonUtil.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtil : NSObject
+(BOOL)isRequestOK:(id)response;
+(NSTimeInterval )getTimeIntervalFromDate:(NSDate*)date;
+(void)handelError:(NSError *)error;
+ (BOOL)isTelOk:(NSString *)tel;
+ (NSString *)HandleMoneyString:(NSString *)stringFloat;
+ (NSString *)getCurrentYaarMonth;
+ (NSString *)corvertTimeString:(NSString *)string;
//+ (void)storeUser;
+ (void)loadDefuatUser;
+ (void)clearDefuatUser;
//+ (void)IMlogin;
//+ (void)IMlogout;
+ (NSString *)dateTimeWithYYMMDDHHMM:(NSDate *)date;
+ (void)addGradientLayerTo:(id)object;


@end

NS_ASSUME_NONNULL_END
