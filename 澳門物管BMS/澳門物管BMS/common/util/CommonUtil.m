//
//  CommonUtil.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
+ (CommonUtil *)sharedInstance
{
    static CommonUtil *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CommonUtil alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

+(BOOL)isRequestOK:(id)response{
    if ([response isKindOfClass: [NSDictionary class]]){
        NSDictionary *dictResp = (NSDictionary *)response;
        switch ([[dictResp objectForKey:@"code"] intValue]) {
                //            case 1:{
                //                NSLog(@"Util Response , request success");
                //
                //                return YES;
                //                break;
                //            }
                //            case 101: //缺少参数
                //            {   [[UIApplication sharedApplication].keyWindow makeToast:@"登入信息失效，請重新登入" duration:3.0 position:@"CSToastPositionBottom"];
                //                LoginNavigationController *loginVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                //                                                      instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                //                [[UIApplication sharedApplication].keyWindow setRootViewController:loginVc];
                //
                //                NSLog(@"Util Response , Missing input");
                //                return NO;}
            case 102: //没有这条纪录
            { NSLog(@"Util Response ,  No record");
                return NO;}
            case 103: //非法操作
            {
                return  NO;
            }
            case 104: //被删除
            {
                return  NO;
            }
            case 301:{
                
                return  NO;
                ;
            }
            case 2000:{
                
                return  YES;
                
            }
            case 4000:{
                return YES;
            }
            case 0000:{
                return YES;
            }
            case 0001:{
                return NO;
            }
                //            case 401:{
                //                //        storyBoard_ = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //                LoginNavigationController *loginVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                //                                                      instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
                //                [[UIApplication sharedApplication].keyWindow setRootViewController:loginVc];
                //
                //                [[UIApplication sharedApplication].keyWindow makeToast:@"登入信息失效，請重新登入" duration:3.0 position:@"CSToastPositionBottom"];
                //                return  NO;
                //            }
                
            default:
                NSLog(@"Util Response ,  No this error code");
                return NO;
        }
    } else{
        NSLog(@"Util Response , missing key code");
        return NO;
    }
}

+(NSString *)getUnixTimeString{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

+(NSTimeInterval )getTimeIntervalFromDate:(NSDate*)date{
    NSDate *currentDate = [NSDate date];
    //    NSDate *endOrderDate  = [date dateByAddingTimeInterval:900.0f];
    NSTimeInterval currentTime = [currentDate timeIntervalSince1970];
    NSTimeInterval orderTime = [date timeIntervalSince1970];
    double timeRemaining = currentTime - orderTime;
    
    return timeRemaining ;
}

+ (BOOL)isTelOk:(NSString *)tel{
    if ([tel hasPrefix:@"+"]) {
        tel = [tel substringFromIndex:1];
    }
    NSString *regexTEL = @"^86[1][3-8]\\d{9}$|^852([6|9])\\d{7}$|^853[6]\\d{7}$";
    NSPredicate *predicateTEL = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexTEL];
    
    if ([predicateTEL evaluateWithObject:tel]) {
        return YES;
    }else{
        return NO;
    }
}

+(void)handelError:(NSError *)error
{
    
}

+(NSString *)HandleMoneyString:(NSString *)stringFloat{
    stringFloat = [NSString stringWithFormat:@"%.4f",[stringFloat floatValue]];
    const char *floatChars = [stringFloat UTF8String];//指向字符串的指针
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];//去除float后面无效的0
    }
    return returnString;
}

+ (NSString *)getCurrentYaarMonth{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"YYYY-MM"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (NSString *)corvertTimeString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    if (string.length == 8) {
        [formatter setDateFormat:@"yyyyMMdd"];
    }else if(string.length ==12) {
        [formatter setDateFormat:@"yyyyMMddHHmm"];
    }else{
        string =  [string substringToIndex:12];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
    }
    NSDate * date = [formatter dateFromString:string];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    if (string.length == 8) {
        [formatter2 setDateFormat:@"yyyy-MM-dd"];
    }else if(string.length ==12) {
        [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return [formatter2 stringFromDate:date];
}

//+ (void)storeUser{
//    User *user =  [User shareUser];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [ userDefaults setObject:user.memberid forKey:@"memberid"];
//    [ userDefaults setObject:user.tel forKey:@"tel"];
//    [ userDefaults setObject:[NSString stringWithFormat:@"%ld",user.sex] forKey:@"sex"];
//    [ userDefaults setObject:user.headerPath forKey:@"headerPath"];
//    [ userDefaults setObject:user.nickName forKey:@"nickName"];
//    [ userDefaults setObject:user.imUserName forKey:@"imUserName"];
//}


//+ (void)loadDefuatUser{
//    User *user =  [User shareUser];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([userDefaults objectForKey:@"memberid"]!= nil && [[userDefaults objectForKey:@"memberid"] length] > 0) {
//        user.memberid = [userDefaults objectForKey:@"memberid"];
//        user.headerPath = [userDefaults objectForKey:@"headerPath"];
//        user.tel = [userDefaults objectForKey:@"tel"];
//        user.sex = [[userDefaults objectForKey:@"sex"] integerValue];
//        user.nickName = [userDefaults objectForKey:@"nickName"];
//        user.sex = [[userDefaults objectForKey:@"sex"] integerValue];
//        user.imUserName = [userDefaults objectForKey:@"imUserName"];
//        
//    }
//}

+ (NSString *)dateTimeWithYYMMDDHHMM:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return  [formatter stringFromDate:date];
}

+ (void)clearDefuatUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [ userDefaults setObject:nil forKey:@"memberid"];
    [ userDefaults setObject:nil forKey:@"tel"];
    [ userDefaults setObject:nil forKey:@"sex"];
    [ userDefaults setObject:nil forKey:@"headerPath"];
    [ userDefaults setObject:nil forKey:@"nickName"];
    [ userDefaults setObject:nil forKey:@"imUserName"];
}

//+ (void)IMlogin{
//    NSString *iminfo = [[User shareUser].tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
//    [JMSGUser loginWithUsername:iminfo password:iminfo completionHandler:^(id resultObject, NSError *error) {
//        if (!error) {
//            //            NSDictionary *parameter = [NSDictionary dictionaryWithObject:[User shareUser].nickName forKey:@"kJMSGUserFieldsNickname"];
//            //            [JMSGUser updateMyInfoWithParameter:parameter userFieldType:kJMSGUserFieldsGender completionHandler:^(id resultObject, NSError *error) {
//            //                if (!error) {
//            //                    //updateMyInfoWithPareter success
//            //                } else {
//            //                    //updateMyInfoWithPareter fail
//            //                }
//            //            }];
//        }
//        
//    }];
//}
//
//+(void)IMlogout{
//    [JMSGUser logout:^(id resultObject, NSError *error) {
//        
//    }];
//}
@end
