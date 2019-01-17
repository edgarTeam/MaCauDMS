//
//  SuspensionMenu.h
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  SuspensionMenuDelegate <NSObject>
- (void)selectMenuAtIndex:(NSInteger)index;
@end

@interface SuspensionMenu : UIView
@property (nonatomic,assign) id<SuspensionMenuDelegate> delegate;
- (instancetype) initWithCenterImage:(UIImage  *)image menuData:(NSArray *)Menus;

@end

NS_ASSUME_NONNULL_END
