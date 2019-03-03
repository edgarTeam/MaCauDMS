//
//  UITextField+PlaceHolder.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/28.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PlaceHolder)


/** 占位文字 */
@property (copy, nonatomic) NSString *placeHoldString;

/** 占位文字颜色 */
@property (strong, nonatomic) UIColor *placeHoldColor;

/** 占位文字字体 */
@property (strong, nonatomic) UIFont *placeHoldFont;


@end

NS_ASSUME_NONNULL_END
