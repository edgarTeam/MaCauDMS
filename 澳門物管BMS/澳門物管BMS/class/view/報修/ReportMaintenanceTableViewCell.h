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
@property (weak, nonatomic) IBOutlet UILabel *repairDescribeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *repairStatusTitleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabHeight;
@property (weak, nonatomic) IBOutlet UILabel *repairTitleLab;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic,strong) NSString *timeStr;
- (void)setUpModel:(ReportMaintenanceDetail *)model;

- (CGFloat) getlabelHeiight:(NSString *)labelText label:(UILabel *)label;
@end



NS_ASSUME_NONNULL_END
