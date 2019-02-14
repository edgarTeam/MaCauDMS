//
//  LanguageSettingViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/27.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "LanguageSettingViewController.h"
#import "MainViewController.h"
#import "ZKAlertTool.h"
#import "DrawerViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
@interface LanguageSettingViewController ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;
@property (nonatomic,strong) UINavigationController *centerNvaVC;
@property (nonatomic,strong) UINavigationController *leftNvaVC;
@end

@implementation LanguageSettingViewController
{
    NSInteger selectedLanguage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"語言設定";
    self.title=LocalizedString(@"string_language_setting_title");

    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    
    if ([lang isEqualToString:@"zh-Hant"]) {
        [self selectedLanguageOfIndex:0];
    }else if ([lang isEqualToString:@"zh-Hans"]){
        [self selectedLanguageOfIndex:1];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)chooseBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:{
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:AppLanguage];
            [self selectedLanguageOfIndex:sender.tag];
        }
            break;
        case 1:{
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppLanguage];
            [self selectedLanguageOfIndex:sender.tag];
        }
            break;
        default:
            break;
    }
}

- (void)selectedLanguageOfIndex:(NSInteger)tag {
    selectedLanguage=tag;
    for (UIImageView *view in _imageArray) {
        if (view.tag == selectedLanguage) {
            view.hidden =NO;
        }else{
            view.hidden =YES;
        }
    }
}

- (IBAction)confirmBtnAction:(UIButton *)sender {
    switch (selectedLanguage) {
        case 0:
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"appLanguage"];
            }
            break;
        case 1:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
//        MainViewController *mainVC=[[MainViewController alloc] init];
//        self.mm_drawerController.centerViewController=mainVC;
//        [UIApplication sharedApplication].keyWindow.rootViewController =self.mm_drawerController.centerViewController;
      //  [UIApplication sharedApplication].keyWindow.rootViewController = [[MainViewController alloc] init];
        MainViewController *mainVC=[[MainViewController alloc] init];
        LeftViewController *leftVC=[[LeftViewController alloc] init];
        _centerNvaVC= [[UINavigationController alloc]initWithRootViewController:mainVC];
        _leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
        DrawerViewController *drawer = [[MMDrawerController alloc]initWithCenterViewController:_centerNvaVC leftDrawerViewController:_leftNvaVC];
        drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        drawer.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
        drawer.maximumLeftDrawerWidth = ScreenWidth/2;
        drawer.maximumRightDrawerWidth = ScreenWidth/2;
       // DrawerViewController *drawer=[[DrawerViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController =drawer;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"String_Alert_title")];
    });
}

@end
