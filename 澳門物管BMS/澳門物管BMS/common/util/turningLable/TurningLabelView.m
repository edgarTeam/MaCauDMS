//
//  TurningLabelView.m
//  DJQueryApp
//
//  Created by 胡嘉宏 on 2018/3/29.
//  Copyright © 2018年 zk. All rights reserved.
//

#import "TurningLabelView.h"

@interface TurningLabelView()

@property (strong, nonatomic) UIImageView  *imageView;
@property (nonatomic,strong) NSArray *turnArray;

@end

@implementation TurningLabelView

{
    CGRect _frame;
    UIColor *customerGreen;
    NSString *tempString;
    UILabel *label1;
    UILabel *label2;
    NSTimer *timer;
    BOOL wichOne;
    int count;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSubView];
}

-(instancetype)initWithFrame:(CGRect)frame hotelRestaurant:(NSMutableArray *)infos{
    //    self = [NSBundle mainBundle] load
    self = [super initWithFrame:frame];
    
    _frame = frame;
   
    
    [self initSubView];
    return  self;
}

- (void)initSubView{
    __weak __typeof(&*self)weakSelf = self;
    self.imageView = [[UIImageView alloc] init];
    [_imageView setImage:[UIImage imageNamed:@"saliva"]];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(20));
        make.height.equalTo(@(16));
        make.left.equalTo(weakSelf).offset(25);
        make.centerY.equalTo(weakSelf);
    }];
}

-(void)cleanArray{
    if (nil!=_turnArray && _turnArray.count > 0 ) {
        [self resetTimer];
        _turnArray  = nil;
        [label1 removeFromSuperview];
        [label2 removeFromSuperview];
        label1 = nil;
        label2 = nil;
    }
}

- (void)resetTimer{
    //取消定时器
    [timer invalidate];
    timer = nil;
    

}
- (void)timer{
    count++;
    if (count>_turnArray.count-1) {
        count = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!wichOne) {
            label1.frame = CGRectMake(55, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
            label2.frame = CGRectMake(55, 0, self.frame.size.width, self.frame.size.height);
        }
        if (wichOne) {
            label1.frame = CGRectMake(55, 0, self.frame.size.width, self.frame.size.height);
            label2.frame = CGRectMake(55, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }
    } completion:^(BOOL finished) {
        wichOne = !wichOne;
        if ((int)label1.frame.origin.y==-self.frame.size.height) {
            label1.frame = CGRectMake(55, self.frame.size.height, self.frame.size.width, self.frame.size.height);
            label1.text = _turnArray[count];
        }
        if ((int)label2.frame.origin.y==-self.frame.size.height) {
            label2.frame = CGRectMake(55, self.frame.size.height, self.frame.size.width, self.frame.size.height);
            label2.text = _turnArray[count];
        }
    }];
    
}


- (void)setTurnArray:(NSArray *)turnArray {
    _turnArray = turnArray;
    
    if (_turnArray.count == 1) {
        _turnArray = [NSArray arrayWithObjects:turnArray.firstObject,turnArray.lastObject ,nil];
         }
    count = 1;
    if (_turnArray.count == 0) {
        return;
    }
//    if (_turnArray.count == 1) {
//        label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, self.frame.size.width, self.frame.size.height)];
//        label1.text = _turnArray[0];
//        [label1 setFont:[UIFont systemFontOfSize:12]];
//
//        [self addSubview:label1];
//    }else{
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, self.frame.size.width, self.frame.size.height)];
        label1.text = _turnArray[0];
        [label1 setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:label1];
        
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(55, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        label2.text = [_turnArray[1] isKindOfClass:[NSNull class]] ? @"" : _turnArray[1];
        [label2 setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:label2];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timer)
                                               userInfo:@"aaaa" repeats:YES];
//    }
}

@end
