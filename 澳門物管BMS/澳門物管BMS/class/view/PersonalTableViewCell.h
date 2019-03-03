//
//  PersonalTableViewCell.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/3.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *describeLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

- (void)setUpModel:(LeftModel *)model;
@end

NS_ASSUME_NONNULL_END
