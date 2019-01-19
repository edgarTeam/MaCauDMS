//
//  ReportMaintenanceViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#import "UITextView+PlaceHolder.h"
#import "ReportMaintenanceViewController.h"
#import "PhotpCollectionViewCell.h"
#import "AddCollectionViewCell.h"
#import "Community.h"
#import "LSXPopMenu.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "HttpHelper.h"
#import "CommonUtil.h"
#import "User.h"
#import "ReportMaintenanceDetail.h"
#import "PictureModel.h"
#import "NSDate+Utils.h"
@interface ReportMaintenanceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LSXPopMenuDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *maintenanceTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *maintenanceCollectionView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *communityList;
@property (nonatomic,strong) AddCollectionViewCell *addCell;
@property (nonatomic,strong) PhotpCollectionViewCell *photoCell;
@property (weak, nonatomic) IBOutlet UILabel *communityLab;
@property (weak, nonatomic) IBOutlet UIButton *communityBtn;
@property (nonatomic,strong) LSXPopMenu *communityMenu;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (nonatomic,strong) ReportMaintenanceDetail *reportMaintenance;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

@implementation ReportMaintenanceViewController
{
    NSInteger playTime;
    NSString *filePath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"報事維修";

    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.headView.hidden=YES;
    self.dataSource=[NSMutableArray new];
    self.communityList=[NSMutableArray new];
    _maintenanceTextView.placeHoldString=@"请输入报修内容";
    _maintenanceTextView.layer.masksToBounds=YES;
    _maintenanceTextView.layer.cornerRadius=7.0;
    _maintenanceTextView.layer.borderWidth=0.5;
    _maintenanceTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
   // flowLayout.estimatedItemSize=CGSizeMake(40, 40);
    flowLayout.itemSize=CGSizeMake(80, 80);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _maintenanceCollectionView.collectionViewLayout=flowLayout;
    _maintenanceCollectionView.delegate=self;
    _maintenanceCollectionView.dataSource=self;
    _maintenanceCollectionView.alwaysBounceVertical=YES;
    

    [self requestCommunityList];
    [self.maintenanceCollectionView reloadData];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)requestAddRepair {
    NSMutableArray *imageThumbnailArr=[NSMutableArray new];
    NSMutableArray *imageUrlArr=[NSMutableArray new];
    if (_dataSource.count ==0 || _dataSource ==nil || [_dataSource isKindOfClass:[NSNull class]]) {
        return;
    }
    for (PictureModel *model in _dataSource) {
        if (model.thumbnailUrl !=nil) {
            [imageThumbnailArr addObject:model.thumbnailUrl];
        }
        
        if (model.originalUrl !=nil) {
            [imageUrlArr addObject:model.originalUrl];
        }
        
    }
    if (imageThumbnailArr ==nil || imageThumbnailArr.count ==0) {
        return;
    }
    if (imageUrlArr ==nil || imageUrlArr.count ==0) {
        return;
    }
    NSString *imageThumbnail=[imageThumbnailArr componentsJoinedByString:@","];
    NSString *imageUrl=[imageUrlArr componentsJoinedByString:@","];
    NSDictionary *picture=@{
                            @"imageThumbnail":imageThumbnail,
                            @"imageUrl":imageUrl
                            };
    
    NSDictionary *para=@{
                         @"complainPosition":_communityLab.text,
                         @"complainLiaisonsEmail":[User shareUser].email,
                         @"complainLiaisonsName":[User shareUser].name,
                         @"complainLiaisonsSex":[User shareUser].sex,
                         @"complainPosition":_communityLab.text,
                         @"complainSpecificPosition":_addressTextField.text,
                         @"complainVoice":self.voiceRemarkUrl==nil?@"":self.voiceRemarkUrl,
                         @"images":[NSArray arrayWithObjects:picture]
                         };
//    NSDictionary *dic=@{
//                        @"complain":para
//                        };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
   
    [[HttpHelper shareHttpHelper] postWithUrl:kAddComplain body:jsonData showLoading:YES success:^(NSDictionary *dicResult){
        if (dicResult ==nil) {
            return ;
        }
        _reportMaintenance=[ReportMaintenanceDetail mj_setKeyValues:dicResult[@"data"]];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];

}



- (void)requestCommunityList {
//    NSDictionary *para=@{
//                         @"pageNo":@(1),
//                             @"pageSize":@(1)
//                         };
    [[WebAPIHelper sharedWebAPIHelper] postCommunity:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *array=[dic objectForKey:@"list"];
        NSMutableArray *communityArr=[NSMutableArray new];
        communityArr=[Community mj_objectArrayWithKeyValuesArray:array];
        for (Community * community in communityArr) {
            [self.communityList addObject:community.communityName];
        }
    }];
}


- (IBAction)communityBtnAction:(id)sender {
    self.communityMenu=[LSXPopMenu showRelyOnView:sender titles:self.communityList icons:nil menuWidth:100 isShowTriangle:YES delegate:self];
}

