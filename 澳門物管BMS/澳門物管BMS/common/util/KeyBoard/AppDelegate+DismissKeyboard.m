//
//  AppDelegate+DismissKeyboard.m
//  DavidQuarry
//
//  Created by 胡嘉宏 on 2018/8/21.
//  Copyright © 2018年 EdgarHu. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate (DismissKeyboard)

/** 开启点击空白处隐藏键盘功能 */
- (void)openTouchOutsideDismissKeyboard;
@end

@implementation AppDelegate (DismissKeyboard)

/** 开启点击空白处隐藏键盘功能 */
- (void)openTouchOutsideDismissKeyboard
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addGesture:) name:UIKeyboardDidShowNotification object:nil];
}
- (void)addGesture:(NSNotification *)info
{
    if (! self.keyboardTap) {
       self.keyboardTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearKeyboard)];
          self.keyboardTap.cancelsTouchesInView = NO;
        [self.window addGestureRecognizer:self.keyboardTap];
    }
}

- (void)disappearKeyboard
{
    [self.window endEditing:YES];
    if ([self.window.gestureRecognizers containsObject:self.keyboardTap]) {
          [self.window removeGestureRecognizer:self.keyboardTap];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

