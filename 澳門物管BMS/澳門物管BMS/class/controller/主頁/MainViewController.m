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
#import "AnnouncementViewController.h"

#import "LoginViewController.h"
#import "PersonalViewController.h"

#import "TurningLabelView.h"
@interface MainViewController ()
@property (nonatomic,strong) UIButton *sliderBtn;
@property (nonatomic,strong) UIButton *rightBtn;
//@property (nonatomic,strong) SuspensionView *suspensionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *clientNameLab;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLab;
@property (weak, nonatomic) IBOutlet UILabel *weatherLab;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet TurningLabelView *turningView;
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn;

@property (weak, nonatomic) IBOutlet UIButton *complainBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UIButton *placeBtn;
@property (weak, nonatomic) IBOutlet UIButton *informationBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;





@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
//    CGRect statusRect=[[UIApplication sharedApplication] statusBarFrame];
//    CGFloat height=statusRect.size.height;
//
//    _sliderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [_sliderBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
//    [_sliderBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_sliderBtn];
//    [_sliderBtn mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.mas_equalTo(height);
//        make.left.mas_equalTo(20);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];
//    _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [_rightBtn setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
//    [_rightBtn addTarget:self action:@selector(noticeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_rightBtn];
//    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.mas_equalTo(height);
//        make.right.mas_equalTo(-20);
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];
//
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notice"] style:UIBarButtonItemStylePlain target:self action:@selector(noticeBtnAction:)];
}

//- (void)onClick:(UIButton *)sender {
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//
//}
//
//- (void)noticeBtnAction:(UIButton *)sender {
//
//   // _suspensionView.show=YES;
//   // [_suspensionView setShow:!_suspensionView.show];
//    AnnouncementViewController *announceVC=[AnnouncementViewController new];
//    [self.navigationController pushViewController:announceVC animated:YES];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
    self.baseTitleLab.hidden=YES;
    self.backBtn.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)infoBtnAction:(id)sender {
  //  LoginViewController *loginVC=[LoginViewController new];
   // [self.navigationController pushViewController:loginVC animated:YES];
    PersonalViewController *personVC=[PersonalViewController new];
    [self.navigationController pushViewController:personVC animated:YES];
}
- (IBAction)noticeBtnAction:(id)sender {
    AnnouncementViewController *noticeVC=[AnnouncementViewController new];
    [self.navigationController pushViewController:noticeVC animated:YES];
}

- (IBAction)chooseBtnAction:(UIButton *)btn {
//    switch (btn.tag) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
}



@end
