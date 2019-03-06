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
#import "ZKAlertTool.h"
#import "UUProgressHUD.h"
#import "PickViewController.h"
#import "BuildingModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Photos/Photos.h>
#import "UITextField+PlaceHolder.h"
#import "ReportMaintenanceDetail.h"
@interface ReportMaintenanceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LSXPopMenuDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate,UITextFieldDelegate>
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
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *communityTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairAddressTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *repairTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseBuildingBtn;
@property (nonatomic,strong) NSMutableArray *buildingList;
@property (weak, nonatomic) IBOutlet UITextField *repairTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *repairTitleTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recordBtnHeight;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@property (weak, nonatomic) IBOutlet UIImageView *buildingImage;
@property (weak, nonatomic) IBOutlet UIImageView *themeImage;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UIImageView *adressImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *buildingTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairTypeTitleLab;



@property (nonatomic,strong) ReportMaintenanceDetail *complain;
@end

@implementation ReportMaintenanceViewController
{
    NSInteger playTime;
    NSString *filePath;
    CGFloat scrollerHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _buildingTitleLab.font=[UIFont systemFontOfSize:16];
    _communityLab.font=[UIFont systemFontOfSize:16];
    _repairTypeTitleLab.font=[UIFont systemFontOfSize:16];
    _repairAddressTitleLab.font=[UIFont systemFontOfSize:16];
    _submitBtn.font=[UIFont systemFontOfSize:16];
    
    
    // Do any additional setup after loading the view from its nib.
   // self.title=@"報事維修";
   // [self.chooseBuildingBtn setTitle:@"请选择所在建筑" forState:UIControlStateNormal];
    
    switch (_type) {
        case ReportType:
        {
//            self.baseTitleLab.text=@"報事維修";
            self.baseTitleLab.text=LocalizedString(@"string_report_maintenance_title");
            _buildingImage.image=[UIImage imageNamed:@"icon_report_text_bg"];
            _themeImage.image=[UIImage imageNamed:@"icon_report_text_bg"];
            _typeImage.image=[UIImage imageNamed:@"icon_report_text_bg"];
            _adressImage.image=[UIImage imageNamed:@"icon_report_text_bg"];
            
            _repairTitleTextField.placeHoldColor=RGB(231, 93, 119);
            _repairTitleTextField.placeHoldString=@"请输入报修主题";
            _repairTypeTextField.placeHoldColor=RGB(231, 93, 119);
            _repairTypeTextField.placeHoldString=@"请输入报修类型";
            _addressTextField.placeHoldColor=RGB(231, 93, 119);
            _addressTextField.placeHoldString=@"请输入详细地址";
            _maintenanceTextView.placeHoldString=@"请输入报修内容";
            _maintenanceTextView.placeHoldColor=RGB(231, 93, 119);
            _maintenanceTextView.layer.borderColor=RGB(231, 93, 119).CGColor;
            
            //_chooseBuildingBtn.titleLabel.textColor=RGB(231, 93, 119);
            [_chooseBuildingBtn setTitleColor:RGB(231, 93, 119) forState:UIControlStateNormal];
        }
            break;
        case ComplainType:
        {
         //   self.baseTitleLab.text=@"投訴";
             self.baseTitleLab.text=LocalizedString(@"string_complain_title");
            _buildingImage.image=[UIImage imageNamed:@"icon_complain_text_bg"];
            _themeImage.image=[UIImage imageNamed:@"icon_complain_text_bg"];
            _typeImage.image=[UIImage imageNamed:@"icon_complain_text_bg"];
            _adressImage.image=[UIImage imageNamed:@"icon_complain_text_bg"];
            _repairTitleTextField.placeHoldColor=RGB(255, 159, 88);
            _repairTitleTextField.placeHoldString=@"请输入报修主题";
            _repairTypeTextField.placeHoldColor=RGB(255, 159, 88);
            _repairTypeTextField.placeHoldString=@"请输入报修类型";
            _addressTextField.placeHoldColor=RGB(255, 159, 88);
            _addressTextField.placeHoldString=@"请输入详细地址";
            _maintenanceTextView.placeHoldString=@"请输入报修内容";
            _maintenanceTextView.placeHoldColor=RGB(255, 159, 88);
            _maintenanceTextView.layer.borderColor=RGB(255, 159, 88).CGColor;
           // _chooseBuildingBtn.titleLabel.textColor=RGB(255, 159, 88);
            [_chooseBuildingBtn setTitleColor:RGB(255, 159, 88) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    
    
    scrollerHeight=self.scrollView.frame.size.height;
    
    [self createView];
    
}

- (void)createView {
   
    self.addressTextField.text=@"";
    self.maintenanceTextView.text=@"";
    self.dataSource=nil;
    self.voiceRemarkUrl=@"";
    
    _addressTextField.delegate=self;
    _repairTitleTextField.delegate=self;
    _repairTypeTextField.delegate=self;
    
   // self.edgesForExtendedLayout=UIRectEdgeNone;
    self.headView.hidden=YES;
    self.dataSource=[NSMutableArray new];
    self.communityList=[NSMutableArray new];
    self.buildingList=[NSMutableArray new];
    
    _communityBtn.layer.masksToBounds = YES;
    _communityBtn.layer.cornerRadius = 5.0;
    _communityBtn.layer.borderColor = RGB(63, 114, 156).CGColor;
    _communityBtn.layer.borderWidth =1.0;
    
    _repairTypeBtn.layer.masksToBounds = YES;
    _repairTypeBtn.layer.cornerRadius = 5.0;
    _repairTypeBtn.layer.borderColor = RGB(63, 114, 156).CGColor;
    _repairTypeBtn.layer.borderWidth =1.0;
    
//    _chooseBuildingBtn.layer.masksToBounds = YES;
//    _chooseBuildingBtn.layer.cornerRadius = 5.0;
//    _chooseBuildingBtn.layer.borderColor = RGB(63, 114, 156).CGColor;
//    _chooseBuildingBtn.layer.borderWidth =1.0;
    
    
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=5.0;
    
    
//    _maintenanceTextView.placeHoldString=@"请输入报修内容";
//    _maintenanceTextView.layer.masksToBounds=YES;
//    _maintenanceTextView.layer.cornerRadius=7.0;
//    _maintenanceTextView.layer.borderWidth=0.5;
//    _maintenanceTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing=5;
    flowLayout.minimumInteritemSpacing=5;
    flowLayout.itemSize=CGSizeMake(74, 74);
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _maintenanceCollectionView.collectionViewLayout=flowLayout;
    _maintenanceCollectionView.delegate=self;
    _maintenanceCollectionView.dataSource=self;
    _maintenanceCollectionView.alwaysBounceVertical=YES;
//    _maintenanceCollectionView.layer.masksToBounds=YES;
//    _maintenanceCollectionView.layer.cornerRadius=7.0;
    
    _communityTitleLab.text=LocalizedString(@"string_repair_theme_title");
    _repairAddressTitleLab.text=LocalizedString(@"string_repair_address_title");
    
    [_recordBtn addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_recordBtn addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [_recordBtn addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    
    
    
    [self requestCommunityList];
    [self.maintenanceCollectionView reloadData];
   // [self.recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
   // [self.recordBtn setImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
    self.playViewHeight.constant=0;
    [self.progressView setProgress:0.0 animated:NO];
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
//    if (_communityLab.text.length ==0) {
//        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_community_title")];
//        return;
//    }
//    if (_communityBtn.titleLabel.text.length==0) {
//        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_theme_title")];
//        return;
//    }
//    if (_repairTypeBtn.titleLabel.text.length ==0) {
//        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_type_title")];
//        return;
//    }
    if (_repairTitleTextField.text.length==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_theme_title")];
        return;
    }
    
    if (_repairTypeTextField.text.length==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_type_title")];
        return;
    }
    
    if (_chooseBuildingBtn.titleLabel.text.length==0) {
                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_community_title")];
                return;
    }
    if (_addressTextField.text.length ==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_address_title")];
        return;
    }
    if (_dataSource.count ==0 || _dataSource ==nil || [_dataSource isKindOfClass:[NSNull class]]) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_photo_title")];
        return;
    }
    if (_maintenanceTextView.text.length ==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_repair_alert_describe_title")];
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
    NSMutableArray *mutArr=[NSMutableArray new];
    [mutArr addObject:picture];
    NSDictionary *para=@{
                         
                         @"complainLiaisonsEmail":[User shareUser].email,
                         @"complainLiaisonsName":[User shareUser].name,
                         @"complainLiaisonsSex":[User shareUser].sex,
                         @"complainPosition":_chooseBuildingBtn.titleLabel.text,
                         @"complainSpecificPosition":_addressTextField.text,
                         @"complainVoice":self.voiceRemarkUrl==nil?@"":self.voiceRemarkUrl,
                         @"complainDescribe":self.maintenanceTextView.text,
                         @"complainClassType":_repairTitleTextField.text,
                         @"complainType":_repairTypeTextField.text,
                         @"complainId":[User shareUser].communityId,
                         @"images":[NSArray arrayWithObjects:picture, nil]
//                         @"images":mutArr
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
        [CommonUtil isRequestOK:dicResult];
        int code=[[dicResult objectForKey:@"code"] intValue];
        if (code !=200) {
            return ;
        }
        _reportMaintenance=[ReportMaintenanceDetail mj_setKeyValues:dicResult[@"data"]];
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:LocalizedString(@"string_add_maintenance_title") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAc=[UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:alertAc];
        [self presentViewController:alert animated:YES completion:nil];
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

- (void)requestBuildingList {
    [self.buildingList removeAllObjects];
    [[WebAPIHelper sharedWebAPIHelper] postBuildingList:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *array=[dic objectForKey:@"list"];
        NSMutableArray *buildingArr=[NSMutableArray new];
        buildingArr=[BuildingModel mj_objectArrayWithKeyValuesArray:array];
        if (buildingArr.count==0) {
            return;
        }
        for (BuildingModel * model in buildingArr) {
            [self.buildingList addObject:model.buildingName];
        }
    }];
}


- (IBAction)chooseBuildingBtnAction:(id)sender {
    PickViewController *pickVC=[[PickViewController alloc] init];
    pickVC.dataSource=self.buildingList;
    pickVC.backBlock = ^(NSString *title){
        [self.chooseBuildingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.chooseBuildingBtn setTitle:title forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (IBAction)repairTypeBtnAction:(id)sender {
    PickViewController *pickVC=[[PickViewController alloc] init];
    pickVC.dataSource=@[@"土木工程",@"清潔",@"保安"];
    pickVC.backBlock = ^(NSString *title){
        [self.repairTypeBtn setTitle:title forState:UIControlStateNormal];
        
    };
    
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (IBAction)communityBtnAction:(id)sender {
//    self.communityMenu=[LSXPopMenu showRelyOnView:sender titles:self.communityList icons:nil menuWidth:200 isShowTriangle:YES delegate:self];
    PickViewController *pickVC=[[PickViewController alloc] init];
    pickVC.dataSource=@[@"供電系統",@"發動機"];
    pickVC.backBlock = ^(NSString *title){
        [self.communityBtn setTitle:title forState:UIControlStateNormal];
       
    };
    
    [self presentViewController:pickVC animated:YES completion:nil];
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
    if (_isNews) {
        return _dataSource.count;
    }else{
        return _dataSource.count+1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNews) {
        [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"PhotpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
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
        
        [_photoCell.activityIndicatorView startAnimating];
        _photoCell.deleteBtn.hidden=YES;
        
        [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:thumbnailUrlArr[indexPath.row]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:orignalUrlArr[indexPath.row]]] placeholderImage:image];
            _photoCell.deleteBtn.hidden=YES;
            [_photoCell.activityIndicatorView stopAnimating];
            _photoCell.activityIndicatorView.hidden=YES;
        }];
        return _photoCell;
    }else{
        if (indexPath.row ==0) {
            [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"AddCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AddCollectionViewCell"];
            _addCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddCollectionViewCell" forIndexPath:indexPath];
            return _addCell;
        }else{
            //        [self.maintenanceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
            [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"PhotpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
            
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
            
            [_photoCell.activityIndicatorView startAnimating];
            [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:thumbnailUrlArr[indexPath.row-1]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [_photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:orignalUrlArr[indexPath.row-1]]] placeholderImage:image];
                _photoCell.deleteBtn.hidden=NO;
                [_photoCell.activityIndicatorView stopAnimating];
                _photoCell.activityIndicatorView.hidden=YES;
            }];
            _photoCell.deleteBtnAction = ^{
                NSLog(@"%ld",_dataSource.count);
                PictureModel *model = [_dataSource objectAtIndex:indexPath.row-1];
                [self deleteFileUrl:model.originalUrl];
                [_dataSource removeObjectAtIndex:indexPath.row-1];
                [collectionView reloadData];
            };
            
            return _photoCell;
        }
    }
    
    
    
    
    
    
    
   

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (!_isNews) {
        if (indexPath.row ==0) {
            
            [self showChangeAvatarAlert];
        }
    }
}


- (void)showChangeAvatarAlert {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAc1 = [UIAlertAction actionWithTitle:LocalizedString(@"string_take_album") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        PHAuthorizationStatus status=[PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
            NSLog(@"没有权限");
            [ZKAlertTool showAlertWithMsg:@"请您在设置中设置允许应用访问您的相册"];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
                
                NSLog(@"拿到相册");
            });
        }
//        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
    }];
    
    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:LocalizedString(@"string_take_photo") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
                    NSLog(@"正在访问相机");
                });
            }else{
                [ZKAlertTool showAlertWithMsg:@"请您在设置中设置允许应用访问您的相机"];
                NSLog(@"无权访问相机权限");
                
            }
        }];
        
