//
//  AppDelegate.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/12.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import <Masonry/Masonry.h>
#import "ComplainViewController.h"
#import "ClubhouseReservationViewController.h"
#import "ReportMaintenanceViewController.h"
#import "SettingViewController.h"
#import "BaseViewController.h"
#import "UpdateHelper.h"
#import "SuspensionModel.h"
#import "SuspensionMenu.h"
#import "JPUSHService.h"
#import "AppDelegate+DismissKeyboard.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<SuspensionMenuDelegate,JPUSHRegisterDelegate>
@property(nonatomic,strong)MMDrawerController *drawer;
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong)  UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) BOOL show;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) UINavigationController *centerNvaVC;
@property (nonatomic,strong) UINavigationController *leftNvaVC;
@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) NSMutableArray *labelNameArr;

@property (nonatomic,strong) ComplainViewController *complainVC;
@property (nonatomic,strong) ClubhouseReservationViewController *clubVC;
@property (nonatomic,strong) ReportMaintenanceViewController *reportVC;
@property (nonatomic,strong) SettingViewController *setVC;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) SuspensionMenu *suspensionMenu;

@end

@implementation AppDelegate
{

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self openTouchOutsideDismissKeyboard];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSSet *set = [[NSSet alloc]initWithObjects:@"iosdevice", nil];
    [JPUSHService addTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0] ;
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKEY
                          channel:@"app store"
                 apsForProduction:0
            advertisingIdentifier:@""];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationId"];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]) {

        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant"  forKey:AppLanguage];
    }
    _complainVC=[[ComplainViewController alloc] init];
    _clubVC=[[ClubhouseReservationViewController alloc] init];
//    _reportVC=[[ReportMaintenanceViewController alloc] init];
    _setVC=[[SettingViewController alloc] init];
    MainViewController *mainVC=[[MainViewController alloc] init];
    LeftViewController *leftVC=[[LeftViewController alloc] init];
    _centerNvaVC= [[UINavigationController alloc]initWithRootViewController:mainVC];
    _leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
     self.drawer = [[MMDrawerController alloc]initWithCenterViewController:_centerNvaVC leftDrawerViewController:_leftNvaVC];
    self.drawer.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawer.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    self.drawer.maximumLeftDrawerWidth = ScreenWidth/2;
    self.drawer.maximumRightDrawerWidth = ScreenWidth/2;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawer];
    
    self.suspensionMenu = [[SuspensionMenu alloc] initWithCenterImage:[UIImage imageNamed:@"home"] menuData:self.menuArray];
    self.suspensionMenu.delegate = self;
    
//    _suspensionView=[[SuspensionView alloc] init];
//    [_suspensionView.button1 addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
    //_suspensionView.userInteractionEnabled=NO;
    
//    _suspensionView=[[SuspensionView alloc] init];
//    [self.drawer.view addSubview:_suspensionView];
    
    [self.window.rootViewController.view  addSubview:_suspensionMenu];
    [self.window.rootViewController.view bringSubviewToFront:_suspensionMenu];
    [self.window makeKeyAndVisible];
//    self.centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight-60, 50, 50);
//    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight/2, 50, 50);
//    [self.centerBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
//    self.centerBtn.layer.cornerRadius=self.centerBtn.frame.size.width/2;
//    self.centerBtn.layer.cornerRadius=25;
//    self.centerBtn.layer.masksToBounds=YES;
//    self.centerBtn.layer.borderWidth=0.5;
//    self.centerBtn.layer.borderColor=RGB(138, 138, 138).CGColor;
//    [self.centerBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.window.rootViewController.view addSubview:self.centerBtn];
//    [self.drawer.view addSubview:self.centerBtn];
//    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]

//                             initWithTarget:self
//
//                             action:@selector(handlePan:)];
//
//    [self.centerBtn addGestureRecognizer:_panGestureRecognizer];
//    [self.centerBtn addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [JPUSHService setBadge:0];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  //  [[UpdateHelper shareUpdateHelper] checkUpdateInfo];
    //[[UpdateHelper shareUpdateHelper] checkUpdateInfo];
    [CommonUtil loadDefuatUser];
    [JPUSHService setBadge:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
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
           
        [_reportVC setTitle:LocalizedString(@"string_complain_title")];
        [_centerNvaVC pushViewController:_reportVC animated:YES];
        break;
    case 1:
        //            if (![baseVC login]) {
        ////            [_centerNvaVC pushViewController:_clubVC animated:YES];
        //                return;
        //            }
        [_centerNvaVC pushViewController:_clubVC animated:YES];
        
        break;
    case 2:
        //            if (![baseVC login]) {
        ////            [_reportVC setTitle:@"報事維修"];
        ////            [_centerNvaVC pushViewController:_reportVC animated:YES];
        //                return;
        //            }
          // _reportVC=[[ReportMaintenanceViewController alloc] init];
        [_reportVC setTitle:LocalizedString(@"string_report_maintenance_title")];
        [_centerNvaVC pushViewController:_reportVC animated:YES];
        break;
    case 0:
        //            if (![baseVC login]) {
        ////            [_centerNvaVC pushViewController:_setVC animated:YES];
        //                return;
        //            }
        [_centerNvaVC pushViewController:_setVC animated:YES];
        break;
    default:
        break;
    }
}


#pragma getter

-(NSArray *)menuArray{
    if (!_menuArray) {
        SuspensionModel *setting = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_set_title") image:@"settingsec"];
           SuspensionModel *place = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_reservation_place_title") image:@"place"];
           SuspensionModel *repairsec = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_report_maintenance_title") image:@"repairsec"];
           SuspensionModel *complain = [[SuspensionModel alloc] initWithName:LocalizedString(@"string_complain_title") image:@"complain"];
        _menuArray = [NSArray arrayWithObjects:setting,place,repairsec,complain, nil];
    }
    return _menuArray;
}
@end
