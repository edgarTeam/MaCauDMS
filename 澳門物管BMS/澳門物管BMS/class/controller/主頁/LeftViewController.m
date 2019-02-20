//
//  LeftViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#define key @"b69afc34386eb6a0ea9a75cb492e5994"
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
#import "User.h"
#import "UIButton+WebCache.h"
#import "HttpHelper.h"
#import "Weather.h"
#import <CoreLocation/CoreLocation.h>
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIButton *loginOutBtn;
@property (nonatomic,strong) UIButton *headBtn;
@property (nonatomic,strong) UILabel *versionlab;
@property (nonatomic,strong) UILabel *weatherLab;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) UIImageView *weatherImg;//天气图片
@end

@implementation LeftViewController
{
    NSArray *dataSoure;
    NSArray *imgArrar;
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
    NSString *lonStr;//经度
    NSString *latStr;//纬度
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self creatView];
    [self locate];
}



- (void)creatView{
    self.view.backgroundColor=[UIColor whiteColor];
    _headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   // _headBtn.backgroundColor=[UIColor redColor];
    _headBtn.layer.masksToBounds=YES;
    _headBtn.layer.cornerRadius=40;
   // [_headBtn setImage:[UIImage iSuspensionView.hmageNamed:@"work"] forState:UIControlStateNormal];
   // NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,[User shareUser].portrait]];
   // [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMG];
   // [_headBtn setBackgroundImage:[UIImage ] forState:<#(UIControlState)#>];
  //  [_headBtn setBackgroundImage:[UIImage imageNamed:@"headImg"] forState:UIControlStateNormal];
    
    [_headBtn addTarget:self action:@selector(userInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headBtn];
    [_headBtn mas_makeConstraints:^(MASConstraintMaker *make){
        if (@available(iOS 11.0,*)) {
           // make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
            make.left.mas_equalTo(ScreenWidth/4-40);
            // make.left.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(_headBtn.mas_width);
        }else{
        make.top.mas_equalTo(self.view).offset(20);
     //   make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(ScreenWidth/4-40);
       // make.left.mas_equalTo(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(_headBtn.mas_width);
        }
    }];
    

    
//    _headImage=[[UIImageView alloc] init];
//  //  _headImage.image = kEMPTYIMG;
//    _headImage.layer.masksToBounds=YES;
//    _headImage.layer.cornerRadius=_headBtn.frame.size.width/2;
//     NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,[User shareUser].portrait]];
//     [self.headImage sd_setImageWithURL:url placeholderImage:kEMPTYIMG];
//    [self.view addSubview:_headImage];
//    [_headImage mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.mas_equalTo(_headBtn.mas_top);
//        make.left.mas_equalTo(_headBtn.mas_left);
//        make.right.mas_equalTo(_headBtn.mas_right);
//        make.bottom.mas_equalTo(_headBtn.mas_bottom);
//    }];
    
    _versionlab=[[UILabel alloc] init];
    _versionlab.textColor=RGB(138, 138, 138);
    _versionlab.font=[UIFont systemFontOfSize:14];
    _versionlab.textAlignment=NSTextAlignmentCenter;
    NSString *version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //_versionlab.text=@"version 1.0.3";
    _versionlab.text=[NSString stringWithFormat:@"Ver %@",version];
    [self.view addSubview:_versionlab];
    [_versionlab mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_offset(0);
//        make.left.mas_offset(20);
      //  make.width.mas_offset(100);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
      //  make.centerX.mas_equalTo(self.view);
    }];
    

    _loginOutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginOutBtn.backgroundColor=[UIColor blueColor];
    _loginOutBtn.layer.masksToBounds=YES;
    _loginOutBtn.layer.cornerRadius=7.0;
   
    [self.view addSubview:_loginOutBtn];
    [_loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-20);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
    }];
      [_loginOutBtn addTarget:self action:@selector(loginInBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setUpLoginBtn];
    _weatherLab=[[UILabel alloc] init];
    _weatherLab.textColor=RGB(138, 138, 138);
    _weatherLab.font=[UIFont systemFontOfSize:16];
    _weatherLab.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:_weatherLab];
    [_weatherLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(_loginOutBtn.mas_top).offset(-10);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
        
    }];
    
    _weatherImg=[[UIImageView alloc] init];
    [self.view addSubview:_weatherImg];
    [_weatherImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(_loginOutBtn.mas_top).offset(-10);
       // make.left.mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.right.mas_equalTo(_weatherLab.mas_left).offset(0);
        make.height.mas_equalTo(_weatherImg.mas_width);
    }];
    
    
    
    LeftModel *model1=[LeftModel new];
    model1.title=LocalizedString(@"string_booking_record_title");
    model1.image=@"bookingPlace";
    LeftModel *model2=[LeftModel new];
    model2.title=LocalizedString(@"string_contact_us_title");
    model2.image=@"contact";
    LeftModel *model3=[LeftModel new];
    model3.title=LocalizedString(@"string_set_title");
    model3.image=@"setting";
    LeftModel *model4=[LeftModel new];
    model4.title=LocalizedString(@"string_report_maintenance_list");
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
        make.top.mas_equalTo(_headBtn.mas_bottom).offset(15);
        make.bottom.mas_equalTo(_loginOutBtn.mas_top).offset(-20);
        make.left.and.right.mas_equalTo(0);
    }];
}