//        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        
    }];
    UIAlertAction *alertAc3 = [UIAlertAction actionWithTitle:LocalizedString(@"String_cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
      //  self.maintenanceCollectionView.allowsSelection=YES;
    }];
    [alertC addAction:alertAc1];
    [alertC addAction:alertAc2];
    [alertC addAction:alertAc3];
    
    [self presentViewController:alertC animated:NO completion:nil];
  //  self.maintenanceCollectionView.allowsSelection=NO;
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
//    self.maintenanceCollectionView.allowsSelection=NO;
    [SVProgressHUD show];
    NSDictionary *dic=@{
                        @"type":@(0)
                        };
    [[HttpHelper shareHttpHelper] postUploadImagesWithUrl:kUploadImg parameters:dic images:[NSArray arrayWithObject:[UIImage imageWithData:data]] completion:^(NSDictionary * info){
        if ([CommonUtil isRequestOK:info]) {
            [SVProgressHUD dismiss];
            if ([[info allKeys]containsObject:@"data"]) {
                NSDictionary *dic=[info objectForKey:@"data"];
                 PictureModel *picture=[PictureModel mj_objectWithKeyValues:dic];
                if (picture.originalUrl!=nil) {
                    [ZKAlertTool showAlertWithMsg:@"上传成功"];
                   // [_dataSource addObject:picture.originalUrl];
                    [_dataSource addObject:picture];
                    [self.maintenanceCollectionView reloadData];
//                    self.maintenanceCollectionView.allowsSelection=YES;
                }
                
            }
           // [User shareUser].portrait=[info objectForKey:@"data"];
            
        }
    }];
    
}

