//
//  LeftViewTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/30.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "LeftViewTableViewCell.h"

@implementation LeftViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUpModel:(LeftModel *)model{
    [_titleLab setText:model.title];
    [_imgView setImage:[UIImage imageNamed:model.image]];
}


@end
