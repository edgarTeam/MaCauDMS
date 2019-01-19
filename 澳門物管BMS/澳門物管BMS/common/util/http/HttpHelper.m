//
//  HttpHelper.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <MJExtension/MJExtension.h>
#import <AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "HttpHelper.h"
#import "CommonUtil.h"
@implementation HttpHelper
typedef NS_ENUM(NSInteger, HTTPRequestMethod)
{
    HTTPRequestMethodPost,
    HTTPRequestMethodGet,
    HTTPRequestMethodPut
};

int _requestCount;
static HttpHelper *_instance;
static AFHTTPSessionManager *_manager;

+ (id) allocWithZone:(NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        _manager = [AFHTTPSessionManager manager];
            NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
            [_manager.requestSerializer  setValue:token forHTTPHeaderField:@"Authorization"]; //uuid
            _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain" ,@"text/html" ,@"text/xml",@"application/pdf",nil];
            ((AFJSONResponseSerializer *)_manager.responseSerializer).removesKeysWithNullValues = YES;
        
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return  _instance;
}

+ (HttpHelper *)shareHttpHelper{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

-(void)resetToken:(NSString *)token{
    [_manager.requestSerializer  setValue:token forHTTPHeaderField:@"Authorization"];
}

#pragma mark - private method
- (void)requestWithURL:(NSString *)URLString
         requestMethod:(HTTPRequestMethod)requestMethod
            parameters:(id)parameters
      convertClassName:(NSString *)className
               isArray:(BOOL)isArray
//                isBody:(BOOL)isBody
              isString:(BOOL)isString
               success:(void (^)(id obj))success
               failure:(void (^)(NSError *error))failure{
#pragma warning setting header
//            NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:LoginToken];
//            [_manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    //     encode url
    NSString *urlEncodeString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (requestMethod) {
            // handle request by method get
        case HTTPRequestMethodGet:
            [self getWithURL:urlEncodeString convertClassName:className parameters:parameters isArray:isArray isString:isString success:success failure:failure];
            break;
            //  Handle reuquest by method post
        case HTTPRequestMethodPost:
            [self postWithURL:urlEncodeString parameters:parameters convertClassName:className isArray:isArray isString:isString success:success failure:failure];
//            [self postWithURL:urlEncodeString parameters:parameters convertClassName:className isArray:isArray isBody:isBody isString:isString success:success failure:failure];
            break;
        default:
            break;
    }
    
}

- (void)postWithURL:(NSString *)URLString
         parameters:(id)parameters
   convertClassName:(NSString *)className
            isArray:(BOOL)isArray
//             isBody:(BOOL)isBody
           isString:(BOOL)isString
            success:(void (^)(id obj))success
            failure:(void (^)(NSError *error))failure
{
    [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        
        if ([CommonUtil isRequestOK:responseObject]) {
            [SVProgressHUD dismiss];
            if (isString) {
                success([responseObject objectForKey:@"data"]);
            }else if([responseObject isKindOfClass:[NSDictionary class]]){
                NSData *jsonData = nil;
                if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                    jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                } else if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }else if([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]){
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }
                NSError *err;
                id resultObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
                if (className == nil || [@"" isEqualToString:className]) {
                    success(resultObject);
                } else if (isArray) {
                    NSArray *data = [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:resultObject];
                    success(data);
                } else {
                    
                    id obj = [NSClassFromString(className) mj_objectWithKeyValues:resultObject];
                    success(obj);
                }
            }
        }else{
            [SVProgressHUD dismiss];
            success(nil);
        }
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [SVProgressHUD dismiss];
        success(nil);
    }];
}

- (void)getWithURL:(NSString *)URLString
  convertClassName:(NSString *)className
        parameters:(NSDictionary *)parameters
           isArray:(BOOL)isArray
          isString:(BOOL)isString

           success:(void (^)(id obj))success
           failure:(void (^)(NSError *error))failure
{
    [_manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if ([CommonUtil isRequestOK:responseObject]) {
            if (isString) {
                success([responseObject objectForKey:@"data"]);
            }else if([responseObject isKindOfClass:[NSDictionary class]]){
                NSData *jsonData = nil;
                
                if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                    jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                } else if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }else if([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]){
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }
                
                NSLog(@"%@",[[responseObject objectForKey:@"data"] class]);
                NSError *err;
                id resultObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:&err];
                if (className == nil || [@"" isEqualToString:className]) {
                    success(resultObject);
                } else if (isArray) {
                    NSArray *data = [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:resultObject];
                    success(data);
                } else {
                    id obj = [NSClassFromString(className) mj_objectWithKeyValues:resultObject];
                    success(obj);
                }
//                }else if (isBody){
//
//                }
            }else{
                [SVProgressHUD dismiss];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

/**
 handle request error return
 */
- (void)handleError:(NSError *)error
{
    NSLog(@"%ld",error.code);
    
}

#pragma mark Post Request

-(void)postObjWithURL:(NSString *)URLString parameters:(id)parameters convertClassName:(NSString *)className needLoading:(BOOL)needLoading  success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:className isArray:NO isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:className isArray:NO isBody:NO isString:NO success:success failure:failure];
}

-(void)postArrWithURL:(NSString *)URLString parameters:(id)parameters needLoading:(BOOL)needLoading  success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:YES isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:YES isBody:isBody isString:NO success:success failure:failure];
}

- (void)postDicWithURL:(NSString *)urlString parameters:(id)parameters needLoading:(BOOL)needLoading  success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:urlString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:NO isString:NO success:success failure:failure];
//    [self requestWithURL:urlString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:NO isBody:isBody isString:NO success:success failure:failure];
}

