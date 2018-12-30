//
//  ReportMaintenanceTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ReportMaintenanceTableViewCell.h"

@implementation ReportMaintenanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpModel:(ReportMaintenanceDetail *)model{
    [self.titleLab setText:model.complainClassType];
    [self.timeLab setText:model.createTime];
    [self.contentLab setText:model.complainDescribe];
    [self.stateLab setText:model.complainType];
}
@end
