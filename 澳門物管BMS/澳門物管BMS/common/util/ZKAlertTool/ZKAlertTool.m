//
//  ZKAlertView.m
//  OA.message
//
//  Created by lee on 16/5/30.
//  Copyright © 2016年 sanchun. All rights reserved.
//

#import "ZKAlertTool.h"
#import <objc/runtime.h>
#import "UIViewController+Additions.h"

#define kAlertToolKey @"kAlertToolKey"

static ZKAlertTool *alertTool = nil;
static dispatch_once_t once;


@implementation ZKAlertTool

+ (instancetype)shareAlertTool {
    dispatch_once(&once, ^{
        alertTool = [[[self class]alloc]init];
    });
    return alertTool;
}

+ (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSInteger))handler{
    [[self shareAlertTool] showAlertWithTitle:title andMsg:msg cancelTitle:cancelTitle otherTitles:otherTitles handler:handler];
}

+ (void)showAlertWithMsg:(NSString *)msg {
    [[self shareAlertTool]showAlertWithMsg:msg];
}

+ (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg {
    [[self shareAlertTool] showAlertWithTitle:title andMsg:msg];
}

+ (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSInteger))handler {
    [[self shareAlertTool] showAlertWithMsg:msg cancelTitle:cancelTitle otherTitles:otherTitles handler:handler];
}

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSInteger))handler {
#ifdef __IPHONE_8_0
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (handler != nil) {
            handler(0);
        }
    }];
    [alertController addAction:cancelAction];
    [otherTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      UIAlertAction *otherAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          if (handler != nil) {
              handler(idx + 1);
          }
          
      }];
        [alertController addAction:otherAction];
    }];
    [[UIViewController topViewController] presentViewController:alertController animated:YES completion:nil];
    
#else
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    for (NSString *otherTitle in otherTitles) {
        [alertView addButtonWithTitle:otherTitle];
    }
    //建立关联 关联对象 key 值 对象关联策略
    if (handler != nil) {
        objc_setAssociatedObject(alertView, kAlertToolKey, handler, OBJC_ASSOCIATION_COPY);
    }
    
    [alertView show];
#endif
}

- (void)showAlertWithMsg:(NSString *)msg {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:NSLocalizedString(@"确定", nil) otherTitles:nil handler:nil];
}

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg {
    [self showAlertWithTitle:title andMsg:msg cancelTitle:NSLocalizedString(@"确定", nil) otherTitles:nil handler:nil];
}

- (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSInteger))handler {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:cancelTitle otherTitles:otherTitles handler:handler];
}

#pragma -mark- UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //获得关联
    void(^block)(NSInteger index) = objc_getAssociatedObject(alertView, kAlertToolKey);
    if (block != nil) {
        block(buttonIndex);
    }
}

@end
