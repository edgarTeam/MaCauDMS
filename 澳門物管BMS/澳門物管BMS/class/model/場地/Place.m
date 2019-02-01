//
//  Plate.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "Place.h"

@implementation Place
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    return  self;
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"images" : [NoticeSubList class]};
    
}
@end
