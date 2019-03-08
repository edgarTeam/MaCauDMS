//
//  PickViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/2/18.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAlertViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PickViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,copy)void(^backBlock)(NSString *title);
@property(nonatomic,strong)NSString *str;
@end

NS_ASSUME_NONNULL_END
