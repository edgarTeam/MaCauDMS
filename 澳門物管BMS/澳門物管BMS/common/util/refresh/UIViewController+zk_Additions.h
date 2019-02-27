//
//  UIViewController+zk_Additions.h
//  ZKKit
//
//  Created by pang on 2017/7/13.
//  Copyright © 2017年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIViewController (zk_Additions)

/**
 获取最顶层ViewController

 @return UIViewContoller
 */
- (UIViewController *)zk_topViewController;
+ (UIViewController *)zk_topViewController;

#pragma -mark- 警告框
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSUInteger))handler;
- (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSUInteger))handler;
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler;
- (void)showAlert1WithMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler;
- (void)showAlert2WithMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler;
- (void)showAlertWithMsg:(NSString *)msg;
- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;

- (MJRefreshNormalHeader *)createHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (MJRefreshBackNormalFooter *)createFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (MJRefreshNormalHeader *)createRefrehHeaderBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
- (MJRefreshBackNormalFooter *)createRefreshFooterBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end
