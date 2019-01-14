//
//  RequestUrlString.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#ifndef RequestUrlString_h
#define RequestUrlString_h

#define kBaseUrl @"http://47.107.131.1:8080/app/"


#define kUserLogin kBaseUrl @"pass/login"
//修改密碼
#define kUpdatePsd kBaseUrl @"api/user/updatePassword"

//報修列表
#define kComplainList kBaseUrl @"api/complain/selfList"
//報修詳情
#define kComplain kBaseUrl @"api/complain/detail"

#define kNoticeList kBaseUrl @"api/notice/list"
#define kNotice kBaseUrl @"api/notice/detail"
//圖片上傳
#define kUploadImg kBaseUrl @"api/file/upload"
//訂場列表
#define kPlaceRecordList kBaseUrl @"api/placeRecord/list"
//訂場詳情
#define kPlaceRecord kBaseUrl @"api/placeRecord/detail"

//場地列表
#define kPlaceList kBaseUrl @"api/place/list"

//場地
#define kPlace kBaseUrl @"api/place/detail"
//社區列表
#define kCommunity kBaseUrl @"api/community/list"

//添加報修/投訴
#define kAddComplain kBaseUrl @"api/complain/add"
//添加訂場
#define kAddPlaceRecord kBaseUrl @"api/placeRecord/add"


#define CHECK_UPDATE_URL @"http://47.107.131.1:8080/app/app/system/version" //检查更新
#define UPDATE_WEB_URL @"" //更新内容网址
#define UPDATE_URL @""

#endif /* RequestUrlString_h */
