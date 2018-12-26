//
//  BaseModel.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/26.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
@property (nonatomic,assign)NSInteger endRow;
@property (nonatomic,assign)NSInteger firstPage;
@property (nonatomic,assign)Boolean hasNextPage;
@property (nonatomic,assign)Boolean hasPreviousPage;
@property (nonatomic,assign)Boolean isFirstPage;
@property (nonatomic,assign)Boolean isLastPage;
@property (nonatomic,assign)NSInteger lastPage;
@property (nonatomic,assign)NSInteger navigatePages;
@property (nonatomic,assign)NSInteger nextPage;
@property (nonatomic,copy)NSString *orderBy;
@property (nonatomic,assign)NSInteger pageNum;
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,assign)NSInteger prePage;
@property (nonatomic,assign)NSInteger size;
@property (nonatomic,assign)NSInteger startRow;
@property (nonatomic,assign)NSInteger total;
@end

NS_ASSUME_NONNULL_END
