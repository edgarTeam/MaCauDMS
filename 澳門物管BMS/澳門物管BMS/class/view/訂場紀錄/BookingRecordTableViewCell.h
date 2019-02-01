//
//  BookingRecordTableViewCell.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceRecord.h"
#import "Place.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookingRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

- (void)setUpModel:(Place *)model;
- (void)setUpPlaceRecord:(PlaceRecord *)model;
@end

NS_ASSUME_NONNULL_END
