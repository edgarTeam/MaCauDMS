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
    self.backgroundColor=[UIColor clearColor];
    self.centerView.layer.masksToBounds=YES;
    self.centerView.layer.cornerRadius=7.0;
    _repairDescribeTitleLab.text=LocalizedString(@"string_repair_describe_title");
    _repairStatusTitleLab.text=LocalizedString(@"string_repair_status_title");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpModel:(ReportMaintenanceDetail *)model{
    if ([model.createTime rangeOfString:@"T"].location !=NSNotFound) {
        _timeStr=[model.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }else{
        _timeStr=model.createTime;
    }
    if (_timeStr.length !=0) {
        _timeStr=[_timeStr substringToIndex:19];
    }
    
    
    [self.titleLab setText:model.complainClassType];
  //  [self.timeLab setText:model.createTime];
    [self.timeLab setText:_timeStr];
    [self.contentLab setText:model.complainDescribe];
    [self.stateLab setText:model.complainType];
}
@end
