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
#import "NSDate+Utils.h"
@interface NoticeTableViewCell()
@property (nonatomic,strong) NSString *timeStr;
@end

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
    if ([model.createTime rangeOfString:@"T"].location !=NSNotFound) {
        _timeStr=[model.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }else{
        _timeStr=model.createTime;
    }
    if (_timeStr.length !=0) {
         _timeStr=[_timeStr substringToIndex:19];
    }
   
    self.timeLab.text=_timeStr;
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
    NSString *imageStr=[_imageUrlArr componentsJoinedByString:@","];
    NSString *imageThumbStr=[_imageThumbnailArr componentsJoinedByString:@","];
    
    
    NSArray *imageSegmentArr=[imageStr componentsSeparatedByString:@","];
    NSArray *imageThumbSegmentArr=[imageThumbStr componentsSeparatedByString:@","];
    
    
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,_imageUrlArr[0]]];
//    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
   // [self.imageView setImage:[UIImage imageNamed:model.noticeImage]];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbSegmentArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageSegmentArr[0]]] placeholderImage:image];
    }];
    
   
}
@end
