//
//  UILabel+LabelHeightAndWidth.h
//  练习
//
//  Created by sc-057 on 2018/10/14.
//  Copyright © 2018 sc-057. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LabelHeightAndWidth)
+(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
+(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
