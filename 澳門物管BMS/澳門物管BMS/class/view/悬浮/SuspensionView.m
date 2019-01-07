//
//  SuspensionView.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/1.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "SuspensionView.h"
@interface SuspensionView()
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,strong)  UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic,strong) NSMutableArray *btnArr;
@end
@implementation SuspensionView
{
    CGFloat theCenterX;
    CGFloat theCenterY;
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
    int a;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)init{
//    self = [super init];
//    return self;
//
//    [self createView];
//}

-(instancetype)init{
    self = [super init];
    //self.userInteractionEnabled=YES;
  //  self.frame = CGRectMake(0, 0, ScreenWidth,  ScreenHeight);
     self.frame = CGRectMake(0, 0, ScreenWidth,  ScreenHeight);
    self.backgroundColor=[UIColor clearColor];
   // self.gra=[[GradientView alloc] init];
   // [self addSubview:self.gra];
    [self createView];
    return self;
}


- (void)createView {
    radius=ScreenWidth/2-35-25-10;
    self.centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight-60, 50, 50);
    
    [self.centerBtn setImage:[UIImage imageNamed:@"zhuye-4"] forState:UIControlStateNormal];
    self.centerBtn.layer.cornerRadius=self.centerBtn.frame.size.width/2;
    self.centerBtn.layer.cornerRadius=25;
    self.centerBtn.layer.masksToBounds=YES;
    [self.centerBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.window.rootViewController.view addSubview:self.centerBtn];
    [self addSubview:self.centerBtn];
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                             
                             initWithTarget:self
                             
                             action:@selector(handlePan:)];
    
    [self.centerBtn addGestureRecognizer:_panGestureRecognizer];
    [self.centerBtn addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    _btnArr=[NSMutableArray array];
    self.arr=[NSMutableArray arrayWithObjects:@"complain",@"place",@"repairsec",@"settingsec",nil];
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.window.rootViewController.view];
    centerX=recognizer.view.center.x+ translation.x;
    centerY=recognizer.view.center.y+ translation.y;
    theCenterX=centerX;
    theCenterY=centerY;
    recognizer.view.center=CGPointMake(centerX,centerY);
    [recognizer setTranslation:CGPointZero inView:self.window.rootViewController.view];
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        if(centerX>ScreenWidth/2) {
            theCenterX=ScreenWidth-50/2;
        }else{
            theCenterX=50/2;
        }
        if (centerY >ScreenHeight-40 ) {
            theCenterY=ScreenHeight-60;
        }else if(centerY <40){
            theCenterY=60;
        }
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.center=CGPointMake(theCenterX,theCenterY);
        }];
    }
    
}

-(void)choose:(UIButton *)btn{
   // self.centerBtn.selected=self.show=!self.show;
        if (self.centerBtn.selected) {
            self.show=NO;
        }else{
            self.show=YES;
        }
}
- (void)addBtn{
//    _btnArr=[NSMutableArray array];
//    self.arr=[NSMutableArray arrayWithObjects:@"complain",@"place",@"repairsec",@"settingsec",nil];
    int a=360/self.arr.count;
    
    for (int i = 0; i < self.arr.count; i++) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.tag = i+1;
        _button1.layer.cornerRadius = 50/2;
        _button1.layer.masksToBounds = YES;
        _button1.userInteractionEnabled = YES;
        NSString *name=[self.arr objectAtIndex:i];
        [_button1 setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        _button1.hidden=NO;
        _button1.frame=CGRectMake(ScreenWidth/2-25, ScreenHeight/2-25, 50, 50);
        
      //  _button1.backgroundColor=[UIColor blackColor];
        
        [_button1 addTarget:self action:@selector(handleClick:)forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button1];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat x=[UIScreen mainScreen].bounds.size.width/2-25+radius*cosf((_button1.tag-1)*a*3.1415926/180);
            CGFloat y=[UIScreen mainScreen].bounds.size.height/2-25+radius*sinf((_button1.tag-1)*a*3.1415926/180);
            _button1.frame=CGRectMake(x, y, 50, 50);
        }completion:^(BOOL finish){
            self.centerBtn.userInteractionEnabled=YES;
        }];
        [_btnArr addObject:_button1];
        // NSLog(@"%ld",_btnArr.count);
    }
    NSLog(@"%ld",_btnArr.count);
}

- (void)setShow:(BOOL)show{
    //NSLog(@"%@",YES?@"YES":@"NO",show);
    NSLog(@"%@",show?@"YES":@"NO");
    self.centerBtn.userInteractionEnabled=NO;
    _show=show;
    self.centerBtn.selected=show;
    
    
    NSLog(@"%ld",_btnArr.count);
    //   array=_btnArr;
    
    if (!show) {
        if(centerX>ScreenWidth/2) {
            theCenterX=ScreenWidth-50/2;
        }else{
            theCenterX=50/2;
        }
        
        if (centerY >ScreenHeight-40 ) {
            theCenterY=ScreenHeight-60;
        }else if(centerY <40){
            theCenterY=60;
        }
        
        for (UIButton *btn2 in _btnArr) {
            [UIView animateWithDuration:0.5 animations:^{
                btn2.frame=CGRectMake(ScreenWidth/2-25, ScreenHeight/2-25, 50, 50);
            } completion:^(BOOL finished){
                btn2.hidden=YES;
                
                [UIView animateWithDuration:0.5 animations:^{
                    if (centerX==0 && centerY==0) {
                        self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight-60, 50, 50);
                        
                    }else{
                        self.centerBtn.frame=CGRectMake(theCenterX-25, theCenterY-30, 50, 50);
                    }
                    self.centerBtn.layer.cornerRadius=25;
                    self.centerBtn.layer.masksToBounds=YES;
                    //                    self.centerBtn.userInteractionEnabled=NO;
                }completion:^(BOOL finished){
                    self.centerBtn.userInteractionEnabled=YES;
                    
                }];
            }];
        }
        
    }else{
        
        self.centerBtn.frame=CGRectMake(ScreenWidth/2-35, ScreenHeight/2-35, 70, 70);
        self.centerBtn.layer.cornerRadius=35;
        self.centerBtn.layer.masksToBounds=YES;
        
        [self addBtn];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"frame"]) {
        return;
    }
    CGFloat height=self.centerBtn.frame.size.height;
    if (height ==50) {
        _panGestureRecognizer.enabled=YES;
    }else if(height ==70){
        _panGestureRecognizer.enabled=NO;
    }
}

- (void)dealloc {
    [self.centerBtn removeObserver:self forKeyPath:@"frame"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    CGPoint point =[touch locationInView:self];
    if (!CGRectContainsPoint(self.centerBtn.frame, point)) {
    //    [self.centerBtn removeFromSuperview];
        if (!CGRectContainsPoint(self.button1.frame, point)) {
            self.show=NO;
        }
        
    }
}
@end
