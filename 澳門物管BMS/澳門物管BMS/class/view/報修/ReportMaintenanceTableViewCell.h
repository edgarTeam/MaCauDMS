//
//  ReportMaintenanceTableViewCell.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportMaintenanceDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReportMaintenanceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIView *centerView;

- (void)setUpModel:(ReportMaintenanceDetail *)model;
@end

NS_ASSUME_NONNULL_END
