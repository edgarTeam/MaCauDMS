//
//  NoticeImageViewController.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/7.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "NoticeImageViewController.h"

#import <SDWebImage/SDImageCache.h>


@interface NoticeImageViewController ()
@property(strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation NoticeImageViewController
{
    //    CGFloat height;
    CGFloat sum;
    CGFloat sumHeight;
    CGRect statusRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseTitleLab.text=LocalizedString(@"详情");
    // Do any additional setup after loading the view.
    sumHeight = 0;
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    statusRect = [[UIApplication sharedApplication] statusBarFrame];
    //self.view.backgroundColor=[UIColor whiteColor];
    //    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];

    
    //    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    //    [self.scrollView addSubview:self.imageView];
    [self.scrollView setAlwaysBounceHorizontal:NO];
    
    if (@available(iOS 11.0, *)) {
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            //make.top.mas_equalTo(60);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(60);
            make.left.and.right.and.bottom.mas_equalTo(0);
            //make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.scrollView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    
    NSArray *imageArr=[_imageUrl componentsSeparatedByString:@";"];
    //    NSMutableArray *imageHeight=[NSMutableArray new];
    
    
    for (int i=0; i<imageArr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageArr[i]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CGFloat height=ScreenWidth/(image.size.width/image.size.height);
            
            imageView.image=image;
            imageView.frame=CGRectMake(0, sumHeight, ScreenWidth, height);
            
            NSLog(@"%f",imageView.frame.size.height);
            [self.scrollView addSubview:imageView];
            
            sumHeight += height;
            [self resetContentSize:sumHeight];
            
            
            
        }];
    }
}

- (void)resetContentSize:(CGFloat)height{
    
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, height)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
