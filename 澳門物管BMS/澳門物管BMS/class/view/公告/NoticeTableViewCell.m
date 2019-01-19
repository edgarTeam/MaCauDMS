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
    _noticeImgArr=[NSMutableArray new];
    _noticeImgArr=model.noticeImage;
    _imageThumbnailArr=[NSMutableArray new];
    _imageUrlArr=[NSMutableArray new];
    for (NoticeSubList *notice in _noticeImgArr) {
        [_imageUrlArr addObject:notice.imageUrl];
        [_imageUrlArr addObject:notice.imageThumbnail];
    }
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,_imageUrlArr[0]]];
    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
   // [self.imageView setImage:[UIImage imageNamed:model.noticeImage]];
    self.timeLab.text=model.createTime;
    self.contentLab.text=model.noticeTitle;
}
@end
