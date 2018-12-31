//
//  BaseViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/13.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property(nonatomic,strong)UIButton *btn;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonUtil addGradientLayerTo:self];
    
    // Do any additional setup after loading the view.
//     self.navigationItem.title=_str;
//    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40) ];
//    [self.btn setTitle:@"返回" forState:UIControlStateNormal];
//    [self.btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btn];
//    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:_btn];
//    self.navigationItem.leftBarButtonItem=back;
}

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
