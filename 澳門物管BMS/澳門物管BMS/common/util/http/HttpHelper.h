//
//  HttpHelper.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpHelper : NSObject

+(HttpHelper *)shareHttpHelper;

#pragma  mark POST request
- (void)postDicWithURL:(NSString *)urlString
            parameters:(id)parameters
//                isBody:(BOOL)isBody
           needLoading:(BOOL)needLoading
               success:(void(^)(NSDictionary *dic))success
               failure:(void(^)(NSError *error))failure;

- (void)postArrWithURL:(NSString *)URLString
            parameters:(id)parameters
           needLoading:(BOOL)needLoading
//                isBody:(BOOL)isBody
               success:(void (^)(NSArray *array))success
               failure:(void (^)(NSError *error))failure;

- (void)postObjWithURL:(NSString *)URLString
            parameters:(id)parameters
      convertClassName:(NSString *)className
//                isBody:(BOOL)isBody
           needLoading:(BOOL)needLoading
               success:(void (^)(id obj))success
               failure:(void (^)(NSError *error))failure;

- (void)postObjArrWithURL:(NSString *)URLString
               parameters:(id)parameters
         convertClassName:(NSString *)className
              needLoading:(BOOL)needLoading
//                   isBody:(BOOL)isBody
                  success:(void (^)(id obj))success
                  failure:(void (^)(NSError *error))failure;

- (void)postStrWithURL:(NSString *)URLString
            parameters:(id)parameters
           needLoading:(BOOL)needLoading
//                isBody:(BOOL)isBody
               success:(void (^)(NSString *result))success
               failure:(void (^)(NSError *error))failure;

#pragma mark GET request

- (void)getDicWithURL:(NSString *)URLString
          needLoading:(BOOL)needLoading
              success:(void (^)(NSDictionary *dic))success
              failure:(void (^)(NSError *error))failure;

- (void)getObjWithURL:(NSString *)URLString
     convertClassName:(NSString *)className
          needLoading:(BOOL)needLoading
              success:(void (^)(id obj))success
              failure:(void (^)(NSError *error))failure;

- (void)getArrWithURL:(NSString *)URLString
          needLoading:(BOOL)needLoading
              success:(void (^)(NSArray *array))success
              failure:(void (^)(NSError *error))failure;

- (void)getArrWithURL:(NSString *)URLString
     convertClassName:(NSString *)className
          needLoading:(BOOL)needLoading
              success:(void (^)(NSArray *array))success
              failure:(void (^)(NSError *error))failure;

- (void)getStrWithURL:(NSString *)URLString
          needLoading:(BOOL)needLoading
              success:(void (^)(NSString *result))success
              failure:(void (^)(NSError *error))failure;


- (void)postUploadImagesWithUrl:(NSString *)urlString parameters:(NSDictionary *)parameters images:(NSArray *)imagePaths completion:(void (^)(NSDictionary *info))completion;


- (void)downLoadFileToSandBox:(NSString *)urlString completion:(void (^)(NSURL *sandBoxPath))completion;


- (void)resetToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
