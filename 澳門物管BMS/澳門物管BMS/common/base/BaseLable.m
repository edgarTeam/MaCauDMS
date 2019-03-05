//
//  BaseLable.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/5.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "BaseLable.h"

@interface BaseLable()

@end

@implementation BaseLable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initFont {
    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    if ([lang isEqualToString:@"zh-Hant"]) {
        
        self.font=[UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:16];
    }else{
        self.font=[UIFont fontWithName:@"cwTeXQHei-Bold" size:16];
    }
    return self;
}

@end
