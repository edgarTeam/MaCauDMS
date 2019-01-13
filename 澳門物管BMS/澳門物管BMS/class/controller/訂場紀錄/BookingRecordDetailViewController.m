//
//  BookingRecordDetailViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BookingRecordDetailViewController.h"
#import "PlaceRecord.h"
#import "Place.h"
#import "User.h"
#import <MJExtension/MJExtension.h>
@interface BookingRecordDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookingRecordDetailImageView;
@property (nonatomic,strong)PlaceRecord *palceRecord;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLab;
@property (weak, nonatomic) IBOutlet UILabel *clientName;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *palceLab;
@property (nonatomic,strong)Place *place;
@end

@implementation BookingRecordDetailViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title=@"訂場詳情";
    self.title=LocalizedString(@"string_booking_record_detail_title");
    _bookingRecordDetailImageView=[UIImageView new];
    _bookingRecordDetailImageView.layer.masksToBounds=YES;
    _bookingRecordDetailImageView.layer.cornerRadius=10.0;
    dataSource=@[@"預約取消",@"開始發起",@"預約成功",@"預約失敗"];
    //[self requestBookingRecord];
//    [self requestPlace];
}


//- (void)requestBookingRecord {
//    NSDictionary *para=@{
//                         @"recordId" :self.recordId
//                         };
//    [[WebAPIHelper sharedWebAPIHelper] postPlaceRecord:para completion:^(NSDictionary *dic){
//        if (dic==nil) {
//            return ;
//        }
//        _palceRecord=[PlaceRecord mj_setKeyValues:dic];
//    }];
//}

- (void)requestPlace {
    NSDictionary *para=@{
                         @"placeId" :_palceRecord.placeId
                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlace:para completion:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        _place=[Place mj_setKeyValues:dic];
        _palceLab.text=_place.placeName;
        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,_place.placeImage]]placeholderImage:kEMPTYIMG completed:nil];
    }];
}

- (void)requestPlaceRecord {
    NSDictionary *para=@{
                         @"recordId" :self.recordId
                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlaceRecord:para completion:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        _palceRecord=[PlaceRecord mj_setKeyValues:dic];
        _statusLab.text=dataSource[[_palceRecord.recordStatus intValue]+1];
        _timeZoneLab.text=[NSString stringWithFormat:@"%@ 至 %@",_palceRecord.orderStartTime,_palceRecord.orderEndTime];
        _clientName.text=[User shareUser].name;
        [self requestPlace];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
  //  [self requestBookingRecord];
    [self requestPlaceRecord];
    //[self requestPlace];
}
@end
