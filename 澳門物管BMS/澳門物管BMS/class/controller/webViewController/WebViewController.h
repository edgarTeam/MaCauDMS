//
//  WebViewController.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/26.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : BaseViewController
- (instancetype)initWithURL:(NSString *)urlString title:(NSString *)title;
- (instancetype)initWithPath:(NSString *)urlString title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
