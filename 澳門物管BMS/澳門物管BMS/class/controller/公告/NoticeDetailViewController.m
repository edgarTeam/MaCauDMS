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
@interface NoticeDetailViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *noticeTitleLab;
//@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *noticeImageView;

@property (nonatomic,strong) NSMutableArray *imageThumbnailArr;//缩略图数组
@property (nonatomic,strong) NSMutableArray *imageUrlArr; //图片数组
@property (nonatomic,strong) Notice *notice;
@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 //   self.title=@"公告詳情";
    self.title=LocalizedString(@"string_notice_detail_title");
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _noticeTextView.layer.masksToBounds=YES;
    _noticeTextView.layer.cornerRadius=7.0;
    _noticeTextView.layer.borderWidth=0.5;
    _noticeTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
    
    _imageThumbnailArr=[NSMutableArray new];
    _imageUrlArr=[NSMutableArray new];
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
        self.noticeTitleLab.text=self.notice.noticeTitle;
        self.createTimeLable.text=self.notice.createTime;
        self.noticeTextView.text=self.notice.noticeDetails;
        if (self.notice.noticeImage.count ==0 || self.notice.noticeImage ==nil ) {
            return;
        }
        for (NoticeSubList *notice in self.notice.noticeImage) {
            if (notice.imageThumbnail !=nil) {
                [_imageThumbnailArr addObject:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,notice.imageThumbnail]];
            }
            if (notice.imageUrl !=nil) {
                [_imageUrlArr addObject:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,notice.imageUrl]];
            }
        }
        if (_imageThumbnailArr.count !=0 && _imageThumbnailArr !=nil) {
             NSArray *imageThumbArr=[_imageThumbnailArr[0] componentsSeparatedByString:@","];
        }
        if (_imageUrlArr.count ==0 || _imageUrlArr ==nil) {
            return;
        }
        NSArray *imageArr=[_imageUrlArr[0] componentsSeparatedByString:@","];
        _noticeImageView.imageURLStringsGroup = imageArr;
        _noticeImageView.autoScrollTimeInterval = 4.0f;
//        _noticeImageView.currentPageDotColor
        
        
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,self.notice.noticeImage]];
//        [self.noticeImageView sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];


    }];
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{

}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    
}






- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestNotice];
}

@end
