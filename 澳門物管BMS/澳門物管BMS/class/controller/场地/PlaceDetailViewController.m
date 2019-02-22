//
//  PlaceDetailViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/2/21.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "Place.h"
#import <MJExtension/MJExtension.h>
#import "BaseNavigationViewController.h"
#import "ClubhouseReservationViewController.h"
#import "DrawerViewController.h"
@interface PlaceDetailViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *maximumDayLab;
@property (weak, nonatomic) IBOutlet UILabel *advanceDayLab;
@property (weak, nonatomic) IBOutlet UIView *openView;
@property (weak, nonatomic) IBOutlet UILabel *openStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *plateNameLab;
@property (weak, nonatomic) IBOutlet UILabel *plateContentLab;
@property (weak, nonatomic) IBOutlet UIView *plateOpenView;
@property (weak, nonatomic) IBOutlet UIView *plateContentView;
@property (weak, nonatomic) IBOutlet UIImageView *openImageView;

@property (nonatomic,strong)Place *place;
@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.backgroundColor=[UIColor clearColor];
    _imageView.delegate=self;
    
    _plateOpenView.layer.borderWidth=0.5;
    _plateOpenView.layer.borderColor=RGB(130, 130, 130).CGColor;
    
    _plateContentView.layer.borderWidth=0.5;
    _plateContentView.layer.borderColor=RGB(130, 130, 130).CGColor;
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {
    MMDrawerController *mm=self.presentingViewController.presentingViewController;
    BaseNavigationViewController *nvc=[mm centerViewController];
    ClubhouseReservationViewController *clubVC=[[nvc viewControllers] objectAtIndex:1];
    clubVC.placeId=_placeID;
    clubVC.placeName=_place.placeName;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestPlace {
    NSDictionary *para=@{
                         @"placeId" :_placeID
                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlace:para completion:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        _place=[Place mj_objectWithKeyValues:dic];
        _plateNameLab.text=_place.placeName;
        NSString *startStr=[_place.placeStartTime substringToIndex:16];
        NSString *endStr=[_place.placeEndTime substringToIndex:16];
        if (_place.placeStartTime.length==0) {
            _openTimeLab.text=[NSString stringWithFormat:@"%@",endStr];
        }else if (_place.placeEndTime.length==0){
            _openTimeLab.text=[NSString stringWithFormat:@"%@",startStr];
        }else{
            _openTimeLab.text=[NSString stringWithFormat:@"%@~%@",startStr,endStr];
        }

//        _openTimeLab.text=[NSString stringWithFormat:@"%@~%@",startStr,endStr];
        _maximumDayLab.text=[NSString stringWithFormat:@"%ld",_place.placeFarthestOrderDay];
        _advanceDayLab.text=[NSString stringWithFormat:@"%ld",_place.placeAdvanceOrderDay];
        if (_place.placeStatus==0) {
          //  _openStatusLab.text=@"未開放";
           // _openView.backgroundColor=[UIColor redColor];
            _openImageView.hidden=NO;
        }else if(_place.placeStatus==1){
            _openImageView.hidden=YES;
           // _openStatusLab.text=@"開放";
           // _openView.backgroundColor=[UIColor greenColor];
        }
        _plateNameLab.text=_place.placeName;
        _plateContentLab.text=_place.placeIntroduction;
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
        _imageView.imageURLStringsGroup = imageThumbnailArr;
        _imageView.autoScrollTimeInterval = 4.0f;
//        NSString *imageStr=[imageUrlArr componentsJoinedByString:@","];
//        NSString *imageThumbStr=[imageThumbnailArr componentsJoinedByString:@","];
//        NSArray *imageArr=[imageStr componentsSeparatedByString:@","];
//        NSArray *imageThumbArr=[imageThumbStr componentsSeparatedByString:@","];
//        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageArr[0]]] placeholderImage:image];
//        }];
        //        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageUrlArr[0]]]placeholderImage:kEMPTYIMG completed:nil];
    }];
    
    
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self requestPlace];
}
@end
