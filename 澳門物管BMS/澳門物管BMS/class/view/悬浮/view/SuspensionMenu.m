//
//  SuspensionMenu.m
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "SuspensionMenu.h"
#import "SuspensionModel.h"
#import "CircleButton.h"
@interface SuspensionMenu ()
@property (nonatomic, strong) NSArray *menus;
@property (nonatomic, strong) UIButton *centerBtn;

@end
@implementation SuspensionMenu
{
    CGRect originFrame;
    CGAffineTransform _transform;
    Boolean isHide,isHorAdsorb;
    UIPanGestureRecognizer *dragPan;
}


-(instancetype)initWithCenterImage:(UIImage *)image menuData:(NSArray *)menus{
    self  = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    originFrame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.menus = menus;
    isHide = NO;
    isHorAdsorb = YES;
    [self.centerBtn  setImage:image forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(centerDidClick:) forControlEvents:UIControlEventTouchUpInside];
//    dragPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlerDrage)];
//    dragPan.maximumNumberOfTouches= 1;
//    dragPan.minimumNumberOfTouches = 1;
//    [self.centerBtn addGestureRecognizer:dragPan];
    [self addSubview:_centerBtn];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    [self addButtons];
    return self;
}

-(void)handSingleTap:(UITapGestureRecognizer *)tagRec{
    if (!isHide) {
        [self hideView];
    }
}

-(void)centerDidClick:(UIButton *)btn{
    if (isHide) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationDelegate:self];
        self.frame = originFrame;
        self.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        _centerBtn.frame = CGRectMake(0, 0, 100, 100);
        _centerBtn.layer.cornerRadius = 50;
        self.centerBtn.center = self.center;
        [UIView commitAnimations];
        [self performSelector:@selector(showSubView) withObject:nil afterDelay:.5];
    }else{
        [self hideView];
        [self.delegate selectMenuAtIndex:1000];
    }
}

- (void)showSubView{
    for (UIView *subView in self.subviews) {
        if ([subView isEqual:_centerBtn]) {
            
        }else{
            subView.hidden = NO;
            [self showAnimation:subView];
        }
    }
    isHide = NO;
}

- (void)showAnimation:(UIView *)subview{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    subview.center = [self caculatePointAtButtonIndex:subview.tag];
    [UIView commitAnimations];
}

- (CGPoint)caculatePointAtButtonIndex:(NSInteger)index{
    double radiu =2 * (double)index * M_PI/[self.menus count];
    CGFloat xPoint = sin(radiu)*(120.f/320*ScreenWidth) + self.center.x;
    CGFloat yPoint = (-1 * cos(radiu) * (120.f/320*ScreenWidth)) + self.center.y;
    return CGPointMake(xPoint, yPoint);
}

- (void)handlerDrage{
    if (isHide) {
        CGPoint point = [dragPan locationInView:self.superview];
        self.center = point;
        if (dragPan.state == UIGestureRecognizerStateEnded) {
            [self caculateDragPoint:point];
        }
    }
}


- (void)caculateDragPoint:(CGPoint)point{
    CGPoint newPoint;
    if (point.y > ScreenHeight-150) {
        isHorAdsorb = NO;
    }else if (point.y < 150){
        isHorAdsorb = NO;
    }else{
        isHorAdsorb = YES;
    }
    if (isHorAdsorb) {
        if (point.x > ScreenWidth/2) {
            newPoint = CGPointMake(ScreenWidth-30, point.y);
        }else{
            newPoint = CGPointMake(30, point.y);
        }
    }else{
        CGFloat xPoint = point.x;
        if (xPoint <30) {
            xPoint = 30;
        }else if (xPoint > ScreenWidth-30){
            xPoint = ScreenWidth-30;
        }
        
        if (point.y > ScreenHeight/2) {
            newPoint = CGPointMake(xPoint, ScreenHeight-30);
        }else{
             UIEdgeInsets safeAreaInsets = sgm_safeAreaInset(self);
            CGFloat y = 30;
            y += safeAreaInsets.top > 0 ? safeAreaInsets.top : 20.0;
            newPoint = CGPointMake(xPoint, y);
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",newPoint.x] forKey:@"centerLocationX"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",newPoint.y] forKey:@"centerLocationY"];
    self.center = newPoint;

}

static inline UIEdgeInsets sgm_safeAreaInset(UIView *view) {
        if (@available(iOS 11.0, *)) {
            return view.safeAreaInsets;
        }
        return UIEdgeInsetsZero;
    }



- (void)addButtons {
    int i = 0;
    for (SuspensionModel *model in self.menus) {
        double radiu =2 * (double)i * M_PI/[self.menus count];
        CGFloat xPoint = sin(radiu)*(120.f/320*ScreenWidth)+self.center.x;
        CGFloat yPoint = (-1 * cos(radiu) * (120.f/320*ScreenWidth))+ self.center.y;
        CircleButton *btn = [[CircleButton alloc] initWithModel:model];
        btn.tag = i;
        [btn addTarget:self action:@selector(menuBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.center = CGPointMake(xPoint, yPoint);
        [self addSubview:btn];
        i++;
    }
}


-(void)menuBtnDidClick:(CircleButton *)btn{
    [self hideView];
    [self.delegate selectMenuAtIndex:btn.tag];
}


-(void) hideView {
    for (UIView *subView in self.subviews) {
        if ([subView isEqual:_centerBtn]) {
            [self bringSubviewToFront:subView];
        }else{
            [self hideAnimation:subView];
        }
    }
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5];
}


- (void)hideAnimation:(UIView *)subView {
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:.2];
//    [UIView setAnimationDelegate:self];
   
//    [UIView commitAnimations];
    [UIView animateWithDuration:0.2 animations:^{
        subView.center = self.center;
    } completion:^(BOOL finished) {
        subView.hidden = YES;
    }];
    
}

- (void)delayMethod {
    for (UIView *subView in self.subviews) {
        if ([subView isEqual:_centerBtn]) {
            [self bringSubviewToFront:subView];
        }else{
            subView.hidden = YES;
        }
        
    }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.2];
        [UIView setAnimationDelegate:self];
        self.frame = CGRectMake(0, 20, 60, 60);
        self.centerBtn.frame = CGRectMake(0, 0, 60, 60);
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    if ([userdefault objectForKey:@"centerLocationX"]&&[userdefault objectForKey:@"centerLocationY"]) {
//        CGFloat xPoint = [[userdefault objectForKey:@"centerLocationX"] floatValue];
//        CGFloat yPoint = [[userdefault objectForKey:@"centerLocationY"] floatValue];
//        self.center = CGPointMake(xPoint, yPoint);
//    }
    CGFloat xPoint = ScreenWidth-40;
    CGFloat yPoint = ScreenHeight-34;
    self.center = CGPointMake(xPoint, yPoint);
    self.centerBtn.layer.cornerRadius = 30;
    [UIView commitAnimations];
    isHide = YES;
   
}



#pragma getter
-(UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, ScreenHeight/2-50, 100, 100)];
        _centerBtn.layer.masksToBounds = YES;
        _centerBtn.layer.cornerRadius = 50;
    }
    return _centerBtn;
}
//var orginImg:UIImage?
//var centerView:UIImageView?
//var dragPan:UIPanGestureRecognizer?
//var delegate:MenuViewDelegate?
//var isHorAdsorb : Bool?


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
