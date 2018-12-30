//
//  User.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "User.h"

@implementation User

static User *_instance;
static dispatch_once_t onceToken;
static dispatch_once_t onceToken2;

//单例重写alloc方法
+ (id)allocWithZone:(NSZone *)zone
{
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (User *)shareUser
{
    dispatch_once(&onceToken2, ^{
        if(_instance == nil)
            _instance = [[User alloc] init];
    });
    return _instance;
}

+ (void)clear{
    _instance = nil;
    onceToken2 = 0;
    onceToken = 0;
}


@end
