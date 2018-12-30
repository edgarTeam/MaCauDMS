//
//  ZKAlertView.h
//  OA.message
//
//  Created by lee on 16/5/30.
//  Copyright © 2016年 ;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZKAlertTool : NSObject<UIAlertViewDelegate>


+ (instancetype)shareAlertTool;

//普通提示弹窗
+ (void)showAlertWithMsg:(NSString *)msg;
+ (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;

//事件处理的弹窗
+ (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSInteger index))handler;
+ (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSInteger index))handler;


//普通提示弹窗
- (void)showAlertWithMsg:(NSString *)msg;
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;

//事件处理的弹窗
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSInteger index))handler;
- (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void(^)(NSInteger index))handler;

//- (void)showAlertWithMsg:(NSString *)msg handler:(handler)handler;
//- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(handler)handler;
//- (void)showChoiceAlert:(NSString *)message handler:(handler)handler;
//- (void)showChoiceAlert:(NSString *)message doneTitle:(NSString *)doneTitile handler:(handler)handler;
//- (void)showChoiceAlert:(NSString *)message button1Title:(NSString *)title1 button2Title:(NSString *)title2 handler:(handler)handler;
//
//// 可自定义Title
//- (void)showChoiceAlert:(NSString *)message title:(NSString *)title doneTitle:(NSString *)doneTitle handler:(handler)handler;
//- (void)showChoiceAlert:(NSString *)message title:(NSString *)title button1Title:(NSString *)button1Title button2Title:(NSString *)button2Title handler:(handler)handler;
//
////三选择弹窗
//- (void)showChoiceAlert:(NSString *)message button1Title:(NSString *)title1 button2Title:(NSString *)title2 button3Title:(NSString *)title3 handler:(handler)handler;
@end
