//
//  ReportMaintenanceViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

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
    if (![self login]) {
        return;
    }
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.headView.hidden=YES;
    self.dataSource=[NSMutableArray new];
    self.communityList=[NSMutableArray new];
    _maintenanceTextView.layer.masksToBounds=YES;
    _maintenanceTextView.layer.cornerRadius=7.0;
    _maintenanceTextView.layer.borderWidth=0.5;
    _maintenanceTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
   // flowLayout.estimatedItemSize=CGSizeMake(40, 40);
    flowLayout.itemSize=CGSizeMake(40, 40);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _maintenanceCollectionView.collectionViewLayout=flowLayout;
    _maintenanceCollectionView.delegate=self;
    _maintenanceCollectionView.dataSource=self;
    _maintenanceCollectionView.alwaysBounceVertical=YES;
    
    [self.recordBtn addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchDown];
    [self.recordBtn addTarget:self action:@selector(endRecord:) forControlEvents:UIControlEventTouchUpInside];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)beginRecord:(UIButton *)btn {
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (session == nil) {
        NSLog(@"error: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    self.session = session;
    
    NSDictionary *recordSetting = @{
                                    AVEncoderAudioQualityKey : [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderBitRateKey : [NSNumber numberWithInt:16],
                                    AVFormatIDKey : [NSNumber numberWithInt:kAudioFormatLinearPCM],
                                    AVNumberOfChannelsKey : @2,
                                    AVLinearPCMBitDepthKey : @8
                                    };
    
    NSString *document=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask ,YES) firstObject];
    // filePath=[document stringByAppendingString:@"/Record.wav"];
//    filePath = [NSString stringWithFormat:@"%@/%@.wav",document,@"123"];
    filePath = [NSString stringWithFormat:@"%@/%@.mp3",document,@"123"];
    // NSLog(@"%@",filePath);
    _recordFileUrl=[NSURL fileURLWithPath:filePath];
    _recorder=[[AVAudioRecorder alloc] initWithURL:_recordFileUrl settings:recordSetting error:nil];
    if (!_recorder) {
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
        return;
    }
    _recorder.meteringEnabled=YES;
    [_recorder prepareToRecord];
    _recorder.delegate=self;
    if (!_session.inputIsAvailable) {
        return;
    }
    [_recorder record];
    playTime = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addRecordTime) userInfo:nil repeats:YES];
    
    
}

-(void)addRecordTime{
    playTime++;
//    NSLog(@"%ld",playTime);
//    self.label.text=[NSString stringWithFormat:@"%ld 秒",playTime];
}
#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *err = nil;
    NSLog(@"%@",url);
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options:0 error:&err];
    if (audioData) {
        [self endConvertWithData:audioData];
    }
}
//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    // [self.delegate UUInputFunctionView:self sendVoice:voiceData time:playTime+1];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.recordBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //self.recordBtn.enabled = YES;
        // [self.recordBtn setEnabled:YES];

        //  self.hidden=YES;
    });
}





- (void)endRecord:(UIButton *)btn {
    
}


- (void)requestAddRepair {
    NSDictionary *para=@{
                         @"complainPosition":_communityLab.text,
                         @"complainLiaisonsEmail":[User shareUser].email,
                         @"complainLiaisonsName":[User shareUser].name,
                         @"complainLiaisonsSex":[User shareUser].sex,
                         @"complainPosition":_communityLab.text,
                         @"complainSpecificPosition":_addressTextField.text
                         };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
    NSDictionary *dic=@{
                        @"complain":jsonData
                        };
    [[WebAPIHelper sharedWebAPIHelper] postWithUrl:kAddComplain body:dic showLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        _reportMaintenance=[ReportMaintenanceDetail mj_setKeyValues:dic[@"data"]];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];

}



