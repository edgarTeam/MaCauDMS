//
//  SuspensionView.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/1.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionView : UIView
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic) BOOL show;

- (void)setShow:(BOOL)show;
@end

NS_ASSUME_NONNULL_END
