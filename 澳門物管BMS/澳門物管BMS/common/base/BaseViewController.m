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
@interface BaseViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)NSString *token;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//     self.navigationItem.title=_str;
//    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40) ];
//    [self.btn setTitle:@"返回" forState:UIControlStateNormal];
//    [self.btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btn];
//    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:_btn];
//    self.navigationItem.leftBarButtonItem=back;
    NSUserDefaults *tokenId=[NSUserDefaults standardUserDefaults];
    _token=[tokenId objectForKey:Token];
   
}

-(void)checkLogin{
    if (_token!= nil && _token.length > 0) {
        NSLog(@"已登陆");
    }else{
        [[[UIAlertView alloc] initWithTitle:@"" message:LocalizedString(@"String_login_request") delegate:self cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];

        
    }
}
//-(void)checkLogin{
//    if ([User shareUser].tel!= nil && [User shareUser].tel .length > 0) {
//
//    }else{
//        [[[UIAlertView alloc] initWithTitle:@"" message:LocalizedString(@"String_login_request") delegate:self cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
