//
//  BaseAlertViewController.m
//  OA.message
//
//  Created by lee on 16/6/1.
//  Copyright © 2016年 sanchun. All rights reserved.
//

#import "BaseAlertViewController.h"


#import "UIView+SDAutoLayout.h"

@interface BaseAlertViewController ()
{
    
}
@end

@implementation BaseAlertViewController
-(instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.clipsToBounds = YES;
    [self.view addSubview:self.contentView];
    
     CGFloat ratio = 4/5.f;
    if (ScreenWidth > ScreenHeight) {
        ratio = ScreenHeight / ScreenWidth;
    }
    
    self.contentView.sd_layout
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .autoHeightRatio(ratio);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
