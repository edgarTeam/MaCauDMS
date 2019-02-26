//
//  EHWKWebView.m
//  DJQueryApp
//
//  Created by 胡嘉宏 on 2018/4/27.
//  Copyright © 2018年 zk. All rights reserved.
//

#import "EHWKWebView.h"
#import "AppDelegate.h"
@interface EHWKWebView()<WKNavigationDelegate,UIScrollViewDelegate>
{
    UIScrollView *_bgView;
    NSMutableArray *allUrlArray;
    CGPoint originOffSet;
//    UIActivityIndicatorView *_activityIndicatorView;
    
}

@end

@implementation EHWKWebView

-(instancetype)initWithFrame:(CGRect)frame{
   
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    
    [wkUController addScriptMessageHandler:self name:@"openInfo"];
    self = [super initWithFrame: frame configuration:wkWebConfig] ;

    self.navigationDelegate = self;
    self.scrollView.backgroundColor = DEFALUTBACKGROUNDCOLOR;

    
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.backgroundColor  = DEFALUTBACKGROUNDCOLOR;
   
    return self;
}

-(void)laodWeb:(NSString *)urlString{
    
    [self loadHTMLString:urlString baseURL:[NSURL URLWithString:kBaseUrl]];
}


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    for (UIView *view in self.subviews){
        [view setBackgroundColor:DEFALUTBACKGROUNDCOLOR];
    }
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.backgroundColor= '#3A6C91'" completionHandler:nil];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
   [self addImgClickJS];
    NSString *javascript = @"var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);";
    
    [webView evaluateJavaScript:javascript completionHandler:nil];

    [self.EHWKWebViewDelegate didFinishLoadView];
    
}

- (void)addImgClickJS {
    
    //获取所以的图片标签
    [self evaluateJavaScript:@"function getImages(){\
     var imgs = document.getElementsByTagName('img');\
     var imgScr = '';\
     for(var i=0;i<imgs.length;i++){\
     if (i == 0){ \
     imgScr = imgs[i].src; \
     } else {\
     imgScr = imgScr +'***'+ imgs[i].src;\
     } \
     };\
     return imgScr;\
     };" completionHandler:nil];//注入js方法
    
    [self evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        if (!error) {
            
            NSMutableArray * urlArray = result?[NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"***"]]:nil;
                self->allUrlArray = urlArray;
        } else {
            self->allUrlArray = nil;
        }
    }];
    
    //添加图片点击的回调
    [self evaluateJavaScript:@"function registerImageClickAction(){\
     var imgs = document.getElementsByTagName('img');\
     for(var i=0;i<imgs.length;i++){\
     imgs[i].customIndex = i;\
     imgs[i].onclick=function(){\
     window.location.href='image-preview-index:'+this.customIndex;\
     }\
     }\
     }" completionHandler:nil];
    [self evaluateJavaScript:@"registerImageClickAction();" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    //预览图片
    NSURL * url = navigationAction.request.URL;
    if ([url.scheme isEqualToString:@"image-preview-index"]) {
        //图片点击回调
        NSInteger index = [[url.absoluteString substringFromIndex:[@"image-preview-index:" length]] integerValue];
        NSString * imgPath = allUrlArray.count > index?allUrlArray[index]:nil;
        
        [self.EHWKWebViewDelegate didOpenImageViewWithEHWKWebView:self];
        [self showBigImage:imgPath];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

-(void)showBigImage:(NSString *)imageUrl{
    
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_bgView setContentSize:CGSizeMake(ScreenWidth*allUrlArray.count, ScreenHeight)];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_bgView];
    _bgView.pagingEnabled = YES;
    _bgView.delegate = self;
    NSInteger index = [allUrlArray indexOfObject:imageUrl];
    
    for (int i = 0; i < allUrlArray.count; i++) {
        NSString *urlString = [allUrlArray objectAtIndex:i];
        NSURL *imgUrl = [NSURL URLWithString:urlString];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
        scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        
        scrollView.delegate = self;
        scrollView.minimumZoomScale = 1;
        scrollView.maximumZoomScale = 10;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 240)];
        imageView.center =CGPointMake(ScreenWidth/2, ScreenHeight/2);
        scrollView.tag = (i+1)*11;
        imageView.userInteractionEnabled = YES;
        UIActivityIndicatorView * _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [imageView addSubview:_activityIndicatorView];
        [_activityIndicatorView setFrame:CGRectMake(0, 70, 100, 100)];
        _activityIndicatorView.center = CGPointMake(ScreenWidth/2, 120);
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.color  = DEFALUTNAVICOLOR;
        [_activityIndicatorView startAnimating];
        [imageView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                image = nil;
            }
            CGFloat rate =image.size.width/image.size.height;
            CGSize realSize = CGSizeMake(ScreenWidth, ScreenWidth/rate);
            CGRect frame = imageView.frame;
            frame.size = realSize;
            [imageView setFrame:frame];
            
            imageView.center =CGPointMake(ScreenWidth/2, ScreenHeight/2);
            [_activityIndicatorView stopAnimating];
        
        }];
        [scrollView addSubview:imageView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
        gesture.numberOfTapsRequired = 1;
        gesture.numberOfTouchesRequired = 1;
        [scrollView addGestureRecognizer:gesture];
        UITapGestureRecognizer *doubleClickGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickAction:)];
        doubleClickGR.numberOfTapsRequired = 2;
        doubleClickGR.numberOfTouchesRequired = 1;
        [scrollView addGestureRecognizer:doubleClickGR];
        [gesture requireGestureRecognizerToFail:doubleClickGR];
        [_bgView addSubview:scrollView];
    }
    [_bgView setContentOffset:CGPointMake(ScreenWidth*index, 0)];
    originOffSet = CGPointMake(ScreenWidth*index, 0);
    
}
-(void)cancel{
    [self.EHWKWebViewDelegate didCloseImageViewWithEHWKWebView:self];
    [_bgView removeFromSuperview];
}

-(void)doubleClickAction:(UITapGestureRecognizer *)recognizer{
    
    UIScrollView *scollView = (UIScrollView *)recognizer.view;
    [UIView animateWithDuration:0.3
                     animations:^{
                         scollView.zoomScale = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.scrollView]) {
        return;
    }
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    UIImageView *subview = [scrollView.subviews firstObject];
    subview.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if ([scrollView isEqual: _bgView]||[scrollView isEqual:self.scrollView]) {
        return nil;
    }
    for ( UIView *view in scrollView.subviews) {
        return  view;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_bgView]) {
        if (originOffSet.x == scrollView.contentOffset.x) {
            return;
        }
            for(id view in _bgView.subviews){
                if ([view isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollView = (UIScrollView *)view;
                    
                    if(scrollView.zoomScale > 1.0){
                        scrollView.zoomScale = 1.0f;
                    }
                }
            }
            
        }
}
@end
