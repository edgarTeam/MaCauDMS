//
//  WebAPIHelper.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebAPIHelper : NSObject
+ (WebAPIHelper *)sharedWebAPIHelper;

#pragma mark 用戶登陸
- (void)postUserLogin:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;




#pragma mark 用戶详情
- (void)postUserDetail:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;

#pragma mark 修改密碼
- (void)postUpdatePsd:(NSDictionary *)parameters completion:(void (^)(NSString *result))completion;

#pragma mark 投訴列表
- (void)postComplainList:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;

#pragma mark 投訴
- (void)postComplain:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;

#pragma mark 公告列表
- (void)postNoticeList:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;
#pragma mark 公告
- (void)postNotice:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;
#pragma 訂場列表
- (void)postPlaceRecordList:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;



#pragma 訂場詳情
- (void)postPlaceRecord:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;

#pragma mark 場地列表
- (void)postPlaceList:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;
#pragma mark 場地
- (void)postPlace:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;
#pragma mark 社區列表
- (void)postCommunity:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;

- (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;



- (void)uploadVoice:(NSDictionary *)para filePath:(NSString *)filePath completion:(void(^)(NSDictionary *dic))completion;

#pragma mark   建筑列表
- (void)postBuildingList:(NSDictionary *)parameters completion:(void (^)(NSDictionary *dic))completion;
@end

NS_ASSUME_NONNULL_END
