//
//  SelectDatePickerController.h
//  OA.message
//
//  Created by lee on 16/6/25.
//  Copyright © 2016年 sanchun. All rights reserved.
//

#import "BaseAlertViewController.h"

@interface SelectDatePickerController : BaseAlertViewController
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIDatePicker *timePicker;
@property(nonatomic,strong)void (^didSelectData)(NSDate *date,NSDate *time,NSString *timeStr);

@end
