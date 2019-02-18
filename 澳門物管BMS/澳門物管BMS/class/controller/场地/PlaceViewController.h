//
//  PlaceViewController.h
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/15.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceViewController : BaseViewController
@property (nonatomic,strong)NSString *placeName;
@property (nonatomic,strong)NSString *placeId;
@property (nonatomic,copy)void(^placeNameBlock)(NSString *placeNameTitle,NSString *placeIdTitle);
@end

NS_ASSUME_NONNULL_END
