//
//  BaseViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/13.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic,strong)GradientView *gradientView;
@property (nonatomic,strong)NSString *str;
-(void)checkLogin;
- (BOOL)login;
@end

NS_ASSUME_NONNULL_END
