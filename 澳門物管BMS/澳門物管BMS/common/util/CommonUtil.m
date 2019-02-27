//
//  CommonUtil.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#import "ZKAlertTool/ZKAlertTool.h"
#import "CommonUtil.h"
#import "User.h"
#import "LoginViewController.h"
#import "DrawerViewController.h"
#import "BaseNavigationViewController.h"
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
        NSLog(@"信息%@",[dictResp objectForKey:@"msg"] );
        NSLog(@"%d",[[dictResp objectForKey:@"code"] intValue]);
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
            case 100:
            {
                [ZKAlertTool showAlertWithTitle:nil andMsg:LocalizedString(@"string_request_login_miss_code") cancelTitle:@"确定" otherTitles:nil handler:^(NSInteger tag){
                    LoginViewController *loginVC=[[LoginViewController alloc] init];
                    DrawerViewController *drawer=(DrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                    BaseNavigationViewController *nav=drawer.centerViewController;
                    if (![nav.topViewController isKindOfClass:[LoginViewController class]]) {
                        [nav pushViewController:loginVC animated:YES];
                        [drawer closeDrawerAnimated:YES completion:^(BOOL finished){
                            [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                        }];
                    }
                   
                   
                }];
//                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_request_login_miss_code")];
//                UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:LocalizedString(@"string_request_login_miss_code") preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *alertAc=[UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                    LoginViewController *loginVC=[[LoginViewController alloc] init];
////                    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
////
////
////                    [nav pushViewController:loginVC animated:YES];
////                    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
////                        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
////                    }];
//                }];
//                [alert addAction:alertAc];
               
               // [self presentViewController:alert animated:YES completion:nil];
//
                return  NO;
            }
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
            case 200:{
                
                return  YES;
                
            }
            case 105:{
                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_request_login_error_code")];
                return NO;
            }
            case 401:{
//                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_requset_place_erroe_code")];
                [ZKAlertTool showAlertWithMsg:[dictResp objectForKey:@"msg"]];
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

+ (void)storeUser{
    User *user =  [User shareUser];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [ userDefaults setObject:user.birthday forKey:@"birthday"];
    [ userDefaults setObject:user.communityId forKey:@"communityId"];
    [ userDefaults setObject:user.countryCode forKey:@"countryCode"];
    [ userDefaults setObject:user.deleted forKey:@"deleted"];
    [ userDefaults setObject:user.email forKey:@"email"];
    [ userDefaults setObject:user.englishName forKey:@"englishName"];
    [ userDefaults setObject:user.idCard forKey:@"idCard"];
    [ userDefaults setObject:user.marriageSystem forKey:@"marriageSystem"];
    [ userDefaults setObject:user.mateName forKey:@"mateName"];
    [ userDefaults setObject:user.name forKey:@"name"];
    [ userDefaults setObject:user.portrait forKey:@"portrait"];
    [ userDefaults setObject:user.sex forKey:@"sex"];
    [ userDefaults setObject:user.tel forKey:@"tel"];
    [ userDefaults setObject:user.userId forKey:@"userId"];
    [ userDefaults setObject:user.username forKey:@"username"];
}
//
//
+ (void)loadDefuatUser{
    User *user =  [User shareUser];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"userId"]!= nil && [[userDefaults objectForKey:@"userId"] length] > 0) {
        user.userId = [userDefaults objectForKey:@"userId"];
        user.birthday = [userDefaults objectForKey:@"birthday"];
        user.tel = [userDefaults objectForKey:@"tel"];
        user.communityId =[userDefaults objectForKey:@"communityId"];
        user.sex = [userDefaults objectForKey:@"sex"] ;
        user.countryCode=[userDefaults objectForKey:@"countryCode"];
//        user.deleted=[userDefaults objectForKey:@"deleted"];
        user.email=[userDefaults objectForKey:@"email"];
        user.englishName=[userDefaults objectForKey:@"englishName"];
        user.idCard=[userDefaults objectForKey:@"idCard"];
        user.marriageSystem=[userDefaults objectForKey:@"marriageSystem"];
        user.mateName=[userDefaults objectForKey:@"mateName"];
        user.name=[userDefaults objectForKey:@"name"];
        user.portrait=[userDefaults objectForKey:@"portrait"];
        user.userId=[userDefaults objectForKey:@"userId"];
        user.username=[userDefaults objectForKey:@"username"];

        
    }
}

+ (NSString *)dateTimeWithYYMMDDHHMM:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return  [formatter stringFromDate:date];
}

