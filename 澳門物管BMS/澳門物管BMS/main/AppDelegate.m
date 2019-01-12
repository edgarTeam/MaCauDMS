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
#import "SuspensionView.h"
@interface AppDelegate ()
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

@property (nonatomic,strong) SuspensionView *suspensionView;
@property (nonatomic,strong) ComplainViewController *complainVC;
@property (nonatomic,strong) ClubhouseReservationViewController *clubVC;
@property (nonatomic,strong) ReportMaintenanceViewController *reportVC;
@property (nonatomic,strong) SettingViewController *setVC;
@end

@implementation AppDelegate
{
    CGFloat theCenterX;
    CGFloat theCenterY;
    CGFloat centerX;
    CGFloat centerY;
    CGFloat radius;
    int a;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (![[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]) {

        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant"  forKey:AppLanguage];
    }
    _complainVC=[[ComplainViewController alloc] init];
    _clubVC=[[ClubhouseReservationViewController alloc] init];
    _reportVC=[[ReportMaintenanceViewController alloc] init];
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
//    _suspensionView=[[SuspensionView alloc] init];
//    [_suspensionView.button1 addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
//    //_suspensionView.userInteractionEnabled=NO;
    
//    _suspensionView=[[SuspensionView alloc] init];
//    [self.drawer.view addSubview:_suspensionView];
   
  //  [self.window.rootViewController.view addSubview:_suspensionView];
    [self.window makeKeyAndVisible];
    self.centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight-60, 50, 50);
    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight/2, 50, 50);
    [self.centerBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    self.centerBtn.layer.cornerRadius=self.centerBtn.frame.size.width/2;
    self.centerBtn.layer.cornerRadius=25;
    self.centerBtn.layer.masksToBounds=YES;
    self.centerBtn.layer.borderWidth=0.5;
    self.centerBtn.layer.borderColor=RGB(138, 138, 138).CGColor;
    [self.centerBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

   // [self.window.rootViewController.view addSubview:self.centerBtn];
    [self.drawer.view addSubview:self.centerBtn];
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc]

                             initWithTarget:self

                             action:@selector(handlePan:)];

    [self.centerBtn addGestureRecognizer:_panGestureRecognizer];
    [self.centerBtn addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    return YES;
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.window.rootViewController.view];
    centerX=recognizer.view.center.x+ translation.x;
    centerY=recognizer.view.center.y+ translation.y;
    theCenterX=centerX;
    theCenterY=centerY;
    // recognizer.view.center=CGPointMake(centerX,
    //                                       recognizer.view.center.y+ translation.y);
    recognizer.view.center=CGPointMake(centerX,centerY);
    [recognizer setTranslation:CGPointZero inView:self.window.rootViewController.view];
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        if(centerX>ScreenWidth/2) {
            theCenterX=ScreenWidth-50/2;
        }else{
            theCenterX=50/2;
        }
        if (centerY >ScreenHeight-40 ) {
            theCenterY=ScreenHeight-60;
        }else if(centerY <40){
            theCenterY=60;
        }
        [UIView animateWithDuration:0.3 animations:^{
            //            recognizer.view.center=CGPointMake(thecenter,
            //                                               recognizer.view.center.y+ translation.y);
            recognizer.view.center=CGPointMake(theCenterX,theCenterY);
        }];
    }
    
}

-(void)choose:(UIButton *)btn{
    if (self.centerBtn.selected) {
        self.show=NO;
    }else{
        self.show=YES;
    }
}

