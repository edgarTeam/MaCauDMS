//
//  NoticeTableViewCell.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/26.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "Notice.h"
#import "NoticeSubList.h"
@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _image.layer.masksToBounds=YES;
    _image.layer.cornerRadius=8.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpModel:(Notice *)model{
   // [self.image];
    self.timeLab.text=model.createTime;
    self.contentLab.text=model.noticeTitle;
    if (model.noticeImage.count==0 || model.noticeImage==nil || [model.noticeImage isKindOfClass:[NSNull class]]) {
        return;
    }
    _imageThumbnailArr=[NSMutableArray new];
    _imageUrlArr=[NSMutableArray new];
    for (NoticeSubList *notice in model.noticeImage) {
        [_imageUrlArr addObject:notice.imageUrl];
        [_imageUrlArr addObject:notice.imageThumbnail];
    }
    if (_imageThumbnailArr.count ==0 || _imageThumbnailArr ==nil || [_imageThumbnailArr isKindOfClass:[NSNull class]]) {
        return;
    }
    if (_imageUrlArr.count ==0 || _imageUrlArr ==nil || [_imageUrlArr isKindOfClass:[NSNull class]]) {
        return;
    }
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,_imageUrlArr[0]]];
//    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
   // [self.imageView setImage:[UIImage imageNamed:model.noticeImage]];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:_imageUrlArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:_imageThumbnailArr[0]]] placeholderImage:image];
    }];
    
   
}
@end
