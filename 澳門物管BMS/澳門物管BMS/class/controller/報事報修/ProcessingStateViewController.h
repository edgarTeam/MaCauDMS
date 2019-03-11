//
//  ProcessingStateViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,ProcessType)
{
    ReportProcessType,//报修 0
    ComplainProcessType,//投诉 1
};
NS_ASSUME_NONNULL_BEGIN

@interface ProcessingStateViewController : BaseViewController
@property (nonatomic,assign) ProcessType type;
@end

NS_ASSUME_NONNULL_END
