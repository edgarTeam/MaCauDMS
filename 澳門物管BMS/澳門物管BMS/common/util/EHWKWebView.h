//
//  EHWKWebView.h
//  DJQueryApp
//
//  Created by 胡嘉宏 on 2018/4/27.
//  Copyright © 2018年 zk. All rights reserved.
//

#import <WebKit/WebKit.h>

@class EHWKWebView;
@protocol EHWKWebViewDelegate<NSObject>

-(void)didOpenImageViewWithEHWKWebView:(EHWKWebView *)EHWKWebView;
-(void)didCloseImageViewWithEHWKWebView:(EHWKWebView *)EHWKWebView;
- (void)didFinishLoadView;

@end
@interface EHWKWebView : WKWebView

@property (nonatomic,assign) id<EHWKWebViewDelegate> EHWKWebViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)laodWeb:(NSString *)urlString;
@end