- (void)requestWeather {
    
//    if (currentCity.length==0) {
//        return;
//    }
//    if ([currentCity hasSuffix:@"市"]) {
//        _cityName=[currentCity substringToIndex:currentCity.length-1];
//    }else{
//        _cityName=currentCity;
//    }
    if (lonStr.length ==0 || latStr.length ==0) {
        return;
    }
    NSDictionary *para=@{
                        // @"cityname" :_cityName,
                         @"lon":lonStr,
                         @"lat" :latStr,
                         @"key" :key
                         };
    [[HttpHelper shareHttpHelper] getWeatherWithURL:Kweather convertClassName:nil parameters:para isArray:NO isString:NO success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        Weather *weather=[Weather mj_objectWithKeyValues:[dic objectForKey:@"today"]];
        if ([weather.weather rangeOfString:@"晴"].location !=NSNotFound) {
            [_weatherImg setImage:[UIImage imageNamed:@"fine"]];
        }else if([weather.weather rangeOfString:@"多云"].location !=NSNotFound){
            [_weatherImg setImage:[UIImage imageNamed:@"cloudy"]];
        }else if ([weather.weather rangeOfString:@"雷"].location !=NSNotFound){
            [_weatherImg setImage:[UIImage imageNamed:@"thunder"]];
        }else if ([weather.weather rangeOfString:@"小雨"].location !=NSNotFound){
            [_weatherImg setImage:[UIImage imageNamed:@"light_rain"]];
        }else if ([weather.weather rangeOfString:@"中雨"].location !=NSNotFound){
            [_weatherImg setImage:[UIImage imageNamed:@"moderate_rain"]];
        }else if ([weather.weather rangeOfString:@"大雨"].location !=NSNotFound){
            [_weatherImg setImage:[UIImage imageNamed:@"heavy_rain"]];
        }else{
            [_weatherImg setImage:[UIImage imageNamed:@"overcast"]];
        }
        
        _weatherLab.text=[NSString stringWithFormat:@" %@",weather.temperature];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}


- (void) setUpLoginBtn{
    if (self.token.length==0) {
        [_loginOutBtn setTitle:LocalizedString(@"string_login_in") forState:UIControlStateNormal];
        [self.headBtn setImage:kEMPTYIMG forState:UIControlStateNormal];
    }else{
        [_loginOutBtn setTitle:LocalizedString(@"string_login_out") forState:UIControlStateNormal];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,[User shareUser].portrait]];
        
        [self.headBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:kEMPTYIMG];
        // [_loginOutBtn.titleLabel setText:@"登出"];
    }
    
}

- (void)loginInBtnAction:(UIButton *)btn {
    if (self.token && self.token.length >0) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        self.token = @"";
        [userDefault setObject:@"" forKey:LoginToken];
        [User clear];
        [self setUpLoginBtn];
    }else{
    LoginViewController *loginVC=[[LoginViewController alloc] init];
    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
    [nav pushViewController:loginVC animated:YES];
    
    // [self.navigationController pushViewController:userVC animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
        
    }
}


- (void)userInfoBtnAction:(UIButton *)btn {
//    if (![self login]) {
//        return;
//    }
    [self checkLogin];
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
    return 50;
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
//    if (![self login]) {
//        return;
//    }
    NSArray *array=@[@"BookingRecordViewController",@"ContactUSViewController",@"SettingViewController",@"ProcessingStateViewController"];
    UIViewController *vc=[NSClassFromString(array[indexPath.row]) new];
    UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
    if (indexPath.row==0 || indexPath.row==3) {
        [self checkLogin];
    }
    
    
    
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

    [self setUpLoginBtn];
    [self creatView];
}


- (void)locate {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        //  [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate

//定位失败则执行此代理方法
//定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
          //  placeMark.location.coordinate.latitude//纬度
           //   placeMark.location.coordinate.longitude //经度
            lonStr=[NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude];
            latStr=[NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            NSLog(@"%@",currentCity); //这就是当前的城市
          //  [self requestWeather];
           // NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
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
