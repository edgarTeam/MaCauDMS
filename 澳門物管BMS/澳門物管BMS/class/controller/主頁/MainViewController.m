//
//  MainViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "MainViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "LeftViewController.h"
#import <Masonry/Masonry.h>
@interface MainViewController ()
@property (nonatomic,strong) UIButton *sliderBtn;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=[UIColor whiteColor];
    _sliderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sliderBtn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [_sliderBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sliderBtn];
    [_sliderBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
}

-(void)onClick:(UIButton *)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
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
