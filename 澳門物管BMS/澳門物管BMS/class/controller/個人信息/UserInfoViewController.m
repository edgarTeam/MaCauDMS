//
//  UserInfoViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/1.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "UserInfoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WebAPIHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "User.h"
#import "HttpHelper.h"
#import "CommonUtil.h"
#import "ZKAlertTool.h"
@interface UserInfoViewController ()<UIImagePickerControllerDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField; //姓名
@property (weak, nonatomic) IBOutlet UILabel *sexLab; //性别
//@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UITextField *telTextField; //联系方式
@property (weak, nonatomic) IBOutlet UIImageView *headImage; //头像
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;//头像按钮
@property (weak, nonatomic) IBOutlet UIButton *changeSexBtn; //性别按钮
//@property (weak, nonatomic) IBOutlet UIButton *changeTelBtn;
@property (assign,nonatomic) NSInteger sexId; //性别index
@property (nonatomic,strong) UIButton *rightBtn; //修改按钮
@property (weak, nonatomic) IBOutlet UIButton *submitBtn; //提交按钮（点击修改才会出现，提交完成后消失）
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=LocalizedString(@"String_info_title");
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40) ];
    [self.rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.rightBtn.hidden=NO;
    //[self.btn.titleLabel setTextColor:RGB(77, 77, 77)];
    [self.rightBtn setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(changeBtnaction:) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:self.btn];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    
    self.headTitleLab.text=LocalizedString(@"String_head_title");
    self.nameTitleLab.text=LocalizedString(@"String_name_title");
    self.sexTitleLab.text=LocalizedString(@"String_sex_title");
    self.telTitleLab.text=LocalizedString(@"String_tel_title");
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //self.nameLab.text=[User shareUser].name;
    self.nameTextField.text=[User shareUser].name;
    if ([[User shareUser].sex integerValue]==0) {
        self.sexLab.text = LocalizedString(@"string_sex_female");
    }else if ([[User shareUser].sex integerValue] ==1){
        self.sexLab.text = LocalizedString(@"string_sex_male");
    }
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
  //  self.sexLab.text=[User shareUser].sex;
//    self.telLab.text=[NSString stringWithFormat:@"%@", [User shareUser].tel ];
    self.telTextField.text=[NSString stringWithFormat:@"%@", [User shareUser].tel ];
    self.nameTextField.textColor=RGB(130, 130, 130);
    self.sexLab.textColor=RGB(130, 130, 130);
    self.telTextField.textColor=RGB(130, 130, 130);
    self.changeBtn.enabled=NO;
    self.telTextField.enabled=NO;
    self.nameTextField.enabled=NO;
    self.changeSexBtn.enabled=NO;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,[User shareUser].portrait]];
    [self.headImage sd_setImageWithURL:url placeholderImage:kEMPTYIMG];
    
    
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=5.0;
    
    
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)requestUpload{
//
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
            self.headImage.image = edit;
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
                        @"type":@(1)
                        };
    [[HttpHelper shareHttpHelper] postUploadImagesWithUrl:kUploadImg parameters:dic images:[NSArray arrayWithObject:[UIImage imageWithData:data]] completion:^(NSDictionary * info){
        if ([CommonUtil isRequestOK:info]) {
            
            NSDictionary *dic = [info objectForKey:@"data"];
            NSString *path = [dic objectForKey:@"path"];
            if (path) {
                [[User shareUser] setPortrait:path];
            }
        }
    }];
    
}

- (void)changeBtnaction:(UIButton *)btn{
   
    self.submitBtn.hidden=NO;
     self.changeBtn.enabled=YES;
    self.changeSexBtn.enabled=YES;
    self.telTextField.enabled=YES;
    self.nameTextField.enabled=YES;
    
    self.nameTextField.textColor=RGB(230, 230, 230);
    self.sexLab.textColor=RGB(230, 230, 230);
    self.telTextField.textColor=RGB(230, 230, 230);
    self.rightBtn.hidden=YES;
 //   [ZKAlertTool showAlertWithMsg:@"您已经可以修改个人信息了"];
}
- (IBAction)submitBtnAction:(id)sender {
    [self requestChangeInfo];
}


- (void)requestChangeInfo {
    if(self.sexLab.text == LocalizedString(@"string_sex_female")){
        self.sexId=0;
    }else if(self.sexLab.text == LocalizedString(@"string_sex_male")){
        self.sexId=1;
    }
    NSDictionary *dic=@{
                        @"sex":@(self.sexId),
                        @"tel":self.telTextField.text,
                        @"name":self.nameTextField.text
                        };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    [[HttpHelper shareHttpHelper] postWithUrl:kUpdateInfo body:jsonData showLoading:YES success:^(NSDictionary *resultDic){
        [CommonUtil isRequestOK:resultDic];
        if (resultDic ==nil) {
            return ;
        }
      //  [CommonUtil clearDefuatUser];
        User *user=[User shareUser];
        if (dic) {
            if ([dic objectForKey:@"sex"]) {
                user.sex=[dic objectForKey:@"sex"];
                if ([[User shareUser].sex integerValue]==0) {
                    self.sexLab.text=LocalizedString(@"string_sex_female");
                }else if ([[User shareUser].sex integerValue]==1){
                    self.sexLab.text=LocalizedString(@"string_sex_male");
                }
            }
            if ([dic objectForKey:@"name"]) {
                user.name=[dic objectForKey:@"name"];
                self.nameTextField.text=[User shareUser].name;
            }
            if ([dic objectForKey:@"tel"]) {
                user.tel=[dic objectForKey:@"tel"];
                self.telTextField.text=[User shareUser].tel;
            }
            if ([dic objectForKey:@"portrait"]) {
                user.portrait=[dic objectForKey:@"portrait"];
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,[User shareUser].portrait]];
                [self.headImage sd_setImageWithURL:url placeholderImage:kEMPTYIMG];
            }
        }
        
        
//        user =  [User mj_objectWithKeyValues:[dic objectForKey:@"user"]];
//        [CommonUtil storeUser];
//        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_change_info_alert_title")];
//
//        self.submitBtn.hidden=YES;
//        self.telTextField.enabled=NO;
//        self.nameTextField.enabled=NO;
//        self.changeBtn.enabled=NO;
//        self.changeSexBtn.enabled=NO;
//        self.rightBtn.hidden=NO;
//        self.changeTelBtn.enabled=NO;
        //   _placeRecord=[PlaceRecord mj_objectWithKeyValues:resultDic[@"data"]];
    } failure:^(NSError *error){
        
    }];
}






- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeBtnAction:(id)sender {
    [self showChangeAvatarAlert];
}

- (IBAction)changeSexBtnAction:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAc1 = [UIAlertAction actionWithTitle:LocalizedString(@"string_sex_male") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sexLab.text=LocalizedString(@"string_sex_male");
        }];
    UIAlertAction *alertAc2 = [UIAlertAction actionWithTitle:LocalizedString(@"string_sex_female") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.sexLab.text=LocalizedString(@"string_sex_female");
    }];

    [alertC addAction:alertAc1];
    [alertC addAction:alertAc2];
    
    [self presentViewController:alertC animated:NO completion:nil];
    
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

@end
