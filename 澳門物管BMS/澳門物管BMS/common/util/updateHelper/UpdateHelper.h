//
//  UpdateHelper.h
//  DavidQuarry
//
//  Created by 胡嘉宏 on 2018/7/31.
//  Copyright © 2018年 EdgarHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateHelper : NSObject
+(UpdateHelper *)shareUpdateHelper;
- (void)checkUpdateInfo;
@end
