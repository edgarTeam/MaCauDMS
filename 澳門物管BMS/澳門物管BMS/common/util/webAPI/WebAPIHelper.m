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
+ (id)allocWithZone:(NSZone *)zone
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//+ (id) allocWithZone:(NSZone *)zone{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//        _manager = [AFHTTPSessionManager manager];
//        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
//        [_manager.requestSerializer  setValue:token forHTTPHeaderField:@"Authorization"]; //uuid
//        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html" ,@"text/xml",@"application/pdf",nil];
//        ((AFJSONResponseSerializer *)_manager.responseSerializer).removesKeysWithNullValues = YES;
//        
//    });
//    
//    return  _instance;
//}


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
//    [self.httpHelper postDicWithURL:kUserLogin parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
    [self.httpHelper postDicWithURL:kUserLogin parameters:parameters  needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}




-(void)postUserDetail:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kUserDetail parameters:parameters needLoading:YES success:completion failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)postUpdatePsd:(NSDictionary *)parameters completion:(void (^)(NSString * _Nonnull))completion{
//    [self.httpHelper postStrWithURL:kUpdatePsd parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
    [self.httpHelper postStrWithURL:kUpdatePsd parameters:parameters needLoading:YES  success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postComplainList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
//    [self.httpHelper postDicWithURL:kComplainList parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
    [self.httpHelper postDicWithURL:kComplainList parameters:parameters  needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postComplain:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
//    [self.httpHelper postDicWithURL:kComplain parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
    [self.httpHelper postDicWithURL:kComplain parameters:parameters  needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}



- (void)postNoticeList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
//    [self.httpHelper postDicWithURL:kNoticeList parameters:parameters needLoading:YES success:^(NSDictionary *dic){
//        if (dic ==nil) {
//            return ;
//        }
//        completion(dic);
//    } failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
    [self.httpHelper postDicWithURL:kNoticeList parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}


- (void)postNotice:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kNotice parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postPlaceRecordList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlaceRecordList parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postPlaceRecord:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlaceRecord parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}


- (void)postPlaceList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlaceList parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

- (void)postPlace:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kPlace parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}

//- (void)postCommunity:(NSDictionary *)parameters completion:(void (^)(NSArray * _Nonnull))completion{
//    [self.httpHelper postObjWithURL:kCommunity parameters:parameters convertClassName:@"" needLoading:YES success:^(NSArray *arr){
//        if (arr == nil) {
//            return ;
//        }
//        completion(arr);
//    } failure:^(NSError *error){
//        NSLog(@"%@",error);
//    }];
//}

- (void)postCommunity:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kCommunity parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}



+ (NSURLSessionDataTask *)POST_JSON:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress body:(id)body success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setupJSONResponse];
    NSURLSessionDataTask *dataTask =  [manager POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        //        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        //       AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html" ,@"text/xml",nil];
        NSError *serializationError = nil;
        id  jsonObject = [serializer responseObjectForResponse:task.response data:responseObject error:&serializationError];
        if (serializationError == nil) {
            success(task,jsonObject);
        }else {
            failure(dataTask,serializationError);
        }
        
    } failure:failure];
    
    
    return dataTask;
}


- (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{

   // NSString *requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, url];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  


    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];

    //[request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:LoginToken] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSData *jsonData = nil;
                
                if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                    jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                } else if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }else if([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]){
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }
                
                NSLog(@"%@",[[responseObject objectForKey:@"data"] class]);
//                NSError *err;
//                id resultObject = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                  options:NSJSONReadingAllowFragments
//                                                                    error:&err];

            }
            success(responseObject);
        }else{
            failure(error);
        }
        

    }] resume];
}

- (void)uploadVoice:(NSDictionary *)para filePath:(NSString *)filePath completion:(void (^)(NSDictionary *))completion {
    [self.httpHelper uploadFileWithURL:kUploadImg parameters:para filePath:filePath success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)postBuildingList:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion {
    [self.httpHelper postDicWithURL:kBuildingList parameters:parameters  needLoading:YES success:^(NSDictionary *dic){
        if (dic == nil) {
            return ;
        }
        completion(dic);
    } failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}



- (void)postResetPSD:(NSDictionary *)parameters completion:(void (^)(NSDictionary * _Nonnull))completion{
    [self.httpHelper postDicWithURL:kResetPSD parameters:parameters  needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];


}

- (void)postResetPSDWithStr:(NSDictionary *)parameters completion:(void (^)(NSString * _Nonnull))completion{
    [self.httpHelper postStrWithURL:kResetPSD parameters:parameters needLoading:YES success:completion failure:^(NSError *error){
        NSLog(@"%@",error);
    }];
}
@end
