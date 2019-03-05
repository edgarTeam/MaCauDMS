//
//  MainViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#define MapKey @"500ef4c149e398552d28ec9119aa826f"

#import "MainViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "LeftViewController.h"
#import <Masonry/Masonry.h>
#import "AnnouncementViewController.h"

#import "LoginViewController.h"
#import "PersonalViewController.h"

#import "TurningLabelView.h"
#import "NSDate+Utils.h"

#import "ClubhouseReservationViewController.h"
#import "ReportMaintenanceViewController.h"
#import "SettingViewController.h"
#import "ContactUSViewController.h"
#import "Notice.h"
#import "HttpHelper.h"
#import "AddressModel.h"
#import "Weather.h"
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface MainViewController ()<CLLocationManagerDelegate>
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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;




@end

@implementation MainViewController
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
    NSString *lonStr;//经度
    NSString *latStr;//纬度
    NSString *adcode;
    NSMutableArray *noticeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLab.font=[UIFont fontWithName:@"cwTeXQHeiZH-Bold" size:16];
    
    for (UIButton *btn in _btnArray) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height, -btn.imageView.frame.size.width, 0, 0)];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake( -(btn.frame.size.height/2-btn.imageView.frame.size.height/2), 0, 0, -btn.titleLabel.frame.size.width)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height, -btn.imageView.frame.size.width-15, 0, 0)];
       // [btn setImageEdgeInsets:UIEdgeInsetsMake( 0, 0, 24, 0)];
//        NSLog(@"按钮：%f",btn.frame.size.width/2);
//        NSLog(@"图片：%f",btn.imageView.frame.size.width/2);
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.frame.size.width/2-btn.imageView.frame.size.width/2, 24, 0)];
    }
    
    


    
    
    
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
    NSString *timeStr=[NSDate getYearMonthDayTimes];
    NSString *dateStr=[NSDate stringApplyYMDTimeSting:timeStr];
    _dateLab.text=[NSString stringWithFormat:@"%@ %@",dateStr,[NSDate getWeekdays]];
    [self locate];
    [self requestNoticeList];
    if ([User shareUser].name.length==0) {
        _clientNameLab.text=[NSString stringWithFormat:@"您好! 業主"];
    }else{
       // NSString *str=[[User shareUser].name substringToIndex:1];
        _clientNameLab.text=[NSString stringWithFormat:@"您好! 業主%@",[User shareUser].name];
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
- (IBAction)infoBtnAction:(id)sender {
    PersonalViewController *personVC=[PersonalViewController new];
    [self.navigationController pushViewController:personVC animated:YES];
}
- (IBAction)noticeBtnAction:(id)sender {
    AnnouncementViewController *noticeVC=[AnnouncementViewController new];
    [self.navigationController pushViewController:noticeVC animated:YES];
}

- (IBAction)chooseBtnAction:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            {
                ReportMaintenanceViewController *reportVC=[ReportMaintenanceViewController new];
                reportVC.type=ComplainType;
                [self.navigationController pushViewController:reportVC animated:YES];
            }
            break;
        case 1:
        {
            ReportMaintenanceViewController *reportVC=[ReportMaintenanceViewController new];
            reportVC.type=ReportType;
            [self.navigationController pushViewController:reportVC animated:YES];
        }
            break;
        case 2:
        {
            ClubhouseReservationViewController *clubVC=[ClubhouseReservationViewController new];
            [self.navigationController pushViewController:clubVC animated:YES];
        }
            break;
        case 3:
        {
            ContactUSViewController *contactVC=[ContactUSViewController new];
            [self.navigationController pushViewController:contactVC animated:YES];
        }
            break;
        case 4:
        {
            ContactUSViewController *contactVC=[ContactUSViewController new];
            [self.navigationController pushViewController:contactVC animated:YES];
        }
            break;
        case 5:
        {
            SettingViewController *setVC=[SettingViewController new];
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        default:
            break;
    }
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
        _temperatureLab.text=[NSString stringWithFormat:@"%@℃",weather.temperature];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}


- (void)requestNoticeList {
    [[WebAPIHelper sharedWebAPIHelper] postNoticeList:nil completion:^(NSDictionary *dic){
        NSMutableArray *array=[dic objectForKey:@"list"];
        NSArray *arr=[Notice mj_objectArrayWithKeyValuesArray:array];
        noticeList=[NSMutableArray new];
        for (Notice *notice in arr) {
            [noticeList addObject:notice.noticeTitle];
        }
        [self.turningView cleanArray];
        [self.turningView setTurnArray:noticeList];
    }];
}





@end
