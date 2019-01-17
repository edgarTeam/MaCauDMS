//
//  SuspensionModel.m
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//

#import "SuspensionModel.h"

@implementation SuspensionModel

-(instancetype)initWithName:(NSString *)name image:(NSString *)image{
    self = [super init];
    self.name = name;
    self.image = image;
    return self;
}

@end
