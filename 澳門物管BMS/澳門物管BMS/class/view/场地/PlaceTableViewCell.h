//
//  PlaceTableViewCell.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/15.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PlaceTableViewCellDelegate <NSObject>

- (void)didClickBtn:(UIButton *)btn;

@end

@interface PlaceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *placeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *describeLab;
@property (weak, nonatomic) IBOutlet UIImageView *placeIconImage;


@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) id<PlaceTableViewCellDelegate> delegate;
- (void)setUpModel:(Place *)model;
@end

NS_ASSUME_NONNULL_END
