//
//  HandlingDetailsViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "HandlingDetailsViewController.h"
#import "ReportMaintenanceDetail.h"
#import "NoticeSubList.h"
#import "ZKAlertTool.h"
#import "UILabel+LabelHeightAndWidth.h"
#import "PhotpCollectionViewCell.h"
#import "PictureModel.h"
@interface HandlingDetailsViewController ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
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
//@property (nonatomic,strong) NSURL *voiceUrl;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) NSString *voiceURL;
@property (nonatomic,strong) NSString *timeStr; //時間
@property (weak, nonatomic) IBOutlet UILabel *repairCommunityNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairClientNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairContactTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairCreateTimeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairDiscribeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairVoiceTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairProgressTitleLab;
//@property (weak, nonatomic) IBOutlet UILabel *repairHandlerTitleLab;
//@property (weak, nonatomic) IBOutlet UILabel *handlerNameLab;
@property (weak, nonatomic) IBOutlet UILabel *characterDescriptionLab;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,strong) PhotpCollectionViewCell *photoCell;
@end

@implementation HandlingDetailsViewController
{
    CGFloat scrollerHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"報事詳情";
    self.title=LocalizedString(@"string_report_maintenance_detail_title");
   // self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor clearColor];
    
    //self.scrollView.contentSize=CGSizeMake(0, scrollerHeight);
    self.scrollView.contentSize=CGSizeMake(scrollerHeight, 0);
//    UIGestureRecognizer *gesture=[[UIGestureRecognizer alloc] init];
//    gesture.delegate=self;
//    [self.contentTextView addGestureRecognizer:gesture];
//    _contentTextView.layer.masksToBounds=YES;
//    _contentTextView.layer.cornerRadius=7.0;
//    _contentTextView.layer.borderWidth=0.5;
//    _contentTextView.layer.borderColor=RGB(63, 114, 156).CGColor;
//    _contentTextView.editable=NO;
//    _contentTextView.scrollEnabled=YES;
    _dataSource=[NSMutableArray new];
    
//    _characterDescriptionLab.layer.masksToBounds=YES;
//    _characterDescriptionLab.layer.cornerRadius=7.0;
//    _characterDescriptionLab.layer.borderWidth=0.5;
//    _characterDescriptionLab.layer.borderColor=RGB(63, 114, 156).CGColor;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
    flowLayout.itemSize=CGSizeMake(80, 80);
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    _imageCollectionView.collectionViewLayout=flowLayout;
    _imageCollectionView.delegate=self;
    _imageCollectionView.dataSource=self;
    _imageCollectionView.alwaysBounceVertical=YES;
    _imageCollectionView.layer.masksToBounds=YES;
    _imageCollectionView.layer.cornerRadius=7.0;
    _imageCollectionView.layer.borderWidth=0.5;
    _imageCollectionView.layer.borderColor=RGB(63, 114, 156).CGColor;
    _imageCollectionView.scrollEnabled=NO;
    
    _repairCommunityNameTitleLab.text=LocalizedString(@"string_repair_community_name_third_title");
    _repairClientNameTitleLab.text=LocalizedString(@"sreing_repair_detail_client_name_third_title");
    _repairContactTitleLab.text=LocalizedString(@"string_repair_detail_contact_third_title");
    _repairCreateTimeTitleLab.text=LocalizedString(@"string_repair_detail_create_time_third_title");
    _repairDiscribeTitleLab.text=LocalizedString(@"string_repair_describe_third_title");
    _repairVoiceTitleLab.text=LocalizedString(@"string_repair_detail_voice_third_title");
    _repairProgressTitleLab.text=LocalizedString(@"string_repair_progress_third_title");
   // _repairHandlerTitleLab.text=LocalizedString(@"string_repair_handler_title");
    
   // _positionLab.text=@"sfdgdgtr看到過大過天後研究研究的風格桃花源地方很高";
    [_positionLab sizeToFit];
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
//    textAttachment.image = [UIImage imageNamed:@""];
//    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    [string insertAttributedString:textAttachmentString atIndex:string.length];//index为用户指定要插入图片的位置
//    
//    _contentTextView.attributedText = string;
    
    _statusArr=@[@"發起",@"收到",@"處理中",@"處理完成"];

    [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
     [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
    
    
}
- (IBAction)playBtnAction:(id)sender {
    if (_voiceURL.length ==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_voice_title")];
        return;
    }
    
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,_voiceURL]]];
//    //  播放当前资源
//    [self.player replaceCurrentItemWithPlayerItem:playerItem];
//    [self.player play];
    if (self.player.rate ==0) {
        [self.progressView setProgress:0.0 animated:NO];
        [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
    }
    
    if (self.progressView.progress < 1.0 && self.progressView.progress !=0) {
        [self.player pause];
        [self.progressView setProgress:0.0 animated:NO];
        [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
        
    }else{
        [self.progressView setProgress:0.0 animated:NO];
        
                AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:self.voiceURL]]];
        
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
        //观察Status属性，可以在加载成功之后得到视频的长度
        [self.player.currentItem addObserver:self forKeyPath:@"status"options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc] init];
        _player.volume = 1.0;
    }
    return _player;
}

