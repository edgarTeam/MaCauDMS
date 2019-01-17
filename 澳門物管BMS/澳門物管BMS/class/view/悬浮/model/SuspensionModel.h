//
//  SuspensionModel.h
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;


-(instancetype)initWithName:(NSString *)name image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