- (void)addBtn{
    radius=ScreenWidth/2-35-25-10;
    _btnArr=[NSMutableArray array];
    _labelArr=[NSMutableArray array];
//    self.arr=[NSMutableArray arrayWithObjects:@"bank",@"three",@"woker",@"tv",@"one",@"two",@"people",@"teacher",@"up",nil];
     self.arr=[NSMutableArray arrayWithObjects:@"complain",@"place",@"repairsec",@"settingsec",nil];
    int a=360/self.arr.count;
    self.labelNameArr=[NSMutableArray arrayWithObjects:@"投訴",@"會所預定",@"報事維修",@"設置", nil];
    
    
    for (int i = 0; i < self.arr.count; i++) {
//        _label=[[UILabel alloc] init];
//        _label.font=[UIFont systemFontOfSize:14.0];
//        _label.text=[self.labelNameArr objectAtIndex:i];
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.tag = i+1;
      //  _button1.layer.cornerRadius = 50/2;
      //  _button1.layer.masksToBounds = YES;
        _button1.userInteractionEnabled = YES;
        NSString *name=[self.arr objectAtIndex:i];
        [_button1 setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
         _button1.frame=CGRectMake(ScreenWidth/2-25, ScreenHeight/2-25, 50, 75);
         _button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_button1 setTitle:self.labelNameArr[i] forState:UIControlStateNormal];
        [_button1.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
       // [_button1.titleLabel setText:self.labelNameArr[i]];
        [_button1 setTitleEdgeInsets:UIEdgeInsetsMake(_button1.imageView.frame.size.height, -_button1.imageView.frame.size.width, 0, 0)];
        NSLog(@"值是：：：%f",(_button1.frame.size.height/2-_button1.imageView.frame.size.height/2));
        [_button1 setImageEdgeInsets:UIEdgeInsetsMake( -(_button1.frame.size.height/2-_button1.imageView.frame.size.height/2), 0, 0, -_button1.titleLabel.frame.size.width)];
        _button1.hidden=NO;
       
        
      //  _button1.backgroundColor=[UIColor blackColor];
        
        [_button1 addTarget:self action:@selector(handleClick:)forControlEvents:UIControlEventTouchUpInside];
//        [self.window addSubview:_label];
        [self.window addSubview:_button1];
        
        [UIView animateWithDuration:0.5 animations:^{
           
            CGFloat x=[UIScreen mainScreen].bounds.size.width/2-25+radius*cosf((_button1.tag-1)*a*3.1415926/180);
            CGFloat y=[UIScreen mainScreen].bounds.size.height/2-37+radius*sinf((_button1.tag-1)*a*3.1415926/180);
            _button1.frame=CGRectMake(x, y, 50, 75);
//            [_label mas_makeConstraints:^(MASConstraintMaker *make){
//                make.centerX.mas_equalTo(_button1);
//               make.top.mas_equalTo(_button1.mas_bottom).offset(5);
//            }];
        }completion:^(BOOL finish){

            self.centerBtn.userInteractionEnabled=YES;
        }];
        [_btnArr addObject:_button1];
//        [_labelArr addObject:_label];
        // NSLog(@"%ld",_btnArr.count);
    }
    NSLog(@"%ld",_btnArr.count);
}
- (void)setShow:(BOOL)show{
//     self.centerBtn.userInteractionEnabled=NO;
    _show=show;
    self.centerBtn.selected=show;
    
    
    NSLog(@"%ld",_btnArr.count);
    //   array=_btnArr;
    
    if (!show) {
        
        if(centerX>ScreenWidth/2) {
            theCenterX=ScreenWidth-50/2;
        }else{
            theCenterX=50/2;
        }
      
        if (centerY >ScreenHeight-40 ) {
            theCenterY=ScreenHeight-60;
        }else if(centerY <40){
            theCenterY=60;
        }
       
        for (UIButton *btn2 in _btnArr) {
            [UIView animateWithDuration:0.5 animations:^{
                btn2.frame=CGRectMake(ScreenWidth/2-25, ScreenHeight/2-25, 50, 70);
            } completion:^(BOOL finished){
                btn2.hidden=YES;
            
                [UIView animateWithDuration:0.5 animations:^{
                if (centerX==0 && centerY==0) {
//                    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight-60, 50, 50);
                    self.centerBtn.frame=CGRectMake(ScreenWidth-60, ScreenHeight/2, 50, 50);
                }else{
                    self.centerBtn.frame=CGRectMake(theCenterX-25, theCenterY-30, 50, 50);
                }
                self.centerBtn.layer.cornerRadius=25;
                self.centerBtn.layer.masksToBounds=YES;
//                    self.centerBtn.userInteractionEnabled=NO;
                }completion:^(BOOL finished){
                  //  self.centerBtn.userInteractionEnabled=YES;
                }];
            }];
        }
        
//        for (UILabel *label2 in _labelArr) {
//            [UIView animateWithDuration:0.5 animations:^{
//                label2.hidden=YES;
//           
//            }];
//        }
    }else{
        // self.centerBtn.userInteractionEnabled=NO;
         [UIView animateWithDuration:0.5 animations:^{
        self.centerBtn.frame=CGRectMake(ScreenWidth/2-35, ScreenHeight/2-35, 70, 70);
        self.centerBtn.layer.cornerRadius=35;
        self.centerBtn.layer.masksToBounds=YES;
         }completion:^(BOOL finish){
             [self addBtn];
             
         }];
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"frame"]) {
        return;
    }
    CGFloat height=self.centerBtn.frame.size.height;
    if (height ==50) {
        _panGestureRecognizer.enabled=YES;
    }else if(height ==70){
        _panGestureRecognizer.enabled=NO;
    }
}

- (void)dealloc {
    [self.centerBtn removeObserver:self forKeyPath:@"frame"];
}

-(void)handleClick:(UIButton *)sender{
    self.show=false;
    switch (sender.tag) {
        case 1:
            [_centerNvaVC pushViewController:_complainVC animated:YES];
            break;
        case 2:
            [_centerNvaVC pushViewController:_clubVC animated:YES];
            break;
        case 3:
            [_centerNvaVC pushViewController:_reportVC animated:YES];
            break;
        case 4:
            [_centerNvaVC pushViewController:_setVC animated:YES];
            break;
        default:
            break;
    }
//    MapViewController *map=[[MapViewController alloc]init];
//    [_sliderNvaVC pushViewController:map animated:YES];
}







- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch=event.allTouches.anyObject;
//    CGPoint *point=[touch locationInView:self.window.rootViewController.view];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    CGPoint point =[touch locationInView:self.window];
    if (!CGRectContainsPoint(self.centerBtn.frame, point)) {
     //   [self.centerBtn removeFromSuperview];
        if (!CGRectContainsPoint(self.button1.frame, point)) {
            self.show=NO;
        }

    }
}
@end
