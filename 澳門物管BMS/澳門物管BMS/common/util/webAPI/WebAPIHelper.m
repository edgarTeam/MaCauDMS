//
//  WebAPIHelper.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "WebAPIHelper.h"
#import "HttpHelper.h"
#import <AFNetworking.h>
@interface WebAPIHelper()
@property (nonatomic, strong) HttpHelper *httpHelper;
//@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation WebAPIHelper
static WebAPIHelper *_instance;
static AFHTTPSessionManager *_manager;
//+ (id)allocWithZone:(NSZone *)zone
//{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//    });
//    return _instance;
//}

+ (id) allocWithZone:(NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer  setValue:UUID forHTTPHeaderField:@"Authorization"]; //uuid
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html" ,@"text/xml",@"application/pdf",nil];
        ((AFJSONResponseSerializer *)_manager.responseSerializer).removesKeysWithNullValues = YES;
        
    });
    
    return  _instance;
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

- (void)postUpdatePsd:(NSDictionary *)parameters completion:(void (^)(NSString * _Nonnull))completion{
    [self.httpHelper postStrWithURL:kUpdatePsd parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postComplainList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kComplainList parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postComplain:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kComplain parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}



- (void)postNoticeList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kNoticeList parameters:parameters needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
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

- (void)postPlaceRecordList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlaceRecordList parameters:parameters needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
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
