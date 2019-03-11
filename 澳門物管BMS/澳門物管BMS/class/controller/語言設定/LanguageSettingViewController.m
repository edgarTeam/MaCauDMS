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
#import "BaseNavigationViewController.h"
#import "SuspensionMenu.h"
#import "SuspensionModel.h"
#import "ComplainViewController.h"
#import "ClubhouseReservationViewController.h"
#import "ReportMaintenanceViewController.h"
#import "SettingViewController.h"
#import "SuspendView.h"
#import "PlaceViewController.h"
@interface LanguageSettingViewController ()<SuspensionMenuDelegate>
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;
@property (nonatomic,strong) BaseNavigationViewController *centerNvaVC;
@property (nonatomic,strong) BaseNavigationViewController *leftNvaVC;

@property (nonatomic,strong) ComplainViewController *complainVC;
@property (nonatomic,strong) ClubhouseReservationViewController *clubVC;
@property (nonatomic,strong) ReportMaintenanceViewController *reportVC;
@property (nonatomic,strong) SettingViewController *setVC;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) SuspendView *suspensionMenu;

@property (weak, nonatomic) IBOutlet UILabel *CNTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *CTTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *ENTitleLab;


@end

@implementation LanguageSettingViewController
{
    NSInteger selectedLanguage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"語言設定";
   // self.title=LocalizedString(@"string_language_setting_title");
    self.baseTitleLab.text=LocalizedString(@"string_language_setting_title");
    _CNTitleLab.font=[UIFont systemFontOfSize:16];
    _CTTitleLab.font=[UIFont systemFontOfSize:16];
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _ENTitleLab.font=[UIFont systemFontOfSize:16];
    
    NSString *lang = [[NSUserDefaults standardUserDefaults]  objectForKey:@"appLanguage"];
    
    if ([lang isEqualToString:@"zh-Hant"]) {
        [self selectedLanguageOfIndex:0];
    }else if ([lang isEqualToString:@"zh-Hans"]){
        [self selectedLanguageOfIndex:1];
    }else if ([lang isEqualToString:@"en"]){
        [self selectedLanguageOfIndex:2];
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
        case 2:{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppLanguage];
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
        case 2:
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{

        MainViewController *mainVC=[[MainViewController alloc] init];
        LeftViewController *leftVC=[[LeftViewController alloc] init];
        _centerNvaVC= [[BaseNavigationViewController alloc]initWithRootViewController:mainVC];
//        _leftNvaVC = [[BaseNavigationViewController alloc]initWithRootViewController:leftVC];
//        DrawerViewController *drawer = [[DrawerViewController alloc]initWithCenterViewController:_centerNvaVC leftDrawerViewController:_leftNvaVC];
//        drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
//        drawer.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
//        drawer.maximumLeftDrawerWidth = ScreenWidth/2;
//        drawer.maximumRightDrawerWidth = ScreenWidth/2;
        self.suspensionMenu = [[SuspendView alloc] initWithCenterImage:[UIImage imageNamed:@"home"] menuData:self.menuArray];
        self.suspensionMenu.delegate = self;
        [UIApplication sharedApplication].keyWindow.rootViewController =_centerNvaVC;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_suspensionMenu];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view bringSubviewToFront:_suspensionMenu];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"String_Alert_title")];
    });
}
#pragma suspensionDelegate

-(void)selectMenuAtIndex:(NSInteger)index{
    _reportVC=[[ReportMaintenanceViewController alloc] init];
    switch (index) {
        case 3:
            
            
            //            if (![baseVC login]) {
            ////                [_reportVC setTitle:@"投訴"];
            ////                [_centerNvaVC pushViewController:_reportVC animated:YES];
            //                return;
            //            }
            
        {
            [_reportVC setTitle:LocalizedString(@"string_complain_title")];
            [_centerNvaVC pushViewController:_reportVC animated:YES];
        }
            break;
        case 1:
            //            if (![baseVC login]) {
            ////            [_centerNvaVC pushViewController:_clubVC animated:YES];
            //                return;
            //            }
//            _clubVC=[[ClubhouseReservationViewController alloc] init];
//            [_centerNvaVC pushViewController:_clubVC animated:YES];
        {
            PlaceViewController *placeVC=[PlaceViewController new];
            [_centerNvaVC pushViewController:placeVC animated:YES];
        }
            break;
        case 2:
            //            if (![baseVC login]) {
            ////            [_reportVC setTitle:@"報事維修"];
            ////            [_centerNvaVC pushViewController:_reportVC animated:YES];
            //                return;
            //            }
            // _reportVC=[[ReportMaintenanceViewController alloc] init];
        {
            [_reportVC setTitle:LocalizedString(@"string_report_maintenance_title")];
            [_centerNvaVC pushViewController:_reportVC animated:YES];
        }
            break;
        case 0:
            //            if (![baseVC login]) {
            ////            [_centerNvaVC pushViewController:_setVC animated:YES];
            //                return;
            //            }
        {
            _setVC=[[SettingViewController alloc] init];
            [_centerNvaVC pushViewController:_setVC animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma getter

-(NSArray *)menuArray{
    if (!_menuArray) {
        SuspensionModel *setting = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_set_title") image:@"setting"];
        SuspensionModel *place = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_reservation_place_title") image:@"place"];
        SuspensionModel *repairsec = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_report_maintenance_title") image:@"repair"];
        SuspensionModel *complain = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_complain_title") image:@"complain"];
        _menuArray = [NSArray arrayWithObjects:setting,place,repairsec,complain, nil];
    }
    return _menuArray;
}
@end
