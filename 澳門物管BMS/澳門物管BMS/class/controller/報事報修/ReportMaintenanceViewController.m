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
@interface ReportMaintenanceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *maintenanceTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *maintenanceCollectionView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) AddCollectionViewCell *addCell;
@end

@implementation ReportMaintenanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"報事維修";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.headView.hidden=YES;
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        AddCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else{
//        [self.maintenanceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
        [self.maintenanceCollectionView registerNib:[UINib nibWithNibName:@"PhotpCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PhotpCollectionViewCell"];
        PhotpCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotpCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        
    
    self.maintenanceCollectionView = collectionView;
    
   // self.addCell = [collectionView cellForItemAtIndexPath:indexPath];
    UIAlertControllerStyle style = UIAlertControllerStyleActionSheet;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        style = UIAlertControllerStyleAlert;
    }
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
    UIAlertAction *alertAc1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary andCameraCaptureMode:UIImagePickerControllerCameraCaptureModeVideo];
    }];
        
    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera andCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        }];
        
//    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍照", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            PureCamera *homec = [[PureCamera alloc] init];
//            @weakify(self);
//            homec.fininshcapture = ^(UIImage *ss) {
//                if (ss) {
//                    [weak_self addImageToData:ss];
//                }
//            };
//            [self presentViewController:homec
//                               animated:NO
//                             completion:^{
//                             }];
//        } else {
//            NSLog(@"相机调用失败");
//        }
//
//
//    }];
    UIAlertAction *alertAc3 = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:alertAc1];
    [alertC addAction:alertAc2];
    [alertC addAction:alertAc3];
    
    [self presentViewController:alertC animated:NO completion:nil];
}
}


#pragma -mark- UIImagePickerController

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType andCameraCaptureMode:(UIImagePickerControllerCameraCaptureMode)mode{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //有相机
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //这是 VC 的各种 modal 形式
        //imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        imagePickerController.sourceType = sourceType;
        //支持的摄制类型,拍照或摄影,此处将本设备支持的所有类型全部获取,并且同时赋值给imagePickerController的话,则可左右切换摄制模式
    //    imagePickerController.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePickerController.delegate = self;
        //允许拍照后编辑
        imagePickerController.allowsEditing = NO;
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
            //UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
            
            UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
 
            
//            TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:original];
//            cropController.delegate = self;
//            [self presentViewController:cropController animated:YES completion:nil];
            
            
            
        }else{  // public.movie
            
        }
        
    }];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
@end
