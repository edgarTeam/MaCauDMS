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
//@property (weak, nonatomic) IBOutlet UIImageView *image;
//@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLab;
@property (weak, nonatomic) IBOutlet UILabel *updateDateLab;
@property (weak, nonatomic) IBOutlet UILabel *placeOrderTimeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *placeUpdateTimeTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (nonatomic,strong) NSArray *statusArr;
@end
@implementation BookingRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _image.layer.masksToBounds=YES;
//    _image.layer.cornerRadius=10.0;
    _statusArr=@[@"預約取消",@"開始發起",@"預約成功",@"預約失敗"];
    self.backgroundColor=[UIColor clearColor];
    _placeOrderTimeTitleLab.text=LocalizedString(@"string_plate_order_time_title");
    _placeUpdateTimeTitleLab.text=LocalizedString(@"string_plate_update_time_title");
//    self.layer.borderWidth=0.5;
//    self.layer.borderColor=RGB(130, 130, 130).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setUpModel:(Place *)model{
//    [_contentLab setText:model.placeIntroduction];
//    if (model.images.count==0 || model.images==nil || [model.images isKindOfClass:[NSNull class]]) {
//        return;
//    }
//    NSMutableArray *imageArr=[NSMutableArray new];
//    NSMutableArray *imageThumbnailArr=[NSMutableArray new];
//    for (NoticeSubList *notice in model.images) {
//        if (notice.imageUrl !=nil) {
//            [imageArr addObject:notice.imageUrl];
//        }
//        if (notice.imageThumbnail !=nil) {
//            [imageThumbnailArr addObject:notice.imageThumbnail];
//        }
//    }
//    if (imageArr.count ==0 || imageArr==nil) {
//        return;
//    }
//    if (imageThumbnailArr.count ==0 || imageThumbnailArr==nil) {
//        return;
//    }
//    NSString *imageStr=[imageArr componentsJoinedByString:@","];
//    NSString *imageThumbStr=[imageThumbnailArr componentsJoinedByString:@","];
//    
//    NSArray *imageSegmentArr=[imageStr componentsSeparatedByString:@","];
//    NSArray *imageThumbSegmentArr=[imageThumbStr componentsSeparatedByString:@","];
////    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImageUrl,imageArr[0]]];
////    [self.image sd_setImageWithURL:url placeholderImage:kEMPTYIMAGE];
//    [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageThumbSegmentArr[0]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        [self.image sd_setImageWithURL:[NSURL URLWithString:[kBaseImageUrl stringByAppendingPathComponent:imageSegmentArr[0]]] placeholderImage:image];
//    }];
//}

- (void)setUpPlaceRecord:(PlaceRecord *)model{
    _placeNameLab.font=[UIFont systemFontOfSize:15];
    _orderDateLab.font=[UIFont systemFontOfSize:12];
    _detailLab.font=[UIFont systemFontOfSize:12];
    
    _placeNameLab.text=model.place.placeName;
//    if (model.recordStatus !=nil) {
//         _statusLab.text=_statusArr[[model.recordStatus intValue] +1];
//    }
   
    NSString *timeStr;
   if (model.orderDate.length >10) {
         timeStr=[model.orderDate substringToIndex:10];
    }
    if (model.orderStartTime.length ==0) {
        return;
    }
    if (model.orderEndTime.length ==0) {
        return;
    }
    _orderDateLab.text=timeStr;
//    _orderDateLab.text=[NSString stringWithFormat:@"%@ %@~%@",timeStr,[model.orderStartTime substringToIndex:5],[model.orderEndTime substringToIndex:5]];
//    if (model.updateTime.length >0) {
//        _updateDateLab.text=[model.updateTime substringToIndex:10];
//    }
    
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
