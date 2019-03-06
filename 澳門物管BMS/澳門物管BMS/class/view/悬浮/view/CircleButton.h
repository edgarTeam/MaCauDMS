//
//  CircleButton.h
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuspensionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleButton : UIButton

- (instancetype)initWithModel:(SuspensionModel *)model;

@end

NS_ASSUME_NONNULL_END
