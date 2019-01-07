//
//  MainViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#import "SuspensionView.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "LeftViewController.h"
#import <Masonry/Masonry.h>
#import "AnnouncementViewController.h"
@interface MainViewController ()
@property (nonatomic,strong) UIButton *sliderBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) SuspensionView *suspensionView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect statusRect=[[UIApplication sharedApplication] statusBarFrame];
    CGFloat height=statusRect.size.height;
    
    _suspensionView=[[SuspensionView alloc] init];
    _sliderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sliderBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [_sliderBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sliderBtn];
    [_sliderBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(height);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(noticeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(height);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notice"] style:UIBarButtonItemStylePlain target:self action:@selector(noticeBtnAction:)];
}

- (void)onClick:(UIButton *)sender {
    _suspensionView.show=YES;
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)noticeBtnAction:(UIButton *)sender {

   // _suspensionView.show=YES;
   // [_suspensionView setShow:!_suspensionView.show];
    [_suspensionView setShow:NO];
    AnnouncementViewController *announceVC=[AnnouncementViewController new];
    [self.navigationController pushViewController:announceVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
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
