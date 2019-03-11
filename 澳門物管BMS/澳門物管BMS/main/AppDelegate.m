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
#import "DrawerViewController.h"


#import "SuspendView.h"
#import "NoticeDetailViewController.h"
#import "PlaceViewController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "BaseNavigationViewController.h"

#endif

@interface AppDelegate ()<SuspensionMenuDelegate,JPUSHRegisterDelegate,SuspendViewDelegate>
//@property(nonatomic,strong)MMDrawerController *drawer;
@property (nonatomic,strong) DrawerViewController *drawer;
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong)  UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) BOOL show;
@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) BaseNavigationViewController *centerNvaVC;
@property (nonatomic,strong) BaseNavigationViewController *leftNvaVC;
@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) NSMutableArray *labelNameArr;

@property (nonatomic,strong) ComplainViewController *complainVC;
@property (nonatomic,strong) ClubhouseReservationViewController *clubVC;
@property (nonatomic,strong) ReportMaintenanceViewController *reportVC;
@property (nonatomic,strong) SettingViewController *setVC;
@property (nonatomic, strong) NSArray *menuArray;
//@property (nonatomic, strong) SuspensionMenu *suspensionMenu;
@property (nonatomic ,strong) SuspendView *suspensionMenu;
@end

@implementation AppDelegate
{

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   // [self openTouchOutsideDismissKeyboard];
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
//    if (launchOptions) {
//        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
//        if (remoteNotification) {
//            NSLog(@"推送消息==== %@",remoteNotification);
//            [self goToMssageViewControllerWith:remoteNotification];
//        }
//    }

    
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSSet *set = [[NSSet alloc]initWithObjects:@"iosdevice", nil];
    [JPUSHService addTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:0] ;
    
//    if (launchOptions) {
//        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
//        if (remoteNotification) {
//            NSLog(@"推送消息==== %@",remoteNotification);
//            [self goToMssageViewControllerWith:remoteNotification];
//        }
//    }
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    _complainVC=[[ComplainViewController alloc] init];
    _centerNvaVC= [[BaseNavigationViewController alloc]init];
    self.window.rootViewController=_centerNvaVC;
    MainViewController *mainVC=[[MainViewController alloc] init];
    [_centerNvaVC pushViewController:mainVC animated:YES];
    
    self.suspensionMenu = [[SuspendView alloc] initWithCenterImage:[UIImage imageNamed:@"home"] menuData:self.menuArray];
    self.suspensionMenu.delegate = self;

    
    [self.window.rootViewController.view  addSubview:_suspensionMenu];
    [self.window.rootViewController.view bringSubviewToFront:_suspensionMenu];
    [self.window makeKeyAndVisible];
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    [application setApplicationIconBadgeNumber:0];   //清除角标
//    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  //  [[UpdateHelper shareUpdateHelper] checkUpdateInfo];
    //[[UpdateHelper shareUpdateHelper] checkUpdateInfo];
    [CommonUtil loadDefuatUser];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
                 [self goToMssageViewControllerWith:userInfo];
                
            }else{
                NSLog(@"%ld", (long)[UIApplication sharedApplication].applicationState);
            }
           
            
        }
    } else {
        // Fallback on earlier versions
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
        {
            PlaceViewController * placeVC =  [PlaceViewController new];
            [_centerNvaVC pushViewController:placeVC animated:YES];
        }
//            _clubVC=[[ClubhouseReservationViewController alloc] init];
//        [_centerNvaVC pushViewController:_clubVC animated:YES];
        
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



- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push"forKey:@"push"];
    [pushJudge synchronize];
//    NSString * targetStr = [msgDic objectForKey:@"target"];
//    NSDictionary *extra = [msgDic objectForKey:@"extras"];
    NSString *noticeId=[msgDic objectForKey:@"noticeId"];
    if (noticeId) {
        NoticeDetailViewController *noticeVC=[NoticeDetailViewController new];
        noticeVC.noticeId=noticeId;
      //  MessageVC * VC = [[MessageVC alloc]init];
        UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:noticeVC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
        
    }
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    [self goToMssageViewControllerWith:userInfo];
    //服务端传递的 Extras 附加字段，key 是自己定义的
}
@end
