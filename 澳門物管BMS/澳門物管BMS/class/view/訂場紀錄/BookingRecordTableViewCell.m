//
//  BookingRecordTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BookingRecordTableViewCell.h"
@interface BookingRecordTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end
@implementation BookingRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _image.layer.masksToBounds=YES;
    _image.layer.cornerRadius=10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpModel:(Place *)model{
    [_contentLab setText:model.placeIntroduction];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,model.placeImage]];
    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
    
}

- (void)setUpPlaceRecord:(PlaceRecord *)model{
    
}
@end
