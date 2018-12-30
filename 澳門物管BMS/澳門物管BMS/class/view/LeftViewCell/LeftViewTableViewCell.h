//
//  LeftViewTableViewCell.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/30.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LeftViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

- (void)setUpModel:(LeftModel *)model;
@end

NS_ASSUME_NONNULL_END
