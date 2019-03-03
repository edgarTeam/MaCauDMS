//
//  TimeCollectionViewCell.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/3/3.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic)BOOL isChoosed;
@end

NS_ASSUME_NONNULL_END
