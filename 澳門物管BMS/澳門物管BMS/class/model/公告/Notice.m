//
//  Notice.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/24.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "Notice.h"

@implementation Notice
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"noticeImage" : [NoticeSubList class]};
    
}
@end
