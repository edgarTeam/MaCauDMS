//
//  HandlingDetailsViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "HandlingDetailsViewController.h"
#import "ReportMaintenanceDetail.h"
@interface HandlingDetailsViewController ()
@property (nonatomic,strong) ReportMaintenanceDetail *complain;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contactWayLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (nonatomic,strong) NSArray *statusArr;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) NSURL *voiceUrl;
@property (nonatomic,strong) AVPlayer *player;
//@property (nonatomic,strong) NSString *voiceURL;
@end

@implementation HandlingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"報事詳情";
    self.title=LocalizedString(@"string_report_maintenance_detail_title");
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor clearColor];
    _contentTextView.layer.masksToBounds=YES;
    _contentTextView.layer.cornerRadius=7.0;
    _contentTextView.layer.borderWidth=0.5;
    _contentTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
    _contentTextView.editable=NO;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    textAttachment.image = [UIImage imageNamed:@""];
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [string insertAttributedString:textAttachmentString atIndex:string.length];//index为用户指定要插入图片的位置
    
    _contentTextView.attributedText = string;
    
    _statusArr=@[@"发起",@"收到",@"处理中",@"处理完成"];

}
- (IBAction)playBtnAction:(id)sender {
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:self.voiceUrl];
    //  播放当前资源
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requestComplain {
    NSDictionary *para=@{
                        @"complainId":_complainId
                        };
    [[WebAPIHelper sharedWebAPIHelper] postComplain:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        _complain=[ReportMaintenanceDetail mj_objectWithKeyValues:dic];
        _titleLab.text=_complain.complainClassType;
        _positionLab.text=[NSString stringWithFormat:@"%@,%@",_complain.complainPosition,_complain.complainSpecificPosition];
        _nameLab.text=_complain.complainLiaisonsName;
        _contactWayLab.text=_complain.complainLiaisonsEmail;
        _createTimeLab.text=_complain.createTime;
        _contentTextView.text=_complain.complainDescribe;
        _voiceUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,_complain.complainVoice]];
        
        
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
//        textAttachment.image = [UIImage imageNamed:@""];
//        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        [string insertAttributedString:textAttachmentString atIndex:string.length];
        NSArray *imageArr=[_complain.complainImages componentsSeparatedByString:@","];
        
        for ( int i=0; i<imageArr.count; i++) {
             NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageArr[i]]];
            UIImage *image=[UIImage imageWithData:data];
            textAttachment.image = image;
            NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [string insertAttributedString:textAttachmentString atIndex:string.length];
        }
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:]];
        _statusLab.text=_statusArr[[_complain.complainStatus intValue]];
//        dataSource[[_palceRecord.recordStatus intValue]+1];
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestComplain];
}
@end
