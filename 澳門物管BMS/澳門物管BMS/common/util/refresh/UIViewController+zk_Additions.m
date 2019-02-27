//
//  UIViewController+zk_Additions.m
//  ZKKit
//
//  Created by pang on 2017/7/13.
//  Copyright © 2017年 zk. All rights reserved.
//

#import "UIViewController+zk_Additions.h"
#import <objc/runtime.h>

#define KALERK_VIEW_KEY @"K_VC_ALERK_VIEW_KEY"

@implementation UIViewController (zk_Additions)

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSUInteger))handler {
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
    [self presentViewController:alertController animated:YES completion:nil];
    
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

- (void)showAlertWithMsg:(NSString *)msg cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(NSUInteger))handler {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:cancelTitle otherTitles:otherTitles handler:handler];
}

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler {
    [self showAlertWithTitle:title andMsg:msg cancelTitle:NSLocalizedString(@"取消", nil) otherTitles:@[NSLocalizedString(@"确定", nil)] handler:handler];
}

- (void)showAlert1WithMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:NSLocalizedString(@"取消", nil) otherTitles:@[NSLocalizedString(@"确定", nil)] handler:handler];
}

- (void)showAlert2WithMsg:(NSString *)msg handler:(void (^)(NSUInteger))handler {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:NSLocalizedString(@"确定", nil) otherTitles:nil handler:handler];
}



- (void)showAlertWithMsg:(NSString *)msg {
    [self showAlertWithTitle:nil andMsg:msg cancelTitle:NSLocalizedString(@"确定", nil) otherTitles:nil handler:nil];
}

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg {
    [self showAlertWithTitle:title andMsg:msg cancelTitle:NSLocalizedString(@"确定", nil) otherTitles:nil handler:nil];
}



#pragma -mark- UIAlertDelegate
#ifdef __IPHONE_8_0
#else
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //获得关联
    void(^block)(NSInteger index) = objc_getAssociatedObject(alertView, KALERK_VIEW_KEY);
    if (block != nil) {
        block(buttonIndex);
    }
}
#endif


+ (UIViewController *)zk_topViewController {
    return [UIApplication sharedApplication].keyWindow.rootViewController.zk_topViewController;
}

- (UIViewController *)zk_topViewController {
    UIViewController *viewC = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigC = (UINavigationController *)self;
        viewC = navigC.topViewController;
        viewC =  [viewC zk_topViewController];
    }else if([self isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabC = (UITabBarController *)self;
        viewC = tabC.selectedViewController;
        viewC = [viewC zk_topViewController];
    }else if(self.presentedViewController != nil){
        viewC = self.presentedViewController;
        viewC = [viewC zk_topViewController];
    }else{
        viewC = self;
    }
    
    return viewC;
}

- (MJRefreshNormalHeader *)createHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    [refreshHeader setTitle:NSLocalizedString(@"下拉刷新", nil) forState:MJRefreshStateIdle];
    [refreshHeader setTitle:NSLocalizedString(@"松开刷新", nil) forState:MJRefreshStatePulling];
    [refreshHeader setTitle:NSLocalizedString(@"加载中...", nil) forState:MJRefreshStateRefreshing];
    return refreshHeader;
}

- (MJRefreshBackNormalFooter *)createFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    [refreshFooter setTitle:NSLocalizedString(@"上拉加载更多", nil) forState:MJRefreshStateIdle];
    [refreshFooter setTitle:NSLocalizedString(@"松开加载更多", nil) forState:MJRefreshStatePulling];
    [refreshFooter setTitle:NSLocalizedString(@"加载中...", nil) forState:MJRefreshStateRefreshing];
    return refreshFooter;
}

- (MJRefreshNormalHeader *)createRefrehHeaderBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {

    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    [refreshHeader setTitle:NSLocalizedString(@"下拉刷新", nil) forState:MJRefreshStateIdle];
    [refreshHeader setTitle:NSLocalizedString(@"松开刷新", nil) forState:MJRefreshStatePulling];
    [refreshHeader setTitle:NSLocalizedString(@"加载中...", nil) forState:MJRefreshStateRefreshing];
    return refreshHeader;
}

- (MJRefreshBackNormalFooter *)createRefreshFooterBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshingBlock];
    [refreshFooter setTitle:NSLocalizedString(@"上拉加载更多", nil) forState:MJRefreshStateIdle];
    [refreshFooter setTitle:NSLocalizedString(@"松开加载更多", nil) forState:MJRefreshStatePulling];
    [refreshFooter setTitle:NSLocalizedString(@"加载中...", nil) forState:MJRefreshStateRefreshing];
    return refreshFooter;
}

@end
