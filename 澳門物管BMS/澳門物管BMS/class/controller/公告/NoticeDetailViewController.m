//
//  NoticeDetailViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/7.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "Notice.h"
#import "NoticeSubList.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "NoticeImageViewController.h"


@interface NoticeDetailViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noticeTitleLab;
//@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *noticeImageView;

@property (nonatomic,strong) NSMutableArray *imageThumbnailArr;//缩略图数组
@property (nonatomic,strong) NSMutableArray *imageUrlArr; //图片数组
@property (nonatomic,strong) NSMutableArray *turnImageArr;  //轮播图数组
@property (nonatomic,strong) Notice *notice;
@property (nonatomic,strong) NSString *timeStr;//時間
@property (weak, nonatomic) IBOutlet UILabel *noticeTimeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *noticeConventTitleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;



@end

@implementation NoticeDetailViewController
{
    NSString * imageURL;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 //   self.title=@"公告詳情";
    self.title=LocalizedString(@"string_notice_detail_title");
    self.baseTitleLab.text=LocalizedString(@"string_notice_detail_title");
 //   self.edgesForExtendedLayout=UIRectEdgeNone;
    
//    _noticeTextView.layer.masksToBounds=YES;
//    _noticeTextView.layer.cornerRadius=7.0;
    _noticeTextView.layer.borderWidth=0.5;
    _noticeTextView.layer.borderColor=RGB(138, 138, 138).CGColor;
    [_noticeTextView setEditable:NO];
    _imageThumbnailArr=[NSMutableArray new];
    _imageUrlArr=[NSMutableArray new];
    _noticeImageView.backgroundColor=[UIColor clearColor];
    
    _noticeTimeTitleLab.text=LocalizedString(@"string_notice_time_title");
    _noticeConventTitleLab.text=LocalizedString(@"string_notice_convent_title");
    self.detailBtn.hidden=YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requestNotice {
    self.noticeImageView.delegate=self;
    NSDictionary *para=@{
                         @"noticeId":_noticeId
                         };
    [[WebAPIHelper sharedWebAPIHelper] postNotice:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        self.notice=[Notice mj_objectWithKeyValues:dic];
        if ([self.notice.createTime rangeOfString:@"T"].location !=NSNotFound) {
            _timeStr=[self.notice.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        }
        if (_timeStr.length !=0) {
            _timeStr=[_timeStr substringToIndex:19];
        }
        self.createTimeLable.text=_timeStr;
        self.noticeTitleLab.text=self.notice.noticeTitle;
       // self.createTimeLable.text=self.notice.createTime;
        self.noticeTextView.text=self.notice.noticeDetails;
        if (self.notice.noticeImage.count ==0 || self.notice.noticeImage ==nil ) {
            _imageViewHeight.constant=0;
            return;
        }
        for (NoticeSubList *notice in self.notice.noticeImage) {
            if (notice.imageThumbnail !=nil) {
                [_imageThumbnailArr addObject:[NSString stringWithFormat:@"%@",notice.imageThumbnail]];
            }
            if (notice.imageUrl !=nil) {
                [_imageUrlArr addObject:[NSString stringWithFormat:@"%@",notice.imageUrl]];
            }
        }

        if (_imageUrlArr.count ==0 || _imageUrlArr ==nil) {
            return;
        }
        imageURL=_imageThumbnailArr[0];
        if (imageURL.length!=0 ) {
            self.detailBtn.hidden=NO;
        }
//        NSString *imageStr=[_imageUrlArr componentsJoinedByString:@","];
//        NSArray *imageArr=[imageStr componentsSeparatedByString:@","];
//        _turnImageArr=[NSMutableArray new];
//        for (int i=0; i <imageArr.count; i++) {
//            [_turnImageArr addObject:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageArr[i]]];
//
//        }
//        _noticeImageView.imageURLStringsGroup = _turnImageArr;
//        _noticeImageView.autoScrollTimeInterval = 4.0f;

        
        
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,self.notice.noticeImage]];
//        [self.noticeImageView sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];


    }];
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{

}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    
}



- (IBAction)detailBtnAction:(id)sender {
    NoticeImageViewController *noticeImageVC=[NoticeImageViewController new];
    noticeImageVC.imageUrl=imageURL;
    [self.navigationController pushViewController:noticeImageVC animated:YES];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
//    self.dismissBtn.hidden=YES;
    [self requestNotice];
//     self.backBtn.tag = 1005;
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
//        self.topView.hidden=NO;
        self.backBtn.tag = 1005;
//        [self.backBtn removeTarget:self.superclass action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//        self.dismissBtn.hidden=NO;
//        [self.dismissBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [self.dismissBtn addTarget:self action:@selector(rebackToRootViewAction) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
    }else{
//        self.dismissBtn.hidden=YES;
//        self.navigationItem.leftBarButtonItem=nil;
    }
}

//- (void)rebackToRootViewAction {
//    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
//    [pushJudge setObject:@""forKey:@"push"];
//    [pushJudge synchronize];//记得立即同步
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
@end
