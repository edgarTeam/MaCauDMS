//
//  UIViewController+Additions.h
//  SCMessage_VGS
//
//  Created by lee on 16/7/22.
//  Copyright © 2016年 sanchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)<UIAlertViewDelegate>
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSUInteger index))handler;

- (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSUInteger index))handler;
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void(^)(NSUInteger index))handler;
- (void)showAlert1WithMsg:(NSString *)msg handler:(void(^)(NSUInteger index))handler;
- (void)showAlert2WithMsg:(NSString *)msg handler:(void(^)(NSUInteger index))handler;



//普通提示弹窗
- (void)showAlertWithMsg:(NSString *)msg;
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;


//获取最顶层视图控制器
+ (UIViewController *)topViewController;
- (UIViewController *)topViewController;
@end
