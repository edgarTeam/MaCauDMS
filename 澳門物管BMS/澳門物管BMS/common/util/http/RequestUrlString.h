//
//  RequestUrlString.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#ifndef RequestUrlString_h
#define RequestUrlString_h

#define kBaseUrl @"http://songsong.fun:8080/app"
#define kBaseImageUrl @"http://songsong.fun:8080/file"

#define kUserLogin kBaseUrl @"/pass/login"

#define kUserDetail kBaseUrl @"/api/user/detail"
//修改密碼
#define kUpdatePsd kBaseUrl @"/api/user/updatePassword"
//更新個人信息
#define kUpdateInfo kBaseUrl @"/api/user/update"

//報修列表
#define kComplainList kBaseUrl @"/api/complain/selfList"
//報修詳情
#define kComplain kBaseUrl @"/api/complain/detail"

#define kNoticeList kBaseUrl @"/api/notice/list"
#define kNotice kBaseUrl @"/api/notice/detail"
//圖片上傳
#define kUploadImg kBaseUrl @"/api/file/upload"
//訂場列表
#define kPlaceRecordList kBaseUrl @"/api/placeRecord/list"
//訂場詳情
#define kPlaceRecord kBaseUrl @"/api/placeRecord/detail"

//場地列表
#define kPlaceList kBaseUrl @"/api/place/list"

//場地
#define kPlace kBaseUrl @"/api/place/detail"
//社區列表
#define kCommunity kBaseUrl @"/api/community/list"

//添加報修/投訴
#define kAddComplain kBaseUrl @"/api/complain/add"
//添加訂場
#define kAddPlaceRecord kBaseUrl @"/api/placeRecord/add"

//建筑
#define kBuildingList kBaseUrl @"/api/building/list"

//重置密碼
#define kResetPSD kBaseUrl @"/pass/resetPassword"

#define deleteFile kBaseUrl @"/api/file/delFile"

#define Kweather @"http://v.juhe.cn/weather/geo"



#define IOSMap @"https://restapi.amap.com/v3/geocode/regeo"
#define IOSWeather @"https://restapi.amap.com/v3/weather/weatherInfo"

#define CHECK_UPDATE_URL @"http://47.107.131.1:8080/app/app/system/version" //检查更新
#define UPDATE_WEB_URL @"" //更新内容网址
#define UPDATE_URL @""

#endif /* RequestUrlString_h */
