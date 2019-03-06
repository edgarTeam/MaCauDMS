//
//  PersonalViewController.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/3.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//
#define MapKey @"500ef4c149e398552d28ec9119aa826f"
#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "LeftModel.h"
#import "HttpHelper.h"
#import "Weather.h"
#import <CoreLocation/CoreLocation.h>
#import "AddressModel.h"
#import "UIButton+WebCache.h"
#import "User.h"
#import "LoginViewController.h"

#import "BookingRecordViewController.h"
#import "ProcessingStateViewController.h"
#import "ContactUSViewController.h"
#import "SettingViewController.h"

#import "UserInfoViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *userInfoBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLab;

@property (weak, nonatomic) IBOutlet UILabel *weatherLab;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *changeInfoLab;
@end

@implementation PersonalViewController
{
    NSArray *dataSource;
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
    NSString *lonStr;//经度
    NSString *latStr;//纬度
    NSString *adcode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseTitleLab.text=@"個人中心";
    _changeInfoLab.font=[UIFont systemFontOfSize:14];
    _temperatureLab.font=[UIFont systemFontOfSize:20];
    _weatherLab.font=[UIFont systemFontOfSize:13];
    _loginBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    // Do any additional setup after loading the view from its nib.
    self.loginBtn.layer.masksToBounds=YES;
    self.loginBtn.layer.cornerRadius=23;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorColor=[UIColor clearColor];
    
    LeftModel *model1=[LeftModel new];
    model1.title=LocalizedString(@"订场记录");
    model1.image=@"icon_personal_plate_bg";
    model1.describe=@"供12条订场记录";
    LeftModel *model2=[LeftModel new];
    model2.title=LocalizedString(@"报修记录");
    model2.image=@"icon_personal_repair_bg";
    model2.describe=@"报修记录进度更新";
    LeftModel *model3=[LeftModel new];
    model3.title=LocalizedString(@"投诉记录");
    model3.image=@"icon_personal_complain_bg";
    model3.describe=@"投诉记录进度更新";
    LeftModel *model4=[LeftModel new];
    model4.title=LocalizedString(@"单位资讯");
    model4.image=@"icon_personal_info_bg";
    model4.describe=@"热门资讯随时查看";
    LeftModel *model5=[LeftModel new];
    model5.title=LocalizedString(@"设定");
    model5.image=@"icon_personal_setting_bg";
    model5.describe=@"多种语言供选择";
    dataSource=[NSArray arrayWithObjects:model1,model2,model3, model4,model5, nil];
    
    [_loginBtn addTarget:self action:@selector(loginInBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setUpLoginBtn];
    [self locate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // static NSString *IDentified=@"cell";
    PersonalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PersonalTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PersonalTableViewCell" owner:self options:nil] lastObject];
    }
    // cell.textLabel.text=dataSoure[indexPath.row];
    // [cell.imageView setImage:[UIImage imageNamed:imgArrar[indexPath.row]]];
   // cell.backgroundColor=[UIColor clearColor];
    [cell setUpModel:[dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *array=@[@"BookingRecordViewController",@"ProcessingStateViewController",@"ProcessingStateViewController",@"ContactUSViewController",@"SettingViewController"];
    UIViewController *vc=[NSClassFromString(array[indexPath.row]) new];
  //  UINavigationController *nav=(UINavigationController *)self.mm_drawerController.centerViewController;
    
    if (indexPath.row==0 || indexPath.row==3) {
        [self checkLogin];
    }
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
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
            [self requestMap];
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

- (void)requestMap {
    NSString *location=[NSString stringWithFormat:@"%@,%@",lonStr,latStr];
    NSDictionary *para=@{
                         @"location":location,
                         @"key" :MapKey,
                         @"output":@"JSON"
                         
                         };
    [[HttpHelper shareHttpHelper] getMapWithURL:IOSMap convertClassName:nil parameters:para isArray:NO isString:NO success:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        
        AddressModel *model=[AddressModel mj_objectWithKeyValues:[dic objectForKey:@"addressComponent"]];
        adcode=model.adcode;
        [self requestWeather];
        //   NSLog(@"%@",idcode);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)requestWeather {

    if (lonStr.length ==0 || latStr.length ==0) {
        return;
    }
    NSDictionary *para=@{
                         // @"cityname" :_cityName,
                         @"city":adcode,
                         @"key" :MapKey
                         };
    [[HttpHelper shareHttpHelper] getWeatherWithURL:IOSWeather convertClassName:nil parameters:para isArray:NO isString:NO success:^(NSArray *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *weatherArr=[NSMutableArray new];
        weatherArr=[Weather mj_objectArrayWithKeyValuesArray:dic];
        Weather *weather=weatherArr[0];
        if ([weather.weather rangeOfString:@"晴"].location !=NSNotFound) {
            [_weatherImage setImage:[UIImage imageNamed:@"fine"]];
        }else if([weather.weather rangeOfString:@"多云"].location !=NSNotFound){
            [_weatherImage setImage:[UIImage imageNamed:@"cloudy"]];
        }else if ([weather.weather rangeOfString:@"雷"].location !=NSNotFound){
            [_weatherImage setImage:[UIImage imageNamed:@"thunder"]];
        }else if ([weather.weather rangeOfString:@"小雨"].location !=NSNotFound){
            [_weatherImage setImage:[UIImage imageNamed:@"light_rain"]];
        }else if ([weather.weather rangeOfString:@"中雨"].location !=NSNotFound){
            [_weatherImage setImage:[UIImage imageNamed:@"moderate_rain"]];
        }else if ([weather.weather rangeOfString:@"大雨"].location !=NSNotFound){
            [_weatherImage setImage:[UIImage imageNamed:@"heavy_rain"]];
        }else{
            [_weatherImage setImage:[UIImage imageNamed:@"overcast"]];
        }
        
       // _weatherLab.text=[NSString stringWithFormat:@" %@℃",weather.temperature];
        _weatherLab.text=weather.weather;
        _temperatureLab.text=[NSString stringWithFormat:@" %@℃",weather.temperature];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}






- (IBAction)changeInfoBtnAction:(id)sender {
    UserInfoViewController *infoVC=[UserInfoViewController new];
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (void) setUpLoginBtn{
    if (self.token.length==0) {
        [_loginBtn setTitle:LocalizedString(@"string_login_in") forState:UIControlStateNormal];
        [self.userInfoBtn setImage:kEMPTYIMG forState:UIControlStateNormal];
    }else{
        [_loginBtn setTitle:LocalizedString(@"string_login_out") forState:UIControlStateNormal];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,[User shareUser].portrait]];
        [self.userInfoBtn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:kEMPTYIMG];
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
        [self.navigationController pushViewController:loginVC animated:YES];
        

        
    }
}

@end
