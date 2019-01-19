//
//  NoticeTableViewCell.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/26.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notice.h"
NS_ASSUME_NONNULL_BEGIN

@interface NoticeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic,strong)NSMutableArray *noticeImgArr;
@property (nonatomic,strong)NSMutableArray *imageThumbnailArr;
@property (nonatomic,strong)NSMutableArray *imageUrlArr;
- (void)setUpModel:(Notice *)model;
@end

NS_ASSUME_NONNULL_END
