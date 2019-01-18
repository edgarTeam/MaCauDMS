//
//  NSDate+Utils.h
//  练习
//
//  Created by sc-057 on 2018/9/10.
//  Copyright © 2018年 sc-057. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
+(NSDate *)dateWithYear:(NSInteger)year
                  month:(NSInteger)month
                    day:(NSInteger)day
                   hour:(NSInteger)hour
                 minute:(NSInteger)minute
                 second:(NSInteger)second;
//起始时间和最后时间的长度
+(NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+(NSString *)getLocalTimeString;
#pragma mark -Getter方法
-(NSInteger)year;
-(NSInteger)month;
-(NSInteger)day;
-(NSInteger)hour;
-(NSInteger)minute;
-(NSInteger)second;
-(NSString *)weekday;

#pragma mark -Time string
//上下午
-(NSString *)timeHourMinute;
-(NSString *)timeHourMinuteWitnPrefix;//之前
-(NSString *)timeHourMinuteWithSuffix;
-(NSString *)timeHourMinuteWitnPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix;

#pragma mark -Date string
-(NSString *)stringTime;
-(NSString *)stringYearMonth;
-(NSString *)stringMonthDay;
-(NSString *)stringYearMonthDay;
-(NSString *)stringYearMonthDayHourMinuteSecond;
+(NSString *)stringYearHourDayWithDate:(NSDate *)date;//date为空时返回当前年月日
+(NSString *)stringLoacalDate;

#pragma mark -Date formate
+(NSString *)dateFormateString;
+(NSString *)timeFormateString;
+(NSString *)timestampFormateString;
+(NSString *)timestampFormateStringSubSeconds;

#pragma mark -Date adjust
-(NSDate *)dateByAddingDays:(NSInteger) dateDays;
-(NSDate *)dateBySubtractingDays:(NSInteger) dateDays;

#pragma mark -From date to date
+(NSDate *)dateYesterday;
+(NSDate *)dateTomorrow;
+(NSDate *)dateWithDaysFromNow:(NSInteger)days;
+(NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+(NSDate *)dateWithHoursFromNow:(NSInteger)days;
+(NSDate *)dateWithHoursBeforeNow:(NSInteger)days;
+(NSDate *)dateWithMinuteFromNow:(NSInteger)days;
+(NSDate *)dateWithMinuteBeforeNow:(NSInteger)days;
+(NSDate *) dateStandardFormatTimeZeroWithDate: (NSDate *) dDate;//标准格式的零点日期
-(NSInteger) daysBetweenCurrentDateAndDate;//负数为过去，正数为未来

#pragma mark -Date conversion
-(void)setWithString:(NSString *)string inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;


+(NSString*)getCurrentTimes;
@end
