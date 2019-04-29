//
//  NSString+Additions.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/4/24.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Additions)
@property (nonatomic,readonly) NSString *moneyString;
- (NSString *)moneyStringWithPoint:(int)position;
@end

NS_ASSUME_NONNULL_END
