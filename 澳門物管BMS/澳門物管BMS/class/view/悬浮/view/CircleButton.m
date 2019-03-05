//
//  CircleButton.m
//  SuspensionMenuView
//
//  Created by 胡嘉宏 on 2019/1/17.
//  Copyright © 2019 EdgarHu. All rights reserved.
//

#import "CircleButton.h"
@interface CircleButton()
@property(nonatomic,strong) SuspensionModel *model;
@end

@implementation CircleButton

-(instancetype)initWithModel:(SuspensionModel *)model{
   self =  [super initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.model = model;
    [self setImage:[UIImage imageNamed:self.model.image] forState:UIControlStateNormal];
    [self setTitle:model.name forState:UIControlStateNormal];
     [self setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+20, -self.imageView.frame.size.width, 0, 0)];
//     [self setImageEdgeInsets:UIEdgeInsetsMake( -(self.frame.size.height/2-self.imageView.frame.size.height/2), 0, 0, -self.titleLabel.frame.size.width)];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+20, -self.imageView.frame.size.width-10, 0, 0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake( 0, 0, 0, 0)];
    return  self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
