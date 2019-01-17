//
//  RequestResultModel.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/17.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestResultModel : NSObject
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *data;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,strong) NSString *success;
@end

NS_ASSUME_NONNULL_END
