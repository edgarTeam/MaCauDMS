//
//  WebAPIHelper.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "WebAPIHelper.h"
#import "HttpHelper.h"
@interface WebAPIHelper()
@property (nonatomic, strong) HttpHelper *httpHelper;
@end

@implementation WebAPIHelper
static WebAPIHelper *_instance;

+ (id)allocWithZone:(NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (WebAPIHelper *)sharedWebAPIHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return  _instance;
}

#pragma mark getter
- (HttpHelper *)httpHelper
{
    if (!_httpHelper) {
        _httpHelper = [HttpHelper shareHttpHelper];
    }
    return  _httpHelper;
}


- (void)postUserLogin:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kUserLogin parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postNotice:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kNotice parameters:parameters needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postPlaceRecord:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlaceRecord parameters:parameters needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}


- (void)postPlace:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlace parameters:parameters needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postCommunity:(NSDictionary *)parameters completion:(void (^)(NSArray * _Nonnull))completion{
    [self.httpHelper postObjWithURL:kCommunity parameters:parameters convertClassName:@"" needLoading:YES success:^(NSArray *arr){
        if (arr == nil) {
            return ;
        }
        completion(arr);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}
@end