-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    if (LSXPopupMenu ==_communityMenu) {
        [self.communityLab setText:self.communityList[index]];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
//        [self.maintenanceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AddCollectionViewCell"];
   [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"AddCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddCollectionViewCell"];
//        AddCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddCollectionViewCell" forIndexPath:indexPath];
//        return cell;
        _addCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddCollectionViewCell" forIndexPath:indexPath];
        return _addCell;
    }else{
//        [self.maintenanceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
        [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"PhotpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
//        PhotpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotpCollectionViewCell" forIndexPath:indexPath];
//        return cell;
        _photoCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotpCollectionViewCell" forIndexPath:indexPath];
        NSMutableArray *orignalUrlArr=[NSMutableArray new];
        NSMutableArray *thumbnailUrlArr=[NSMutableArray new];

        for (PictureModel *model in _dataSource) {
            if (model.originalUrl !=nil) {
                [orignalUrlArr addObject:model.originalUrl];
            }
            if (model.thumbnailUrl !=nil) {
                [thumbnailUrlArr addObject:model.thumbnailUrl];
            }
            
        }
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
        [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:orignalUrlArr[indexPath.row-1]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
             [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:thumbnailUrlArr[indexPath.row-1]]] placeholderImage:image];
        }];
        _photoCell.deleteBtnAction = ^{
                            NSLog(@"%ld",_dataSource.count);
                            [_dataSource removeObjectAtIndex:indexPath.row-1];
                            [collectionView reloadData];
                        };
        return _photoCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [self showChangeAvatarAlert];
    }
}


- (void)showChangeAvatarAlert {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAc1 = [UIAlertAction actionWithTitle:LocalizedString(@"string_take_album") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
    }];
    
    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:LocalizedString(@"string_take_photo") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        
    }];
    UIAlertAction *alertAc3 = [UIAlertAction actionWithTitle:LocalizedString(@"String_cancel") style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:alertAc1];
    [alertC addAction:alertAc2];
    [alertC addAction:alertAc3];
    
    [self presentViewController:alertC animated:NO completion:nil];
    
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType andCameraCaptureMode:(UIImagePickerControllerCameraCaptureMode)mode{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //有相机
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //这是 VC 的各种 modal 形式
        //imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        imagePickerController.sourceType = sourceType;
        //支持的摄制类型,拍照或摄影,此处将本设备支持的所有类型全部获取,并且同时赋值给imagePickerController的话,则可左右切换摄制模式
        imagePickerController.mediaTypes = @[(NSString *) kUTTypeImage];
        
        imagePickerController.delegate = self;
        //允许拍照后编辑
        imagePickerController.allowsEditing = YES;
        //显示默认相机 UI, 默认为yes--> 显示
        //    imagePickerController.showsCameraControls = NO;
        
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            //设置模式-->拍照/摄像
            imagePickerController.cameraCaptureMode = mode;
            //开启默认摄像头-->前置/后置
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            //设置默认的闪光灯模式-->开/关/自动
            imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            
            //拍摄时预览view的transform属性，可以实现旋转，缩放功能
            //        imagePickerController.cameraViewTransform = CGAffineTransformMakeRotation(M_PI);
            //        imagePickerController.cameraViewTransform = CGAffineTransformMakeScale(2.0,2.0);
            
            //自定义覆盖图层-->overlayview
            //            UIImage *img = [UIImage imageNamed:@"085625KMV.jpg"];
            //            UIImageView *iv = [[UIImageView alloc] initWithImage:img];
            //            iv.width = 300;
            //            iv.height = 200;
            //            imagePickerController.cameraOverlayView = iv;
            
        }
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
    else {
        NSLog(@"这设备没相机 ");
    }
    
}
#pragma -mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *mediaType = info[UIImagePickerControllerMediaType];
        
        if ([mediaType isEqualToString:@"public.image"]) {
            

            
            //获取图片裁剪的图
            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
       //     self.photoCell.photoImageView.image=edit;
            NSData *data = UIImageJPEGRepresentation(edit, 1.0);
            if (data.length>100*1024) {
                if (data.length>1024*1024) {//1M以及以上
                    data=UIImageJPEGRepresentation(edit, 0.1);
                }else if (data.length>512*1024) {//0.5M-1M
                    data=UIImageJPEGRepresentation(edit, 0.2);
                }else if (data.length>200*1024) {
                    //0.25M-0.5M
                    data=UIImageJPEGRepresentation(edit, 0.3);
                }
            }
            
            NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%f.png",[NSDate timeIntervalSinceReferenceDate]]];
            [data writeToFile:path atomically:YES];
            [self requestUploadImage:data];
        }
        
    }];
}