- (void)requestCommunityList {
    NSDictionary *para=@{
                         @"pageNo":@(1),
                             @"pageSize":@(1)
                         };
    [[WebAPIHelper sharedWebAPIHelper] postCommunity:para completion:^(NSDictionary *dic){
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
        return _photoCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [self showChangeAvatarAlert];
    }
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row ==0) {
//
//
//    self.maintenanceCollectionView = collectionView;
//
//   // self.addCell = [collectionView cellForItemAtIndexPath:indexPath];
//    UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        style = UIAlertControllerStyleAlert;
//    }
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
//    UIAlertAction *alertAc1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
//    }];
//
//    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
//        }];
//
////    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
////
////        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
////            PureCamera *homec = [[PureCamera alloc] init];
////            @weakify(self);
////            homec.fininshcapture = ^(UIImage *ss) {
////                if (ss) {
////                    [weak_self addImageToData:ss];
////                }
////            };
////            [self presentViewController:homec
////                               animated:NO
////                             completion:^{
////                             }];
////        } else {
////            NSLog(@"相机调用失败");
////        }
////
////
////    }];
//    UIAlertAction *alertAc3 = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
//    [alertC addAction:alertAc1];
//    [alertC addAction:alertAc2];
//    [alertC addAction:alertAc3];
//
//    [self presentViewController:alertC animated:NO completion:nil];
//    }
//}
//
//
//#pragma -mark- UIImagePickerController
//
//- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType andCameraCaptureMode:(UIImagePickerControllerCameraCaptureMode)mode{
//    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
//        //有相机
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        //这是 VC 的各种 modal 形式
//        //imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        imagePickerController.sourceType = sourceType;
//        //支持的摄制类型,拍照或摄影,此处将本设备支持的所有类型全部获取,并且同时赋值给imagePickerController的话,则可左右切换摄制模式
//    //    imagePickerController.mediaTypes = @[(NSString *) kUTTypeImage];
//        imagePickerController.delegate = self;
//        //允许拍照后编辑
//        imagePickerController.allowsEditing = NO;
//        //显示默认相机 UI, 默认为yes--> 显示
//        //    imagePickerController.showsCameraControls = NO;
//
//        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
//            //设置模式-->拍照/摄像
//            imagePickerController.cameraCaptureMode = mode;
//            //开启默认摄像头-->前置/后置
//            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
//            //设置默认的闪光灯模式-->开/关/自动
//            imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
//
//            //拍摄时预览view的transform属性，可以实现旋转，缩放功能
//            //        imagePickerController.cameraViewTransform = CGAffineTransformMakeRotation(M_PI);
//            //        imagePickerController.cameraViewTransform = CGAffineTransformMakeScale(2.0,2.0);
//
//            //自定义覆盖图层-->overlayview
//            //            UIImage *img = [UIImage imageNamed:@"085625KMV.jpg"];
//            //            UIImageView *iv = [[UIImageView alloc] initWithImage:img];
//            //            iv.width = 300;
//            //            iv.height = 200;
//            //            imagePickerController.cameraOverlayView = iv;
//
//        }
//
//        [self presentViewController:imagePickerController animated:YES completion:nil];
//
//    }
//    else {
//        NSLog(@"这设备没相机 ");
//    }
//
//}
//
//#pragma -mark- UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    [picker dismissViewControllerAnimated:YES completion:^{
//
//        NSString *mediaType = info[UIImagePickerControllerMediaType];
//
//        if ([mediaType isEqualToString:@"public.image"]) {
//
//            /*
//             //获取照片的原图
//             UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
//             //获取图片裁剪后，剩下的图
//             UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
//             //获取图片的url
//             NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
//             //获取图片的metadata数据信息
//             NSDictionary* metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//             */
//
//            //获取图片裁剪的图
//            //UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
//
//            UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
//
//
////            TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:original];
////            cropController.delegate = self;
////            [self presentViewController:cropController animated:YES completion:nil];
//
//
//
//        }else{  // public.movie
//
//        }
//
//    }];
//}

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
            
            /*
             //获取照片的原图
             UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
             //获取图片裁剪后，剩下的图
             UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
             //获取图片的url
             NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
             //获取图片的metadata数据信息
             NSDictionary* metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
             */
            
            //获取图片裁剪的图
            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
           // self.headImage.image = edit;
            self.photoCell.photoImageView.image=edit;
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
            [User shareUser].portrait=[info objectForKey:@"data"];
        }
    }];
    
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    if (![self login]) {
        return;
    }
}
@end