//2.添加属性观察
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        //获取playerItem的status属性最新的状态
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:{
                [self.playBtn setTitle:@"点击停止播放" forState:UIControlStateNormal];
                //获取视频长度
                CMTime duration = playerItem.asset.duration;
                //更新显示:视频总时长(自定义方法显示时间的格式)
                float totalTime   = CMTimeGetSeconds(duration);
                NSLog(@"录制时间：%f",totalTime);
              
                [self.player play];
                [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time){
                    float currentTime=CMTimeGetSeconds(self.player.currentItem.currentTime);
                    self.progressView.progress =currentTime/totalTime;
                    if (self.progressView.progress ==1.0f) {
                        [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
                    }
                    NSLog(@"当前播放时间：%f",currentTime);
                }];
                break;
            }
            case AVPlayerStatusFailed:{//视频加载失败，点击重新加载
                NSLog(@"加载视频失败:UIControlStateNormal");
                break;
            }
            case AVPlayerStatusUnknown:{
                NSLog(@"加载遇到未知问题:AVPlayerStatusUnknown");
                break;
            }
            default:
                break;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];

//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"status"];
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
        [_dataSource removeAllObjects];
        _complain=[ReportMaintenanceDetail mj_objectWithKeyValues:dic];
        if ([_complain.createTime rangeOfString:@"T"].location !=NSNotFound) {
            _timeStr=[_complain.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        }else{
            _timeStr=_complain.createTime;
        }
        
        if (_timeStr.length !=0) {
            _timeStr=[_timeStr substringToIndex:16];
        }
        
        _titleLab.text=_complain.complainClassType;
        _positionLab.text=[NSString stringWithFormat:@"%@,%@",_complain.complainPosition,_complain.complainSpecificPosition];
      //  _handlerNameLab.text=_complain.complainHandler;
        _nameLab.text=_complain.complainLiaisonsName;
        _contactWayLab.text=_complain.complainLiaisonsEmail;
//          _contactWayLab.text=@"asssssddfggfhrd官方的客戶";
      //  _createTimeLab.text=_complain.createTime;
        _createTimeLab.text=_timeStr;
        _characterDescriptionLab.text=_complain.complainDescribe;
       // _contentTextView.text=_complain.complainDescribe;

//        _voiceUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,_complain.complainVoice]];
        _voiceURL=_complain.complainVoice;
         _statusLab.text=_statusArr[[_complain.complainStatus intValue]];
        
        _dataSource=_complain.images;
        //_dataSource%3*90
        _collectionHeight.constant=_dataSource.count/3*90;
        [self.imageCollectionView reloadData];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
//        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
//        textAttachment.image = [UIImage imageNamed:@""];
//        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        [string insertAttributedString:textAttachmentString atIndex:string.length];
//        NSArray *imageArr=[_complain.complainImages componentsSeparatedByString:@","];
        
//        NSMutableArray *imageThumbnailArr=[NSMutableArray new];
//        NSMutableArray *imageUrlArr=[NSMutableArray new];
//        if(_complain.images ==nil || _complain.images.count ==0){
//            return;
//        }
//        for (NoticeSubList *notice in _complain.images) {
//            if (notice.imageUrl !=nil) {
//                [imageUrlArr addObject:notice.imageUrl];
//            }
//            if (notice.imageThumbnail !=nil) {
//                [imageThumbnailArr addObject:notice.imageThumbnail];
//            }
//        }
//        if (imageUrlArr.count ==0 || imageUrlArr ==nil) {
//            return;
//        }
//        if (imageThumbnailArr.count ==0 || imageThumbnailArr ==nil) {
//            return;
//        }
//
//         UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] init];
//        tap.delegate=self;
//        for ( int i=0; i<imageThumbnailArr.count; i++) {
//            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
//            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
//             NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageThumbnailArr[i]]]];
//            UIImage *image=[UIImage imageWithData:data];
//
//            textAttachment.image = image;
//            textAttachment.bounds=CGRectMake(0, 0, 80, 80);
//            NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//            [string insertAttributedString:textAttachmentString atIndex:string.length];
//        _contentTextView.attributedText=string;
//        }
       //  _contentTextView.attributedText=string;
//        [textAttachment setImage:[UIImage imageNamed:@"rain"]];
//        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        [string insertAttributedString:textAttachmentString atIndex:string.length];
//        _contentTextView.attributedText=string;
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:]];
       