- (void)requestUploadImage:(NSData *)data{
    NSDictionary *dic=@{
                        @"type":@(0)
                        };
    [[HttpHelper shareHttpHelper] postUploadImagesWithUrl:kUploadImg parameters:dic images:[NSArray arrayWithObject:[UIImage imageWithData:data]] completion:^(NSDictionary * info){
        if ([CommonUtil isRequestOK:info]) {
            if ([[info allKeys]containsObject:@"data"]) {
                NSDictionary *dic=[info objectForKey:@"data"];
                 PictureModel *picture=[PictureModel mj_objectWithKeyValues:dic];
                if (picture.originalUrl!=nil) {
                   // [_dataSource addObject:picture.originalUrl];
                    [_dataSource addObject:picture];
                    [self.maintenanceCollectionView reloadData];
                }
                
            }
           // [User shareUser].portrait=[info objectForKey:@"data"];
            
        }
    }];
    
}

- (IBAction)startRecordAction:(id)sender {
    [self startRecord];
}

- (IBAction)stopRecordAction:(id)sender {
    [self stopRecord];
}

- (IBAction)playBtnAction:(id)sender {
    if (self.player.rate != 0) {
        [self.player pause];
        return;
    }
    
    if (self.recordPath != nil) {
        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:self.recordPath]];
        // 播放当前资源
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
        
    } else {
        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:self.voiceRemarkUrl]]];
       //  播放当前资源
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
    }
    
    [self.player play];
}

- (void)startRecord {
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {// 未询问用户是否授权
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
                [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                    if (granted) {
                        bCanRecord = YES;
                    } else {
                        bCanRecord = NO;
                    }
                }];
            }
            
        }
    }
    
 //   [ZKAlertTool showAlertWithMsg:@"是否开始录音！"];
    if (self.player.rate != 0) {
        [self.player pause];
    }
    //设置会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    //设置会话种类
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    //激活全局会话
    if (sessionError == nil) {
        [session setActive:YES error:nil];
    }
    //设置录音参数
//    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
//                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
//                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
//                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
//                                   [NSNumber numberWithInt:AVAudioQualityMax],AVEncoderAudioQualityKey,
//                                   nil];
    NSDictionary *recordSetting = @{
                                    AVEncoderAudioQualityKey : [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderBitRateKey : [NSNumber numberWithInt:16],
                                    AVFormatIDKey : [NSNumber numberWithInt:kAudioFormatLinearPCM],
                                    AVNumberOfChannelsKey : @2,
                                    AVLinearPCMBitDepthKey : @8
                                    };
    
    NSString *fileName = [NSString stringWithFormat:@"%@.wav",[NSDate getCurrentTimes]];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    self.recordPath = path;
    NSError *initError;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path]
                                               settings:recordSetting
                                                  error:&initError];
//    if (initError == nil) {
//
//    }
    if (!_recorder) {
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        return;
    }
    [self.recorder prepareToRecord];
    [self.recorder record];
    playTime = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addRecordTime) userInfo:nil repeats:YES];
    
    
}

-(void)addRecordTime{
    playTime++;
    //    NSLog(@"%ld",playTime);
    //    self.label.text=[NSString stringWithFormat:@"%ld 秒",playTime];
}


- (void)stopRecord {
    if (![self.recorder isRecording]) {
        return;
    }
    [self.recorder stop];
  //  [self stopTiming];
    NSFileManager *manager = [NSFileManager defaultManager];
    //计算文件大小
    if ([manager fileExistsAtPath:self.recordPath]){
        NSString *tipStr = [NSString stringWithFormat:@"录了文件大小为 %.2fMB",[[manager attributesOfItemAtPath:self.recordPath error:nil] fileSize]/1024.0/1024.0];
        NSLog(@"%@--%@",self.recordPath,tipStr);
    }
    self.playBtn.hidden = NO;
    self.deleteBtn.hidden=NO;
    NSDictionary *dic=@{
                        @"type":@(2)
                        };
    [[WebAPIHelper sharedWebAPIHelper] uploadVoice:dic filePath:self.recordPath completion:^(NSDictionary *resultDic){
        self.voiceRemarkUrl=[resultDic objectForKey:@"originalUrl"];
        NSLog(@"%@",self.voiceRemarkUrl);
    }];

}


//- (void)stopTiming {
//    dispatch_source_cancel(_timer);
//}

- (AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc] init];
        _player.volume = 1.0;
    }
    return _player;
}

- (IBAction)deleteBtnAction:(id)sender {
    self.voiceRemarkUrl=@"";
    self.playBtn.hidden=YES;
    self.deleteBtn.hidden=YES;
}
- (IBAction)submitAction:(id)sender {
    [self requestAddRepair];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    if (![self login]) {
        return;
    }
    
    [self requestCommunityList];
}



//- (void)viewDidDisappear:(BOOL)animated{
//
//    [self.communityBtn setTitle:@"" forState:UIControlStateNormal];
//    self.addressTextField.text=@"";
//    self.voiceRemarkUrl=@"";
//}
@end
