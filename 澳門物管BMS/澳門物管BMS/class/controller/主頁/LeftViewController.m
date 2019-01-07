//
//  LeftViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#import "UIViewController+MMDrawerController.h"
#import "LeftViewController.h"
#import <Masonry/Masonry.h>
#import "BookingRecordViewController.h"
#import "ContactUSViewController.h"
#import "SettingViewController.h"
#import "ProcessingStateViewController.h"
#import "LeftViewTableViewCell.h"
#import "LeftModel.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIButton *loginOutBtn;
@property (nonatomic,strong) UIButton *headBtn;
@property (nonatomic,strong) UILabel *versionlab;
@property (nonatomic,strong) UILabel *weatherLab;
@end

@implementation LeftViewController
{
    NSArray *dataSoure;
    NSArray *imgArrar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatView];
}

- (void)creatView{
    self.view.backgroundColor=[UIColor whiteColor];
    _headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   // _headBtn.backgroundColor=[UIColor redColor];
    _headBtn.layer.masksToBounds=YES;
    _headBtn.layer.cornerRadius=40;
   // [_headBtn setImage:[UIImage imageNamed:@"work"] forState:UIControlStateNormal];
    [_headBtn setBackgroundImage:[UIImage imageNamed:@"headImg"] forState:UIControlStateNormal];
    [_headBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headBtn];
    [_headBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(60);
     //   make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(ScreenWidth/4-40);
       // make.left.mas_equalTo(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(_headBtn.mas_width);
    }];
    _versionlab=[[UILabel alloc] init];
    _versionlab.textColor=RGB(138, 138, 138);
    _versionlab.font=[UIFont systemFontOfSize:14];
    NSString *version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //_versionlab.text=@"version 1.0.3";
    _versionlab.text=[NSString stringWithFormat:@"version %@",version];
    [self.view addSubview:_versionlab];
    [_versionlab mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_offset(0);
        make.left.mas_offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    _loginOutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginOutBtn.backgroundColor=[UIColor blueColor];
    _loginOutBtn.layer.masksToBounds=YES;
    _loginOutBtn.layer.cornerRadius=7.0;
    [_loginOutBtn setTitle:@"登出" forState:UIControlStateNormal];
   // [_loginOutBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
   // [_loginOutBtn.titleLabel setText:@"登出"];
    [self.view addSubview:_loginOutBtn];
    [_loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-20);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
    }];
    
    _weatherLab=[[UILabel alloc] init];
    _weatherLab.textColor=RGB(138, 138, 138);
    _weatherLab.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_weatherLab];
    [_weatherLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(_loginOutBtn.mas_top);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(25);
    }];
    
    LeftModel *model1=[LeftModel new];
    model1.title=@"訂場紀錄";
    model1.image=@"bookingPlace";
    LeftModel *model2=[LeftModel new];
    model2.title=@"聯繫我們";
    model2.image=@"contact";
    LeftModel *model3=[LeftModel new];
    model3.title=@"設定";
    model3.image=@"setting";
    LeftModel *model4=[LeftModel new];
    model4.title=@"報修紀錄";
    model4.image=@"repair";
    dataSoure=[NSArray arrayWithObjects:model1,model2,model3, model4, nil];
//    dataSoure=[NSArray new];
//    dataSoure=@[@"訂場紀錄",@"聯繫我們",@"設定",@"報修紀錄"];
//    imgArrar=[NSArray new];
//    imgArrar=@[@"wuyebaoxiu",@"wuyebaoxiu",@"wuyebaoxiu",@"wuyebaoxiu"];
    
    _table=[[UITableView alloc] init];
    _table.backgroundColor=[UIColor clearColor];
    _table.separatorColor=[UIColor grayColor];
    _table.tableFooterView=[UITableView new];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_headBtn.mas_bottom).offset(30);
        make.bottom.mas_equalTo(_loginOutBtn.mas_top).offset(-20);
        make.left.and.right.mas_equalTo(0);
    }];
}

- (void)loginOutAction:(UIButton *)btn {
    
}

- (void)userInfoBtnAction:(UIButton *)btn {
    UserInfoViewController *userVC=[[UserInfoViewController alloc] init];
    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
    [nav pushViewController:userVC animated:YES];
    
   // [self.navigationController pushViewController:userVC animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSoure.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // static NSString *IDentified=@"cell";
    LeftViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftViewTableViewCell"];
    if (cell == nil) {
       // cell =[[LeftViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftViewTableViewCell"];
         cell=[[[NSBundle mainBundle] loadNibNamed:@"LeftViewTableViewCell" owner:self options:nil] lastObject];
    }
   // cell.textLabel.text=dataSoure[indexPath.row];
   // [cell.imageView setImage:[UIImage imageNamed:imgArrar[indexPath.row]]];
    cell.backgroundColor=[UIColor clearColor];
    [cell setUpModel:[dataSoure objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //  [self checkLogin];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array=@[@"BookingRecordViewController",@"ContactUSViewController",@"SettingViewController",@"ProcessingStateViewController"];
    UIViewController *vc=[NSClassFromString(array[indexPath.row]) new];
    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;


    [nav pushViewController:vc animated:YES];

    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
    
//    LoginViewController *loginVC=[[LoginViewController alloc] init];
//    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
//    [nav pushViewController:loginVC animated:YES];
//    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
//          [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//    }];
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
