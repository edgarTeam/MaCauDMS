//
//  NSDate+Utils.m
//  练习
//
//  Created by sc-057 on 2018/9/10.
//  Copyright © 2018年 sc-057. All rights reserved.
//

#import "NSDate+Utils.h"

#define MINUTE 60
#define HOUR 3600
#define DAY 86400
#define WEEK 604800
#define YEAR 31536000
@implementation NSDate (Utils)

+(NSDate *)dateWithYear:(NSInteger)year
                  month:(NSInteger)month
                    day:(NSInteger)day
                   hour:(NSInteger)hour
                 minute:(NSInteger)minute
                 second:(NSInteger)second{
    // 定义一个遵循某个历法的日历对象 NSGregorianCalendar国际历法
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //i系统所在的时区
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateComponents *dateComps=[[NSDateComponents alloc] init];
    [dateComps setCalendar:calendar];
    [dateComps setTimeZone:timeZone];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    return [dateComps date];
}
//字符转换
+(NSString *)getLocalTimeString{
    NSDate *date=[NSDate date];
    NSString * time=[NSString stringWithFormat:@"%@",date];
    time=[time stringByReplacingOccurrencesOfString:@" " withString:@""];
    time=[time stringByReplacingOccurrencesOfString:@"-" withString:@""];
    time=[time stringByReplacingOccurrencesOfString:@":" withString:@""];
    time=[time stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return time;
}

+(NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //unsigned int unitFlags = NSHourCalendarUnit;//年、月、日、时、分、秒、周等等
     unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps=[calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSInteger days=[comps day];
    return days;
}

#pragma mark -Getter方法
-(NSInteger)year{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps year];
}

-(NSInteger)month{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps month];
}

-(NSInteger)day{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps day];
}

-(NSInteger)hour{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps hour];
}

-(NSInteger)minute{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps minute];
}
-(NSInteger)second{
    NSDateComponents *dateComps=[[NSCalendar currentCalendar]components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComps second];
}
-(NSString *)weekday{
   // NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDate *date=[NSDate date];
    NSDateComponents *comps=[[NSCalendar currentCalendar] components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                        fromDate:date];
    NSInteger weekday=[comps weekday];
    NSString *week=@"";
    switch (weekday) {
        case 1:
            week=@"Sunday";
            break;
        case 2:
            week=@"Monday";
            break;
        case 3:
            week=@"Tuesday";
            break;
        case 4:
            week=@"Wednesday";
            break;
        case 5:
            week=@"Thursday";
            break;
        case 6:
            week=@"Friday";
            break;
        case 7:
            week=@"Saturday";
            break;
        default:
            break;
    }
    return week;
}

#pragma mark -Time string
-(NSString *)timeHourMinute{
    return [self timeHourMinuteWitnPrefix:NO suffix:NO];
}
-(NSString *)timeHourMinuteWitnPrefix{
    return [self timeHourMinuteWitnPrefix:YES suffix:NO];
}
-(NSString *)timeHourMinuteWithSuffix{
    return [self timeHourMinuteWitnPrefix:NO suffix:YES];
}
-(NSString *)timeHourMinuteWitnPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr=[dateFormatter stringFromDate:self];
    if (enablePrefix) {
        timeStr=[NSString stringWithFormat:@"%@%@",([self hour]>12 ? @"下午" :@"上午"),timeStr];
    }
    if (enableSuffix) {
        timeStr=[NSString stringWithFormat:@"%@%@",([self hour]>12 ? @"pm" :@"am"),timeStr];
    }
    return timeStr;
}

#pragma mark -Date string
-(NSString *)stringTime{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr=[dateFormatter stringFromDate:self];
    return timeStr;
}


-(NSString *)stringYearMonth{
    return [NSDate dateYearMonthWithDate:self];
}

-(NSString *)stringMonthDay{
    return [NSDate dateMonthDayWithDate:self];
}

-(NSString *)stringYearMonthDay{
    return [NSDate dateYearMonthDayWithDate:self];
}

-(NSString *)stringYearMonthDayHourMinuteSecond{
    return [NSDate dateYearMonthDayHourMinuteSecondWithDate:self];
}
/*
+(NSString *)stringYearHourDayWithDate:(NSDate *)date{
    NSString *str;
    NSInteger day=[self ];
}//date为空时返回当前年月日
+(NSString *)stringLoacalDate;
*/
+ (NSString *)dateMonthDayWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM.dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)dateYearMonthDayWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)dateYearMonthWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)dateYearMonthDayHourMinuteSecondWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

#pragma mark -Date formate



#pragma mark -Date conversion
-(void)setWithString:(NSString *)str inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat{
    if ([inputFormat isEqualToString:@"timeStemp"]) {
        NSTimeInterval time=[str doubleValue];
        if (str.length ==13) {
            time =[str doubleValue];
        }
        NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormate=[[NSDateFormatter alloc] init];
        [dateFormate setDateFormat:outputFormat];
        
        NSString *dateStr=[dateFormate stringFromDate:detailDate];
        str=dateStr;
    }else{
        NSDateFormatter *inputfor=[[NSDateFormatter alloc] init];
        [inputfor setDateFormat:inputFormat];
        NSDate *date = [inputfor dateFromString:str];
        NSDateFormatter *outputfor=[[NSDateFormatter alloc] init];
        [outputfor setDateFormat:outputFormat];
        str=[outputfor stringFromDate:date];       
    }
}



+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSString * time=currentTimeString;
   time=[currentTimeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    time=[time stringByReplacingOccurrencesOfString:@"-" withString:@""];
    time=[time stringByReplacingOccurrencesOfString:@":" withString:@""];
   // NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return time;
    
}
@end
