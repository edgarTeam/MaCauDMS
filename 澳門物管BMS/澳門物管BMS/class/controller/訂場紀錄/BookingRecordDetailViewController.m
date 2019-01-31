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
#import "NoticeSubList.h"

@interface BookingRecordDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookingRecordDetailImageView;
@property (nonatomic,strong)PlaceRecord *placeRecord;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLab;//時間段
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
                         @"placeId" :_placeRecord.placeId
                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlace:para completion:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        _place=[Place mj_objectWithKeyValues:dic];
        _palceLab.text=_place.placeName;
        NSMutableArray *imageUrlArr=[NSMutableArray new];
        NSMutableArray *imageThumbnailArr=[NSMutableArray new];
        if (_place.images.count ==0 || _place.images ==nil) {
            return;
        }
        for (NoticeSubList *notice in _place.images) {
            if (notice.imageUrl !=nil) {
                [imageUrlArr addObject:notice.imageUrl];
            }
            if (notice.imageThumbnail !=nil) {
                [imageThumbnailArr addObject:notice.imageThumbnail];
            }
        }
        if (imageThumbnailArr.count ==0 || imageThumbnailArr==nil) {
            return;
        }
        if (imageUrlArr.count ==0 || imageUrlArr ==nil) {
            return;
        }
        NSString *imageStr=[imageUrlArr componentsJoinedByString:@","];
        NSString *imageThumbStr=[imageThumbnailArr componentsJoinedByString:@","];
        NSArray *imageArr=[imageStr componentsSeparatedByString:@","];
        NSArray *imageThumbArr=[imageThumbStr componentsSeparatedByString:@","];
        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbArr[0]]] placeholderImage:image];
        }];
//        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageUrlArr[0]]]placeholderImage:kEMPTYIMG completed:nil];
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
        NSString *timeStr;
        _placeRecord=[PlaceRecord mj_objectWithKeyValues:dic];
        if (_placeRecord.orderDate.length >10) {
            timeStr=[_placeRecord.orderDate substringToIndex:10];
        }
        _statusLab.text=dataSource[[_placeRecord.recordStatus intValue]+1];
        _timeZoneLab.text=[NSString stringWithFormat:@"%@ %@ 至 %@",timeStr,_placeRecord.orderStartTime,_placeRecord.orderEndTime];
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
