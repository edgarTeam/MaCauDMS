//
//  PersonalTableViewCell.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/3.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpModel:(LeftModel *)model{
    [_titleLab setText:model.title];
    [_bgImageView setImage:[UIImage imageNamed:model.image]];
    [_describeLab setText:model.describe];
}
@end
