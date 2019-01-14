//
//  UpdateHelper.m
//  DavidQuarry
//
//  Created by 胡嘉宏 on 2018/7/31.
//  Copyright © 2018年 EdgarHu. All rights reserved.
//

#import "UpdateHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>
#define kUpdataParser "updataParserKey"
@interface UpdateHelper() <NSXMLParserDelegate,UIAlertViewDelegate>
@property (nonatomic) BOOL isNew;

@end

@implementation UpdateHelper
//int _requestCount;
static UpdateHelper *_instance;

+ (id) allocWithZone:(NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return  _instance;
}

+ (UpdateHelper *)shareUpdateHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}


- (void)                                                                                        checkUpdateInfo{
    [SVProgressHUD show];
    [self checkIsNewWithBlock:^(NSString *version,BOOL isNew) {
        if (isNew) {
            [SVProgressHUD dismiss];
            return;
            
        }
        
        NSInteger id_ = arc4random();
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%ld",UPDATE_WEB_URL,(long)id_]];
        NSURLRequest *request = [NSURLRequest  requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error == nil) {
                [SVProgressHUD dismiss];
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:data options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                [self showUpdateAlert:attrStr.string];
            
            }else{
                [SVProgressHUD dismiss];
                NSLog(@"%@",error);
            }
        }];
        
        //5.执行任务
        [dataTask resume];
    }];
}


//#pragma -mark- 檢查AppStore版本

- (void)showUpdateAlert:(NSString *)infoStr {
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:LocalizedString(@"String_check_update")
                                                                       message:infoStr
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:LocalizedString(@"String_cancel_update") style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                                  NSLog(@"action = %@", action);
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:LocalizedString(@"String_continue_update") style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"" message:LocalizedString(@"String_update_alert") preferredStyle:UIAlertControllerStyleAlert];
                                                                 
                                                                 UIAlertAction* noAction = [UIAlertAction actionWithTitle:LocalizedString(@"String_cancel") style:UIAlertActionStyleDefault
                                                                                                                       handler:^(UIAlertAction * action) {
                                                                                                                                                                                                                                                  }];
                                                                 
                                                                 UIAlertAction* yesAction = [UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault
                                                                                                                       handler:^(UIAlertAction * action) {
                                                                                                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UPDATE_URL]];
                                                                                                                           
                                                                                                                           [self performSelector:@selector(exitApplication) withObject:nil afterDelay:1];                                                              }];
                                                                 
                                                                 [alertvc addAction:noAction];
                                                                 
                                                                 [alertvc addAction:yesAction];
                                                   [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertvc animated:YES completion:nil];
                                                             }];
    
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];



}


#pragma -mark- 檢查是否最新版本
- (void)checkIsNewWithBlock:(void (^)(NSString *vesion, BOOL isNew))block {
    static BOOL isCheck = NO;
    if (isCheck) {
        [SVProgressHUD dismiss];
        return;
    }
    isCheck = YES;
    NSInteger id_ = arc4random();
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?device=1&id=%ld",CHECK_UPDATE_URL,(long)id_]];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSXMLParser *checkUpdataParser = [[NSXMLParser alloc]initWithData:data];
            checkUpdataParser.delegate = self;
            
                                 if (block != nil) {
                                     objc_setAssociatedObject(checkUpdataParser, kUpdataParser, block, OBJC_ASSOCIATION_COPY);
                                 }
            
                                 [checkUpdataParser parse];
            
        }else{
            [SVProgressHUD dismiss];
            NSLog(@"%@",error);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
    
}

- (void)exitApplication {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    window.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}

#pragma -mark- xml
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    void(^block)(NSString *version,BOOL isNew) = objc_getAssociatedObject(parser, kUpdataParser);
    
    if ( [elementName isEqualToString:@"config"]) {
        NSString *version = [attributeDict objectForKey:@"ver"];
        NSString *currentVersion = APP_VERSION;
        
        NSString *versionStr = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
        currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        double doubleversion = [versionStr doubleValue];
        double doublecurrentversion = [currentVersion doubleValue];
        self.isNew = doublecurrentversion >= doubleversion;
        if (block != nil) {
            block(version,_isNew);
        }
        
    }
}

@end