-(void)postStrWithURL:(NSString *)URLString parameters:(id)parameters needLoading:(BOOL)needLoading  success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:NO isString:YES success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:nil isArray:NO isBody:isBody isString:YES success:success failure:failure];
}

-(void)postObjArrWithURL:(NSString *)URLString parameters:(id)parameters convertClassName:(NSString *)className needLoading:(BOOL)needLoading  success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:className isArray:YES isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodPost parameters:parameters convertClassName:className isArray:YES isBody:isBody isString:NO success:success failure:failure];
}


#pragma mark Get Request

- (void)getObjWithURL:(NSString *)URLString
     convertClassName:(NSString *)className
              success:(void (^)(id obj))success
              failure:(void (^)(NSError *error))failure
{
    
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:NO isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:NO isBody:NO isString:NO success:success failure:failure];
}


-(void)getArrWithURL:(NSString *)URLString needLoading:(BOOL)needLoading success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:YES isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:YES isBody:NO isString:NO success:success failure:failure];
}


-(void)getArrWithURL:(NSString *)URLString
    convertClassName:(NSString *)className
         needLoading:(BOOL)needLoading
             success:(void (^)(NSArray *))success
             failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:YES isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:YES isBody:NO isString:NO success:success failure:failure];
}

-(void)getStrWithURL:(NSString *)URLString needLoading:(BOOL)needLoading success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:NO isString:YES success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:NO isBody:NO isString:YES success:success failure:failure];
}

- (void)getObjWithURL:(NSString *)URLString
     convertClassName:(NSString *)className
          needLoading:(BOOL)needLoading
              success:(void (^)(id obj))success
              failure:(void (^)(NSError *error))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:NO isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:className isArray:NO isBody:NO isString:NO success:success failure:failure];
}

- (void)getDicWithURL:(NSString *)URLString needLoading:(BOOL)needLoading success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    if (needLoading) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD show];
    }
    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:NO isString:NO success:success failure:failure];
//    [self requestWithURL:URLString requestMethod:HTTPRequestMethodGet parameters:nil convertClassName:nil isArray:NO isBody:NO isString:NO success:success failure:failure];
}


- (void)postUploadImagesWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters images :(NSArray *)images completion:(void (^)(NSDictionary *))completion{
    
    NSURL *url = [NSURL URLWithString:urlString];
    [_manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:LoginToken] forHTTPHeaderField:@"Authorization"];
    [_manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<images.count; i++) {
            
            UIImage * image =images[i];
            
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            
            NSString *name =[NSString stringWithFormat:@"image%d.png",i];
            
            NSString *formKey =[NSString stringWithFormat:@"image%d",i];
            
            NSString *type = @"image/png";
            
            [formData appendPartWithFileData:data name:@"file" fileName:name mimeType:type];
            
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
}

- (void)downLoadFileToSandBox:(NSString *)urlString completion:(void (^)(NSURL *))completion{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //下载文件
    /*
     第一个参数:请求对象
     第二个参数:progress 进度回调
     第三个参数:destination 回调(目标位置)
     有返回值
     targetPath:临时文件路径
     response:响应头信息
     第四个参数:completionHandler 下载完成后的回调
     filePath:最终的文件路径
     */
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request
                                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                     //下载进度
                                                                     NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                                                 }
                                                              destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                  //保存的文件路径
                                                                  NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                                                                  return [NSURL fileURLWithPath:fullPath];
                                                                  
                                                              }
                                                        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                            [SVProgressHUD dismiss];
                                                            if (error) {
                                                                NSLog(@"%@",error);
                                                            } else{
                                                                completion(filePath);
                                                                
                                                            }
                                                        }];
    
    //执行Task
    [download resume];
}





- (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    
    // NSString *requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, url];
   // AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

   

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
 
  
    // 设置body
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:LoginToken] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    AFJSONResponseSerializer *responseSerializer=[AFJSONResponseSerializer serializer];
   // AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    _manager.responseSerializer = responseSerializer;
    [[_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSData *jsonData = nil;
                if ([responseObject objectForKey:@"data"]  ==nil) {
                    return ;
                }
                
                if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                    jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                } else if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }else if([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]){
                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
                }
                
                NSLog(@"%@",[[responseObject objectForKey:@"data"] class]);
                NSError *err;
                id resultObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:&err];
//                id obj = [NSClassFromString(className) mj_objectWithKeyValues:resultObject];
//                success(obj);
                //                NSError *err;
                //                id resultObject = [NSJSONSerialization JSONObjectWithData:jsonData
                //                                                                  options:NSJSONReadingAllowFragments
                //                                                                    error:&err];
                success(resultObject);
                
            }
            success(responseObject);
        }else{
            failure(error);
        }
        
        
    }] resume];
}





- (void)uploadFileWithURL:(NSString *)URLString parameters:(id)parameters filePath:(NSString *)filePath success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [_manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" error:nil];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([CommonUtil isRequestOK:responseObject]) {
            success(responseObject[@"data"]);
            //            if([responseObject isKindOfClass:[NSDictionary class]]){
            //                NSData *jsonData = nil;
            //                if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
            //                    jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
            //                } else if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            //                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
            //                }else if([[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]){
            //                    jsonData =  [NSJSONSerialization dataWithJSONObject:[responseObject objectForKey:@"data"] options:NSJSONWritingPrettyPrinted error:nil];
            //                }
            //                success(jsonData);
            //            }
        }else{
            success(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(nil);
    }];
}





@end
