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

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIButton *loginOutBtn;
@property (nonatomic,strong) UIButton *headBtn;
@end

@implementation LeftViewController
{
    NSArray *dataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatView];
}

- (void)creatView{
    self.view.backgroundColor=[UIColor whiteColor];
    _headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn.layer.masksToBounds=YES;
    _headBtn.layer.cornerRadius=_headBtn.bounds.size.width;
    [_headBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
  //  [_headBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headBtn];
    [_headBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(_headBtn.mas_width);
    }];
    
    _loginOutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginOutBtn.backgroundColor=[UIColor blueColor];
    [_loginOutBtn setTitle:@"登出" forState:UIControlStateNormal];
   // [_loginOutBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginOutBtn];
    [_loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(60);
        make.left.and.right.mas_equalTo(0);
    }];
    
    dataSoure=[NSArray new];
    dataSoure=@[@"訂場紀錄",@"聯繫我們",@"設定",@"報修紀錄"];
    
    
    
    _table=[[UITableView alloc] init];
    _table.separatorColor=[UIColor grayColor];
    _table.tableFooterView=[UITableView new];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_headBtn.mas_bottom).offset(30);
        make.bottom.mas_equalTo(_loginOutBtn.mas_top).offset(20);
        make.left.and.right.mas_equalTo(0);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSoure.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDentified=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IDentified];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDentified];
    }
    cell.textLabel.text=dataSoure[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array=@[@"BookingRecordViewController",@"ContactUSViewController",@"SettingViewController",@"ProcessingStateViewController"];
    UIViewController *vc=[NSClassFromString(array[indexPath.row]) new];
    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
    
    
    [nav pushViewController:vc animated:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
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