+ (void)clearDefuatUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [ userDefaults setObject:nil forKey:@"birthday"];
    [ userDefaults setObject:nil forKey:@"communityId"];
    [ userDefaults setObject:nil forKey:@"countryCode"];
    [ userDefaults setObject:nil forKey:@"deleted"];
    [ userDefaults setObject:nil forKey:@"email"];
    [ userDefaults setObject:nil forKey:@"englishName"];
    [ userDefaults setObject:nil forKey:@"idCard"];
    [ userDefaults setObject:nil forKey:@"marriageSystem"];
    [ userDefaults setObject:nil forKey:@"mateName"];
    [ userDefaults setObject:nil forKey:@"name"];
    [ userDefaults setObject:nil forKey:@"portrait"];
    [ userDefaults setObject:nil forKey:@"sex"];
    [ userDefaults setObject:nil forKey:@"tel"];
    [ userDefaults setObject:nil forKey:@"userId"];
    [ userDefaults setObject:nil forKey:@"username"];
    
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

+(void)addGradientLayerTo:(id)object{
    UIViewController *vc =  nil;
    UIView *view = nil;
    CGRect frame = CGRectZero;
    if ([object isKindOfClass:[UIViewController class]]) {
        vc = (UIViewController *)object;
        frame = vc.view.frame;
        
    }else if ([object isKindOfClass:[UIView class]]){
        view = (UIView *)object;
        frame = view.frame;
    }
    UIView *layerView = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.bounds = frame;
    layer.frame = frame;
    layer.borderWidth = 0;
    NSArray *array = [NSArray arrayWithObjects:[UIColor colorWithRed:43.0/255 green:183.0/255 blue:224.0/255 alpha:1.0].CGColor,[UIColor lightGrayColor].CGColor, nil];
    layer.colors = array;
    layer.startPoint = CGPointMake(0.5, 0.5);
    layer.endPoint = CGPointMake(0.5, 1.0);
    [layerView.layer insertSublayer:layer atIndex:0];
    if (vc) {
        [vc.view addSubview:layerView];
    }else{
        [view addSubview:layerView];
    }
}

+ (BOOL)isRequestWeatherOK:(id)response {
    if ([response isKindOfClass: [NSDictionary class]]){
        NSDictionary *dictResp = (NSDictionary *)response;
       // NSLog(@"信息%@",[dictResp objectForKey:@"msg"] );
       // NSLog(@"%d",[[dictResp objectForKey:@"code"] intValue]);
        switch ([[dictResp objectForKey:@"resultcode"] intValue]) {
            case 100:
            {
               // [ZKAlertTool showAlertWithMsg:@"未登录/登陆缓存已过期，请重新登陆"];
                return  NO;
            }
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
            case 200:{
                
                return  YES;
                
            }
            case 105:{
             //   [ZKAlertTool showAlertWithMsg:@"账号或者密码不对"];
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

+ (BOOL)isRequestMapOK:(id)response{
    if ([response isKindOfClass: [NSDictionary class]]){
        NSDictionary *dictResp = (NSDictionary *)response;
//        if ([[dictResp objectForKey:@"info"] isEqualToString:@"OK"]) {
//            return YES;
//        }else{
//            return NO;
//        }
        switch ([[dictResp objectForKey:@"infocode"] intValue]) {
            case 10000:
            {
                return  YES;
            }
            case 10009:
            {
                return  NO;
            }
            default:
                NSLog(@"Util Response ,  No this error code");
                return NO;
        }
    } else{
        NSLog(@"Util Response , missing key code");
        return NO;
    }
}

@end