- (IBAction)startRecordAction:(id)sender {
    [self startRecord];
}


- (void)cancelRecordVoice:(UIButton *)button
{
    if (_timer) {
        [_recorder stop];
        [_recorder deleteRecording];
        [_timer invalidate];
        _timer = nil;
    }
    [UUProgressHUD dismissWithError: LocalizedString(@"String_cancel")];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:LocalizedString(@"String_release_to_cancel")];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:LocalizedString(@"String_slide_up_to_cancel")];
}


- (IBAction)stopRecordAction:(id)sender {
    [self stopRecord];
     [UUProgressHUD dismissWithSuccess:@"Success"];
}

- (IBAction)playBtnAction:(id)sender {
//    if (self.player.rate != 0) {
//        [self.player pause];
//        return;
//    }
//
//    if (self.recordPath != nil) {
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:self.recordPath]];
//        // 播放当前资源
//        [self.player replaceCurrentItemWithPlayerItem:playerItem];
//
//    } else {
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:self.voiceRemarkUrl]]];
//       //  播放当前资源
//        [self.player replaceCurrentItemWithPlayerItem:playerItem];
//    }
//
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
        
                AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:self.voiceRemarkUrl]]];
        
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://songsong.fun:8080/file/app/videos/1551085873015.wav"]];
        //         playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,self.voiceRemarkUrl]]];
        
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
        //观察Status属性，可以在加载成功之后得到视频的长度
        [SVProgressHUD show];
        [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    
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
                [SVProgressHUD dismiss];
                [self.playBtn setTitle:@"点击停止播放" forState:UIControlStateNormal];
                //获取视频长度
                CMTime duration = playerItem.asset.duration;
                //更新显示:视频总时长(自定义方法显示时间的格式)
                float totalTime   = CMTimeGetSeconds(duration);
                //                int totalTime = CMTimeGetSeconds(duration);
                NSLog(@"录制时间：%f",totalTime);
                //   self.totalNeedPlayTimeLabel.text = [self formatTimeWithTimeInterVal:CMTimeGetSeconds(duration)];
                //开启滑块的滑动功能
                //   self.sliderView.enabled = YES;
                //关闭加载Loading提示
                //    [self showaAtivityInDicatorView:NO];
                //开始播放视频
                // [self.player.currentItem currentTime];
                [self.player play];
                //                __weak typeof(self)WeakSelf = self;
                //                __strong typeof(WeakSelf) strongSelf = WeakSelf;
                [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time){
                    // times++;
                    //                            self.progressView.progress =times/playTime;
                    //                            NSLog(@"当前播放时间：%ld",times);
                    //    NSInteger currentTime=playerItem.currentTime.value/playerItem.currentTime.timescale%60;
                    //                    float currentTime=playerItem.currentTime.value/playerItem.currentTime.timescale;
                    //                            self.progressView.progress =currentTime/totalTime;
                    float currentTime=CMTimeGetSeconds(self.player.currentItem.currentTime);
                    self.progressView.progress =currentTime/totalTime;
                    if (self.progressView.progress ==1.0f) {
                        
                        [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
                        //[self.progressView setProgress:0.0 animated:NO];
                    }
                    NSLog(@"当前播放时间：%f",currentTime);
                }];
                break;
            }
            case AVPlayerStatusFailed:{//视频加载失败，点击重新加载
                //     [self showaAtivityInDicatorView:NO];//关闭Loading视图
                //      self.playerInfoButton.hidden = NO; //显示错误提示按钮，点击后重新加载视频
                //      [self.playerInfoButton setTitle:@"资源加载失败，点击继续尝试加载" forState: UIControlStateNormal];
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
    }else if ([keyPath isEqualToString:@"contentSize"]) {
        
        self.scrollView.frame=CGRectMake(0, 0, ScreenWidth,  scrollerHeight);
        
        
    }
}

