//
//  BaseViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/13.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"
#import "UIViewController+MMDrawerController.h"
//#import "BaseLable.h"
#import "UILabel+LabelFont.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic,strong)GradientView *gradientView;
@property (nonatomic,strong)NSString *str;
@property (nonatomic,strong)NSString *token;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *baseTitleLab;
//@property (nonatomic,assign)CGFloat statusRectHeight;
//@property (nonatomic,assign)CGFloat navRectHeight;
//@property (nonatomic,assign)CGFloat totleHeight;
-(void)checkLogin;
- (BOOL)login;
@end

NS_ASSUME_NONNULL_END
