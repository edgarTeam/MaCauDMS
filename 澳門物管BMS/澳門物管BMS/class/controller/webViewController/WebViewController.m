//
//  WebViewController.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/26.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "EHWKWebView.h"
#import "RequestUrlString.h"
#import <SVProgressHUD.h>
@interface WebViewController ()<EHWKWebViewDelegate>
{
    UIScrollView *bgView;
    NSMutableArray *allUrlArray;
}

@property (strong, nonatomic)  EHWKWebView *webView;
@property (strong, nonatomic) NSString *urlString;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
@end

@implementation WebViewController
{
    NSString *displayTitle;
    BOOL realPath;
    CGFloat f;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = displayTitle;

    self.baseTitleLab.text=LocalizedString(@"string_privacy_title");
   // self.edgesForExtendedLayout=UIRectEdgeNone;
    NSLog(@"屏幕高度%f",ScreenHeight);
    NSLog(@"%f",resultHeight);
    NSLog(@"長度：%f",ScreenHeight-resultHeight);
    CGFloat SCH=ScreenHeight;
    CGFloat RH=resultHeight;
    f=SCH-RH;
    NSLog(@"%f",f);
    self.webView = [[
                     EHWKWebView alloc] initWithFrame:CGRectMake(0, resultHeight, self.view.bounds.size.width,f)];
    _webView.EHWKWebViewDelegate = self;
    // Do any additional setup after loading the view from its nib.

}

-(void)viewWillLayoutSubviews{
    [self.webView setFrame:CGRectMake(0, resultHeight, self.view.bounds.size.width,f)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (instancetype)initWithURL:(NSString *)urlString title:(NSString *)title{
    self= [super init];
    displayTitle = title;
    self.urlString = urlString;
    realPath = NO;
    return  self;
}

-(instancetype)initWithPath:(NSString *)urlString title:(NSString *)title{
    self= [super init];
    displayTitle = title;
    self.urlString = urlString;
    realPath = YES;
    return  self;
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self laodWeb:_urlString];
//    self.navigationController.navigationBar.hidden=NO;
//    self.navigationController.navigationBar.barTintColor = RGB(43, 183, 224);
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self laodWeb:_urlString];
    self.navigationController.navigationBar.hidden=YES;
//    self.navigationController.navigationBar.barTintColor = RGB(43, 183, 224);
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)laodWeb:(NSString *)urlString{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD show];
    if (realPath) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
        [_webView loadHTMLString:urlString baseURL:[NSURL URLWithString:kBaseUrl]];
    }
}

-(void)didOpenImageViewWithEHWKWebView:(EHWKWebView *)EHWKWebView{
    self.navigationController.navigationBarHidden = YES;
}
-(void)didCloseImageViewWithEHWKWebView:(EHWKWebView *)EHWKWebView{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didFinishLoadView{
    [self.view addSubview:_webView];
    [SVProgressHUD dismiss];
}

//- (void)viewWillDisappear:(BOOL)animated{
//
//    self.edgesForExtendedLayout=UIRectEdgeAll;
//}


@end
