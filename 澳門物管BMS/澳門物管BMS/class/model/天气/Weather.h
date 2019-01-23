//
//  Weather.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/1/23.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject
@property (nonatomic,copy) NSString *temperature;//温度
@property (nonatomic,copy) NSString *weather;      //天气
@property (nonatomic,copy) NSString *city;     //城市
@end

NS_ASSUME_NONNULL_END
