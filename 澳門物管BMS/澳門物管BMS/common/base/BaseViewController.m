//
//  BaseViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/13.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"
#import "User.h"
#import "LoginViewController.h"
#import "ZKAlertTool.h"

//#import "BaseLable.h"
#import <Masonry/Masonry.h>
@interface BaseViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // _gradientView=[[GradientView alloc] init];

//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(230, 230, 230),NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationController.navigationBar.translucent = NO;
//    [self.view addSubview:_gradientView];
//    [_gradientView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
//    [self.view sendSubviewToBack:_gradientView];

    self.view.backgroundColor=[UIColor blackColor];
    UIImageView *topImageView=[[UIImageView alloc] init];
    topImageView.image=[UIImage imageNamed:@"icon_background_top"];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make){
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(216);
        }else{
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(216);
        }

    }];
    
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, statusRectHeight, ScreenWidth, 44)];
    topView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:topView];
    
    self.baseTitleLab=[[UILabel alloc] init];

    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];

    if ([lang isEqualToString:@"zh-Hant"]) {

        self.baseTitleLab.font=[UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:16];
    }else{
        self.baseTitleLab.font=[UIFont fontWithName:@"本墨咏黑" size:16];
    }
   // self.baseTitleLab=[[BaseLable alloc] initFont];
  //  self.baseTitleLab=[[UILabel alloc] init];
    
    self.baseTitleLab.textColor=[UIColor whiteColor];
    [topView addSubview:self.baseTitleLab];
    [self.baseTitleLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(topView);
        make.centerY.mas_equalTo(topView);
    }];
    self.backBtn=[[UIButton alloc] init];
    self.backBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"icon_back_background"] forState:UIControlStateNormal];
    [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn setTitleColor:RGB(230, 230, 230) forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtn:)forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(topView);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(77);
        make.height.mas_equalTo(33);
    }];
    
//        [self.btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [self.btn setBackgroundImage:[UIImage imageNamed:@"icon_back_background"] forState:UIControlStateNormal];
//        [self.btn setTitle:@"返回" forState:UIControlStateNormal];
//        //[self.btn.titleLabel setTextColor:RGB(77, 77, 77)];
//        [self.btn setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
//        [self.btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:self.btn];
//
    
    
//    self.view.backgroundColor=[UIColor whiteColor];
//     Do any additional setup after loading the view.
     
//    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 77, 31) ];
//    [self.btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [self.btn setBackgroundImage:[UIImage imageNamed:@"icon_back_background"] forState:UIControlStateNormal];
//    [self.btn setTitle:@"返回" forState:UIControlStateNormal];
//    //[self.btn.titleLabel setTextColor:RGB(77, 77, 77)];
//    [self.btn setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
//    [self.btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//   // [self.view addSubview:self.btn];
//    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:_btn];
//    UIBarButtonItem *spaceBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceBarButtonItem.width=-25;
//   // self.navigationItem.leftBarButtonItem=back;
//    self.navigationItem.leftBarButtonItems=@[spaceBarButtonItem,back];
//    _statusRectHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
//    _navRectHeight=self.navigationController.navigationBar.frame.size.height;
//    _totleHeight=_statusRectHeight+_navRectHeight;
}

-(void)checkLogin{
     NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
    if (token!= nil && token.length > 0) {
        NSLog(@"已登陆");
    }else{
//        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:LocalizedString(@"String_login_request") preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alertAc=[UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//            LoginViewController *loginVC=[[LoginViewController alloc] init];
//            UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
//            
//            
//            [nav pushViewController:loginVC animated:YES];
//            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
//                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//            }];
//        }];
//        [alert addAction:alertAc];
//        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (BOOL)login{
     NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
    if (token!= nil && token.length > 0) {
        NSLog(@"已登陆");
        return YES;
    }else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:LocalizedString(@"String_login_request") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAc=[UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            LoginViewController *loginVC=[[LoginViewController alloc] init];
            
            UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;


            [nav pushViewController:loginVC animated:YES];
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
                [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            }];
        }];
        [alert addAction:alertAc];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *tokenId=[NSUserDefaults standardUserDefaults];
    _token=[tokenId objectForKey:LoginToken];
}


-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
