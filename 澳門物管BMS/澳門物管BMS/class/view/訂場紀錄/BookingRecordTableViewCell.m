//
//  BookingRecordTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BookingRecordTableViewCell.h"
#import "NoticeSubList.h"
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
    if (model.images.count==0 || model.images==nil || [model.images isKindOfClass:[NSNull class]]) {
        return;
    }
    NSMutableArray *imageArr=[NSMutableArray new];
    NSMutableArray *imageThumbnailArr=[NSMutableArray new];
    for (NoticeSubList *notice in model.images) {
        if (notice.imageUrl !=nil) {
            [imageArr addObject:notice.imageUrl];
        }
        if (notice.imageThumbnail !=nil) {
            [imageThumbnailArr addObject:notice.imageThumbnail];
        }
    }
    if (imageArr.count ==0 || imageArr==nil) {
        return;
    }
    if (imageThumbnailArr.count ==0 || imageThumbnailArr==nil) {
        return;
    }
    NSString *imageStr=[imageArr componentsJoinedByString:@","];
    NSString *imageThumbStr=[imageThumbnailArr componentsJoinedByString:@","];
    
    NSArray *imageSegmentArr=[imageStr componentsSeparatedByString:@","];
    NSArray *imageThumbSegmentArr=[imageThumbStr componentsSeparatedByString:@","];
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageArr[0]]];
//    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
    [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageSegmentArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbSegmentArr[0]]] placeholderImage:image];
    }];
}

- (void)setUpPlaceRecord:(PlaceRecord *)model{
    
}
@end
