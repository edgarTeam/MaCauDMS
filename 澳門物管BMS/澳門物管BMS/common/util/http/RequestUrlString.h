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



#define kNoticeList kBaseUrl @"notice/list"
#define kNotice kBaseUrl @"notice/detail"
//圖片上傳
#define kUploadImg kBaseUrl @"file/upload"
//訂場
#define kPlaceRecord kBaseUrl @"placeRecord/detail"

//場地列表
#define kPlaceList kBaseUrl @"place/list"
//場地
#define kPlace kBaseUrl @"place/detail"
//社區列表
#define kCommunity kBaseUrl @"community/list"
#endif /* RequestUrlString_h */