- (void)dealloc
{
   // [self.player removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
   // [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"status"];
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
      [UUProgressHUD show];
    
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
    [SVProgressHUD show];
    NSDictionary *dic=@{
                        @"type":@(2)
                        };
    [[WebAPIHelper sharedWebAPIHelper] uploadVoice:dic filePath:self.recordPath completion:^(NSDictionary *resultDic){
        [SVProgressHUD dismiss];
        self.voiceRemarkUrl=[resultDic objectForKey:@"originalUrl"];
        NSLog(@"%@",self.voiceRemarkUrl);
        self.recordBtnHeight.constant=0;
        self.recordBtn.hidden=YES;
        self.playViewHeight.constant=30;
        [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }];
//    self.recordBtnHeight.constant=0;
//    self.recordBtn.hidden=YES;
//    self.playViewHeight.constant=30;
//    [self.playBtn setTitle:@"点击开始播放" forState:UIControlStateNormal];
//    [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
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
    [self deleteFileUrl:self.voiceRemarkUrl];
    self.voiceRemarkUrl=@"";
   // self.playBtn.hidden=YES;
   // self.deleteBtn.hidden=YES;
    self.playViewHeight.constant=0;
    self.recordBtnHeight.constant=30;
    self.playBtn.hidden=YES;
    self.deleteBtn.hidden=YES;
    self.recordBtn.hidden=NO;
    self.progressView.progress=0.0;
}
- (IBAction)submitAction:(id)sender {
    [self requestAddRepair];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
//    if (![self login]) {
//        return;
//    }
    [self checkLogin];

    
    
    
    if (_isNews) {
        self.playBtn.hidden=YES;
        self.scrollView.scrollEnabled=YES;
        self.maintenanceCollectionView.scrollEnabled=NO;
        [self requestComplain];
        [_maintenanceCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    }else{
        self.playBtn.hidden=YES;
        self.scrollView.scrollEnabled=NO;
        self.maintenanceCollectionView.scrollEnabled=YES;
        [self requestBuildingList];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_addressTextField resignFirstResponder];
    [_repairTypeTextField resignFirstResponder];
    [_repairTitleTextField resignFirstResponder];
    [_maintenanceTextView resignFirstResponder];
}
#pragma mark UITextField-Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//- (void)viewDidDisappear:(BOOL)animated{
//
//    [self.communityBtn setTitle:@"" forState:UIControlStateNormal];
//    self.addressTextField.text=@"";
//    self.maintenanceTextView.text=@"";
//    self.voiceRemarkUrl=@"";
//}
- (void)deleteFileUrl:(NSString *)str{
    [SVProgressHUD show];
    NSDictionary *dic=@{
                        @"path":str
                        };
    [[HttpHelper shareHttpHelper] deleteFileWithURL:deleteFile parameters:dic filePath:nil success:^(NSDictionary *info){
//        if (info==nil) {
//            return;
//        }
        [SVProgressHUD dismiss];
    } failure:^(NSError * error){
        NSLog(@"%@",error);
    }];
}





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
        
        _chooseBuildingBtn.enabled=NO;
        _repairTitleTextField.enabled=NO;
        _repairTypeTextField.enabled=NO;
        _addressTextField.enabled=NO;
        [_maintenanceTextView setEditable:NO];
        self.recordBtn.hidden=YES;
        self.deleteBtn.hidden=YES;
        self.submitBtn.hidden=YES;
        if (_complain.complainVoice.length ==0 || _complain.complainVoice ==nil) {
            self.playBtn.hidden=YES;
        }else{
            _voiceRemarkUrl=_complain.complainVoice;
            self.playBtn.hidden=NO;
        }
        
        
        
        
        [_chooseBuildingBtn setTitle:_complain.complainPosition forState:UIControlStateNormal];
        _repairTitleTextField.text=_complain.complainClassType;
        _repairTypeTextField.text=_complain.complainType;
        _addressTextField.text=_complain.complainSpecificPosition;
        
        if (_complain.complainVoice.length ==0 || _complain.complainVoice==nil) {
            self.playBtn.hidden=YES;
        }
        _maintenanceTextView.text=_complain.complainDescribe;
         _dataSource=[_complain.images mutableCopy];
        if (_dataSource.count%3 !=0) {
            _collectionViewHeight.constant=(_dataSource.count/3+1)*90;
        }else{       
            _collectionViewHeight.constant=(_dataSource.count/3)*90;
        }
        scrollerHeight=scrollerHeight+_collectionViewHeight.constant;
        [self.maintenanceCollectionView reloadData];
        
        
//        if ([_complain.createTime rangeOfString:@"T"].location !=NSNotFound) {
//            _timeStr=[_complain.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//        }else{
//            _timeStr=_complain.createTime;
//        }
//        
//        if (_timeStr.length !=0) {
//            _timeStr=[_timeStr substringToIndex:16];
//        }
        
//        _titleLab.text=_complain.complainClassType;
//        _positionLab.text=[NSString stringWithFormat:@"%@,%@",_complain.complainPosition,_complain.complainSpecificPosition];
//        //  _handlerNameLab.text=_complain.complainHandler;
//        _nameLab.text=_complain.complainLiaisonsName;
//        _contactWayLab.text=_complain.complainLiaisonsEmail;
//        //          _contactWayLab.text=@"asssssddfggfhrd官方的客戶";
//        //  _createTimeLab.text=_complain.createTime;
//        _createTimeLab.text=_timeStr;
//        _characterDescriptionLab.text=_complain.complainDescribe;
//
//        if (_complain.complainVoice.length ==0 || _complain.complainVoice ==nil) {
//            // self.playBtn.hidden=YES;
//            self.playBtn.backgroundColor=[UIColor clearColor];
//            self.playBtn.enabled=NO;
//            [self.playBtn setTitle:@"无录音" forState:UIControlStateNormal];
//            // [self.playBtn.titleLabel setTextColor:RGB(63, 114, 156)];
//            [self.playBtn setTitleColor:RGB(63, 114, 156) forState:UIControlStateNormal];
//            [self.playBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -80, 0, ScreenWidth/2)];
//            [self.playBtn setImage:nil forState:UIControlStateNormal];
//            self.progressView.hidden=YES;
//        }
//        _voiceURL=_complain.complainVoice;
//        _statusLab.text=_statusArr[[_complain.complainStatus intValue]];
//
//        _dataSource=[_complain.images mutableCopy];
//        //_dataSource%3*90
//
//        // _collectionHeight.constant=_dataSource.count/3*90;
//        if (_dataSource.count%3 !=0) {
//            _collectionHeight.constant=(_dataSource.count/3+1)*90;
//        }else{
//            _collectionHeight.constant=(_dataSource.count/3)*90;
//        }
//        scrollerHeight=scrollerHeight+_collectionHeight.constant;
//        //   self.scrollView.frame=CGRectMake(0, 0, ScreenWidth, scrollerHeight+_collectionHeight.constant);
//        // [self creatView];
//        [self.imageCollectionView reloadData];
       
        
        
    }];
}

@end
