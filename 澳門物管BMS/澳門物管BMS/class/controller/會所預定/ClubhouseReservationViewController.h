//
//  ClubhouseReservationViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"
#import "Place.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClubhouseReservationViewController : BaseViewController
@property (nonatomic,strong)NSString *keyword;
@property (nonatomic,strong) NSString *placeId;
@property (nonatomic,strong) NSString *placeName;

@property (nonatomic,strong) Place *selectedPlace;

- (void)setSelectedPlace:(Place *)place;
@end

NS_ASSUME_NONNULL_END
