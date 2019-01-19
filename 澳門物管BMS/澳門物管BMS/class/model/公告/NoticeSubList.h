//
//  NoticeSubList.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/1/19.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeSubList : NSObject
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *imageId;
@property (nonatomic,copy) NSString *imageThumbnail;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *objectId;
@property (nonatomic,copy) NSString *updateTime;
@property (nonatomic,assign) NSInteger imageType;
@end

NS_ASSUME_NONNULL_END
