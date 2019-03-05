//
//  ReportMaintenanceTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ReportMaintenanceTableViewCell.h"
#import "NSDate+Utils.h"
@interface ReportMaintenanceTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *iconLab;

@end


@implementation ReportMaintenanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformRotate(transform, -45);
//    _iconLab.transform = transform;
    _iconLab.transform=CGAffineTransformMakeRotation(-45 *M_PI / 180.0);

    
    self.backgroundColor=[UIColor clearColor];
    self.centerView.layer.masksToBounds=YES;
    self.centerView.layer.cornerRadius=7.0;
    _repairDescribeTitleLab.text=LocalizedString(@"string_repair_describe_title");
    _repairStatusTitleLab.text=LocalizedString(@"string_repair_status_title");
    _repairTitleLab.text=LocalizedString(@"string_repair_classify_title");
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
        //_timeStr=[_timeStr substringToIndex:19];
        _timeStr=[_timeStr substringToIndex:10];
    }
//    icon_complain_cell_bg
    
   // [self.titleLab setText:model.complainClassType];
    NSString *str=[_timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *timeStr=[NSDate getYearMonthDayTimes];
    if ([str isEqualToString:timeStr]) {
        self.bgImageView.image=[UIImage imageNamed:@"icon_complain_cell_new"];
    }else{
        self.bgImageView.image=[UIImage imageNamed:@"icon_complain_cell_bg"];
    }
    
    
    if ([model.complainStatus containsString:@"0"] || [model.complainStatus containsString:@"1"]) {
        self.stateLab.text=@"未处理";
        self.stateLab.textColor=RGB(147, 147, 147);
    }else if ([model.complainStatus containsString:@"2"] || [model.complainStatus containsString:@"3"]){
        self.stateLab.text=@"已处理";
        self.stateLab.textColor=RGB(255, 159, 88);
    }
    
    
    
    [self.timeLab setText:_timeStr];
   // [self.stateLab setText:model.complainType];
    [self.contentLab setText:model.complainDescribe ];
    CGFloat labconst =[self getlabelHeiight:model.complainDescribe  label:self.contentLab];
    self.contentLabHeight.constant = labconst;
}


- (CGFloat) getlabelHeiight:(NSString *)labelText label:(UILabel *)label{
    UILabel *tempLabel = [[UILabel alloc]init];
    tempLabel.numberOfLines = 0;
    tempLabel.lineBreakMode = NSLineBreakByCharWrapping;
    tempLabel.textAlignment = NSTextAlignmentLeft;
    tempLabel.text = labelText;
    tempLabel.font = label.font;
    CGSize labelSize = [tempLabel sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height)+1;
    if (height> label.frame.size.height) {
        return height;
    } else{
        return  label.frame.size.height;
        
    }
}

@end
