//
//  SuspendView.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/6.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  SuspendViewDelegate <NSObject>
- (void)selectMenuAtIndex:(NSInteger)index;
@end

@interface SuspendView : UIView
@property (nonatomic,assign) id<SuspendViewDelegate> delegate;
- (instancetype) initWithCenterImage:(UIImage  *)image menuData:(NSArray *)Menus;
@end

NS_ASSUME_NONNULL_END
