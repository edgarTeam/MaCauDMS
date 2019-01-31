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

#import <Masonry/Masonry.h>
@interface BaseViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIButton *btn;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _gradientView=[[GradientView alloc] init];

    [self.view addSubview:_gradientView];
    [_gradientView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.view sendSubviewToBack:_gradientView];
//    [CommonUtil addGradientLayerTo:self.view];
    
//    self.view.backgroundColor=[UIColor whiteColor];
//     Do any additional setup after loading the view.
     
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40) ];
    [self.btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.btn setTitle:@"返回" forState:UIControlStateNormal];
    //[self.btn.titleLabel setTextColor:RGB(77, 77, 77)];
    [self.btn setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:self.btn];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:_btn];
    self.navigationItem.leftBarButtonItem=back;
 
   
}

-(void)checkLogin{
     NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
    if (token!= nil && token.length > 0) {
        NSLog(@"已登陆");
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
//        LoginViewController *loginVC=[[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
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
