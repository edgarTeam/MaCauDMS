//
//  PlaceTableViewCell.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/15.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _chooseImage.hidden=YES;

    
    self.backgroundColor=[UIColor clearColor];
//    self.centerView.layer.masksToBounds=YES;
//    self.centerView.layer.cornerRadius=5.0;
}
- (IBAction)chooseBtnAction:(UIButton *)btn {
//    if (btn.selected==YES) {
//        _chooseImage.hidden=NO;
//    }else{
//        _chooseImage.hidden=YES;
//    }
    [self.delegate didClickBtn:btn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        _chooseImage.hidden=NO;
//    }else{
//        _chooseImage.hidden=YES;
//    }

    // Configure the view for the selected state
}
- (void)setUpModel:(Place *)model{
    _placeTitleLab.font=[UIFont systemFontOfSize:16];
    _describeLab.font=[UIFont systemFontOfSize:13];
    [self.placeTitleLab setText:model.placeName];
    [self.describeLab setText:model.placeIntroduction];
    if ([model.placeName containsString:@"篮球"]) {
        self.placeIconImage.image=[UIImage imageNamed:@"icon_place_basketball"];
    }else if ([model.placeName containsString:@"羽毛球"]) {
        self.placeIconImage.image=[UIImage imageNamed:@"icon_place_badminton"];
    }else if ([model.placeName containsString:@"KTV"]) {
        self.placeIconImage.image=[UIImage imageNamed:@"icon_place_ktv"];
    }else if ([model.placeName containsString:@"足球"]) {
        self.placeIconImage.image=[UIImage imageNamed:@"icon_place_football"];
    }else if ([model.placeName containsString:@"高尔夫"]) {
        self.placeIconImage.image=[UIImage imageNamed:@"icon_place_golf"];
    }
    
    
//        if (model.images.count==0 || model.images==nil || [model.images isKindOfClass:[NSNull class]]) {
//            return;
//        }
//        NSMutableArray *imageArr=[NSMutableArray new];
//        NSMutableArray *imageThumbnailArr=[NSMutableArray new];
//        for (NoticeSubList *notice in model.images) {
//            if (notice.imageUrl !=nil) {
//                [imageArr addObject:notice.imageUrl];
//            }
//            if (notice.imageThumbnail !=nil) {
//                [imageThumbnailArr addObject:notice.imageThumbnail];
//            }
//        }
//        if (imageArr.count ==0 || imageArr==nil) {
//            return;
//        }
//        if (imageThumbnailArr.count ==0 || imageThumbnailArr==nil) {
//            return;
//        }
//        NSString *imageStr=[imageArr componentsJoinedByString:@","];
//        NSString *imageThumbStr=[imageThumbnailArr componentsJoinedByString:@","];
//    
//        NSArray *imageSegmentArr=[imageStr componentsSeparatedByString:@","];
//        NSArray *imageThumbSegmentArr=[imageThumbStr componentsSeparatedByString:@","];
//        [self.placeImage sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbSegmentArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            [self.placeImage sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageSegmentArr[0]]] placeholderImage:image];
//        }];
}
@end
