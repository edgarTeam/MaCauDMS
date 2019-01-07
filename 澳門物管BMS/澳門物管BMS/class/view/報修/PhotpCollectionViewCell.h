//
//  PhotpCollectionViewCell.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/6.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotpCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@end

NS_ASSUME_NONNULL_END
