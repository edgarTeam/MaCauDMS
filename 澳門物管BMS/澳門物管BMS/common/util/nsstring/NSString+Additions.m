//
//  NSString+Additions.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/4/24.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)moneyString {
    NSString *moneyString =  objc_getAssociatedObject(self, @selector(moneyString));
    if (moneyString == nil) {
        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:self];
        if ([decNum isEqualToNumber:[NSDecimalNumber notANumber]]) {
            moneyString = @"0";
        } else {
            moneyString = [decNum stringValue];
        }
        objc_setAssociatedObject(self, @selector(moneyString), moneyString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return moneyString;
}

- (NSString *)moneyStringWithPoint:(int)position {
    NSString *moneyString =  objc_getAssociatedObject(self, @selector(moneyStringWithPoint:));
    if (moneyString == nil) {
        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                           decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                           scale:position
                                           raiseOnExactness:NO
                                           raiseOnOverflow:NO
                                           raiseOnUnderflow:NO
                                           raiseOnDivideByZero:YES];
        NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *roundingNum = [decNum decimalNumberByRoundingAccordingToBehavior:roundUp];
        if ([roundingNum isEqualToNumber:[NSDecimalNumber notANumber]]) {
            moneyString = @"0";
        } else {
            moneyString = [roundingNum stringValue];
        }
        objc_setAssociatedObject(self, @selector(moneyString), moneyString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return moneyString;
}
@end
