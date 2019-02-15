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

@interface PlaceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UILabel *placeTitleLab;
- (void)setUpModel:(Place *)model;
@end

NS_ASSUME_NONNULL_END
