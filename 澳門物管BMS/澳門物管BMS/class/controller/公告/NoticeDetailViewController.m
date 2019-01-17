//
//  NoticeDetailViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/7.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "Notice.h"
@interface NoticeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *noticeTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;
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
    NSDictionary *para=@{
                         @"noticeId":@(1)
                         };
    [[WebAPIHelper sharedWebAPIHelper] postNotice:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        self.notice=[Notice mj_objectWithKeyValues:dic];
        self.noticeTitleLab.text=self.notice.noticeTitle;
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,self.notice.noticeImage]];
        [self.noticeImageView sd_setImageWithURL:url placeholderImage:kEMPTYIMG];
//        [self.noticeImageView setImage:[UIImage imageNamed:self.notice.noticeImage]];
        self.createTimeLable.text=self.notice.createTime;
        self.noticeTextView.text=self.notice.noticeDetails;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestNotice];
}

@end
