//
//  GradientView.m
//  练习
//
//  Created by sc-057 on 2018/9/4.
//  Copyright © 2018年 sc-057. All rights reserved.
//

#import "GradientView.h"
@interface GradientView()
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@end
@implementation GradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self = [super init];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
    [self creatView];
    return self;
}
- (void)creatView{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self addSubview:self.view];
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.view.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
//    [self.view.layer addSublayer:self.gradientLayer];
//    //设置渐变区域的起始和终止位置（范围为0-1）
//    self.gradientLayer.startPoint = CGPointMake(0.5, 0.0);
//    self.gradientLayer.endPoint = CGPointMake(0, 1);
//    //设置颜色数组
//    self.gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:43/255.0 green:183/255.0 blue:224/255.0 alpha:1.0].CGColor,
//                                  (__bridge id)[UIColor lightGrayColor].CGColor];
    //设置颜色分割点（范围：0-1）
   // self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    NSArray *array = [NSArray arrayWithObjects:[UIColor colorWithRed:43.0/255 green:183.0/255 blue:224.0/255 alpha:1.0].CGColor,[UIColor lightGrayColor].CGColor, nil];
    self.gradientLayer.colors = array;
    self.gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    self.gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
}

@end
