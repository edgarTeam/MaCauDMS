//
//  UILabel+LabelFont.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/5.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "UILabel+LabelFont.h"
#import <objc/runtime.h>
@implementation UILabel (LabelFont)

+(void)load{
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        //Class class = objc_getClass((id)self);
        
        //替换三个方法
        SEL selector_init = @selector(init);
        SEL selector_initWithFrame = @selector(initWithFrame:);
        SEL selector_awakeFromeNib = @selector(awakeFromNib);
        
        SEL selector_lfinit = @selector(AGinit);
        SEL selector_lfinitWithFrame = @selector(AGinitWithFrame:);
        SEL selector_lfawakeFromeNib = @selector(AGawakeFromNib);
        
        Method method_init = class_getInstanceMethod(class, selector_init);
        Method method_initWithFrame = class_getInstanceMethod(class, selector_initWithFrame);
        Method method_awakeFromeNib = class_getInstanceMethod(class, selector_awakeFromeNib);
        
        Method method_lfinit = class_getInstanceMethod(class, selector_lfinit);
        Method method_lfinitWithFrame = class_getInstanceMethod(class, selector_lfinitWithFrame);
        Method method_lfawakeFromeNib = class_getInstanceMethod(class, selector_lfawakeFromeNib);
        
        
        BOOL didAddMethod_init = class_addMethod(class, selector_init, method_getImplementation(method_lfinit), method_getTypeEncoding(method_lfinit));
        BOOL didAddMethod_initWithFrame = class_addMethod(class, selector_initWithFrame, method_getImplementation(method_lfinitWithFrame), method_getTypeEncoding(method_lfinitWithFrame));
        BOOL didAddMethod_awakeFromeNib = class_addMethod(class, selector_awakeFromeNib, method_getImplementation(method_lfawakeFromeNib), method_getTypeEncoding(method_lfawakeFromeNib));
        
        
        
        if (didAddMethod_init) {
            class_replaceMethod(class, selector_lfinit, method_getImplementation(method_init), method_getTypeEncoding(method_init));
        }else{
            
            method_exchangeImplementations(method_init, method_lfinit);
        }
        
        if (didAddMethod_initWithFrame) {
            class_replaceMethod(class, selector_lfinitWithFrame, method_getImplementation(method_initWithFrame), method_getTypeEncoding(method_initWithFrame));
        }else{
            
            method_exchangeImplementations(method_initWithFrame, method_lfinitWithFrame);
        }
        
        if (didAddMethod_awakeFromeNib) {
            class_replaceMethod(class, selector_lfawakeFromeNib, method_getImplementation(method_awakeFromeNib), method_getTypeEncoding(method_awakeFromeNib));
        }else{
            
            method_exchangeImplementations(method_awakeFromeNib, method_lfawakeFromeNib);
        }
        
        
        
    });
    
}
#pragma mark - 在以下方法中更换字体
-(instancetype)AGinit{
    id _self = [self AGinit];
    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    if ([lang isEqualToString:@"zh-Hant"]) {
        
        
         self.font = [UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:self.font.pointSize];
    }else{
        self.font = [UIFont fontWithName:@"cwTeXQHei-Bold" size:self.font.pointSize];
        
    }
    
   
//    if (font) {
//        self.font = font;
//    }
    return _self;
    
}
-(instancetype)AGinitWithFrame:(CGRect)frame{
    id _self = [self AGinitWithFrame:frame];
   // UIFont *font = [UIFont fontWithName:@"Copperplate-Bold" size:self.font.pointSize];
//    UIFont *font = [UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:self.font.pointSize];
//    if (font) {
//        self.font = font;
//    }
    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    if ([lang isEqualToString:@"zh-Hant"]) {
        
        
        self.font = [UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:self.font.pointSize];
    }else{
        self.font = [UIFont fontWithName:@"cwTeXQHei-Bold" size:self.font.pointSize];
        
    }
    return _self;
}

-(void)AGawakeFromNib{
    [self AGawakeFromNib];
   // UIFont *font = [UIFont fontWithName:@"Copperplate-Bold" size:self.font.pointSize];
//    UIFont *font = [UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:self.font.pointSize];
//    if (font) {
//        self.font = font;
//    }
    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    if ([lang isEqualToString:@"zh-Hant"]) {
        
        
        self.font = [UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:self.font.pointSize];
    }else{
        self.font = [UIFont fontWithName:@"cwTeXQHei-Bold" size:self.font.pointSize];
        
    }
}





@end