//        dataSource[[_palceRecord.recordStatus intValue]+1];
        
        
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        //        [self.maintenanceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
        [self.imageCollectionView registerNib:[UINib nibWithNibName:@"PhotpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
        //        PhotpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotpCollectionViewCell" forIndexPath:indexPath];
        //        return cell;
        _photoCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotpCollectionViewCell" forIndexPath:indexPath];
        NSMutableArray *orignalUrlArr=[NSMutableArray new];
        NSMutableArray *thumbnailUrlArr=[NSMutableArray new];
    for (NoticeSubList *notice in _dataSource) {
        if (notice.imageUrl !=nil) {
            [orignalUrlArr addObject:notice.imageUrl];
        }
        if (notice.imageThumbnail !=nil) {
            [thumbnailUrlArr addObject:notice.imageThumbnail];
        }
    }
        
//        for (PictureModel *model in _dataSource) {
//            if (model.originalUrl !=nil) {
//                [orignalUrlArr addObject:model.originalUrl];
//            }
//            if (model.thumbnailUrl !=nil) {
//                [thumbnailUrlArr addObject:model.thumbnailUrl];
//            }
//
//        }
        //        for (PictureModel *model in _dataSource) {
        //            [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:model.originalUrl]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //                [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:model.thumbnailUrl]] placeholderImage:image];
        //            }];
        //            _photoCell.deleteBtnAction = ^{
        //                NSLog(@"%ld",_dataSource.count);
        //                [_dataSource removeObjectAtIndex:indexPath.row-1];
        //                [collectionView reloadData];
        //            };
        //        }
        [_photoCell.activityIndicatorView startAnimating];
        _photoCell.deleteBtn.hidden=YES;
//        [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:thumbnailUrlArr[indexPath.row]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            NSLog(@"错误信息：%@",error);
//            [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:orignalUrlArr[indexPath.row]]] placeholderImage:image];
//            _photoCell.deleteBtn.hidden=YES;
//            [_photoCell.activityIndicatorView stopAnimating];
//            _photoCell.activityIndicatorView.hidden=YES;
//        }];
    
    [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,thumbnailUrlArr[indexPath.row]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL){
        [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,orignalUrlArr[indexPath.row]]]];
        _photoCell.deleteBtn.hidden=YES;
        [_photoCell.activityIndicatorView stopAnimating];
        _photoCell.activityIndicatorView.hidden=YES;
    }];
        return _photoCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        
       // [self showChangeAvatarAlert];
    }
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestComplain];
}
@end
