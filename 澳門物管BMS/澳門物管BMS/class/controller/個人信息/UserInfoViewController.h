//
//  UserInfoViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/1.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *headTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *sexTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *telTitleLab;

@end

NS_ASSUME_NONNULL_END
