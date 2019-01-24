//
//  ClubhouseReservationViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ClubhouseReservationViewController.h"
#import "LSXPopMenu.h"
#import "Place.h"
#import "PlaceRecord.h"
#import "HttpHelper.h"
#import "ZKAlertTool.h"
#import "SelectDatePickerController.h"
#import "NSDate+Utils.h"
@interface ClubhouseReservationViewController ()<UITableViewDelegate,UITableViewDataSource,LSXPopMenuDelegate>
@property (weak, nonatomic) IBOutlet UIButton *plateBtn;
@property (nonatomic,strong)LSXPopMenu *plateMenu;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
@property (nonatomic,strong) NSMutableArray *selectIndexs;
@property (nonatomic,strong) NSMutableArray *placeList;
@property (nonatomic,strong) NSMutableArray *placeIdArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) PlaceRecord *placeRecord;

@property (weak, nonatomic) IBOutlet UIButton *orderDateBtn;

@property (nonatomic,strong) NSMutableArray *strArr;
@property (nonatomic,strong) NSMutableArray *compareArr;
@property (nonatomic,strong) NSMutableArray *cancelArr;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *dateTimeStr;//预定日期
@end

@implementation ClubhouseReservationViewController
{
    //NSArray *dataSource;
    NSString *placeId;
//    NSArray *placeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.title=@"會所預定";
    self.title=LocalizedString(@"string_reservation_place_title");

    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self createView];
}

- (void)createView {
    _strArr=[NSMutableArray new];
    _compareArr=[NSMutableArray new];
    _cancelArr=[NSMutableArray new];
    _selectIndexs=[NSMutableArray new];
    NSArray *source=@[@"00:00~02:00",@"02:00~04:00",@"04:00~06:00",@"06:00~08:00",@"08:00~10:00",@"10:00~12:00",@"12:00~14:00",@"14:00~16:00",@"16:00~18:00",@"18:00~20:00",@"20:00~22:00",@"22:00~00:00"];
    _dataSource=[source mutableCopy];
    // _dateTableView=[[UITableView alloc] init];
    _dateTableView.tableFooterView=[UIView new];
    _dateTableView.delegate=self;
    _dateTableView.dataSource=self;
    [_dateTableView reloadData];
    //  [self reuqestPlateList];
    
//    if (![self login]) {
//        return;
//    }
}


- (void)requestAddPlaceRecord{
//    NSMutableArray *resultArr=[NSMutableArray new];
//    for (int i=0; i<_selectIndexs.count; i++) {
//
//     NSString *str1=  _dataSource[[_selectIndexs[i] intValue]];
//        NSString *str=[str1 stringByReplacingOccurrencesOfString:@"~" withString:@""];
//        NSString *handlerStr=[str stringByReplacingOccurrencesOfString:@":" withString:@""];
//        NSString *resultStr=[handlerStr substringToIndex:2];
//        [resultArr addObject:resultStr];
//    }
//    NSArray *arr=[resultArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
//        int a=[obj1 intValue];
//        int b=[obj2 intValue];
//        if (a >b) {
//            return NSOrderedDescending;
//        }else{
//            return NSOrderedAscending;
//        }
//
//    }];
//    NSInteger indexFirst = 0;
//    NSInteger indexLast = 0;
//    if ([resultArr containsObject:arr[0]]) {
//        indexFirst=[resultArr indexOfObject:arr[0]];
//    }
//    if ([resultArr containsObject:arr[arr.count-1]]) {
//        indexLast=[resultArr indexOfObject:arr[arr.count-1]];
//    }
    NSMutableArray *arr=[NSMutableArray new];
    NSMutableArray *resultArr=[NSMutableArray new];
    NSString *stratTime;
    NSString *endTime;
    if (_strArr.count >=2) {
        
        arr=[_strArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
            int a=[obj1 intValue];
            int b=[obj2 intValue];
            if (a >b) {
                return NSOrderedDescending;
            }else{
                return NSOrderedAscending;
            }
        }];
        
        for (int i=0; i<arr.count; i++) {
            NSString *time=[arr[i] stringByAppendingString:@":00:00"];
            [resultArr addObject:time];
            NSLog(@"%@",resultArr[i]);
        }
        stratTime=[resultArr firstObject];
        endTime=[resultArr lastObject];
        
    }else if (_strArr.count ==1){
        stratTime=[[_strArr lastObject] stringByAppendingString:@":00:00"];
        int end=[[_strArr lastObject] intValue]+2;
        endTime=[[NSString stringWithFormat:@"%d",end] stringByAppendingString:@":00:00"];
    }else{
        [ZKAlertTool showAlertWithMsg:@"请选择时间分段"];
        return;
    }

    if (_dateTimeStr.length ==0) {
        [ZKAlertTool showAlertWithMsg:@"請選擇日期"];
        return;
    }
//    for (int j=0; j<arr.count; j++) {
//        arr[j]=[arr[j] componentsSeparatedByString:@":00:00"];
//    }
    if (placeId.length==0) {
        [ZKAlertTool showAlertWithMsg:@"请选择會所類型"];
        return;
    }
    
    
    
    NSDictionary *para=@{
                         @"orderDate":_dateTimeStr,
                         @"placeId":placeId,
                         @"orderStartTime":stratTime,
                         @"orderEndTime":endTime
                         };

    NSError *error =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
    
    [[HttpHelper shareHttpHelper] postWithUrl:kAddComplain body:jsonData showLoading:YES success:^(NSDictionary *resultDic){
                [CommonUtil isRequestOK:resultDic];
                if (resultDic ==nil) {
                    return ;
                }
             //   _placeRecord=[PlaceRecord mj_objectWithKeyValues:resultDic[@"data"]];
    } failure:^(NSError *error){
        
    }];
}


- (IBAction)plateBtnAction:(UIButton *)sender {
    self.plateMenu=[LSXPopMenu showRelyOnView:sender titles:_placeList icons:nil menuWidth:100 isShowTriangle:YES delegate:self];
}

- (IBAction)submitBtn:(id)sender {
    [self requestAddPlaceRecord];
}

#pragma mark 場所列表
- (void)reuqestPlateList {
//    NSDictionary *para=@{
//                         @"keyword":self.keyword
//                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlaceList:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
         NSMutableArray *array=[dic objectForKey:@"list"];
       
        NSMutableArray *placeArr=[NSMutableArray new];
        placeArr=[Place mj_objectArrayWithKeyValuesArray:array];
        _placeList=[NSMutableArray new];
        _placeIdArr=[NSMutableArray new];
        if (placeArr.count ==0 || placeArr ==nil) {
            return;
        }
        for (Place *place in placeArr) {
            [_placeList addObject:place.placeName];
            [_placeIdArr addObject:place.placeId];
        }
    }];
    
    
}

- (IBAction)dateBtnAction:(id)sender {
    SelectDatePickerController *selectDateVC=[SelectDatePickerController new];
    [selectDateVC setDidSelectData:^(NSDate *date, NSDate *time, NSString *timeStr) {
       // _dateTimeStr=timeStr;
    //    [self.orderDateBtn setTitle:timeStr forState:UIControlStateNormal];
        _dateTimeStr=[NSDate stringFromDateToDateTimeString:timeStr];
        [self.orderDateBtn setTitle:[NSDate stringNransformDateAndTimeString:timeStr] forState:UIControlStateNormal];
    }];
    [self presentViewController:selectDateVC animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"data的個數%ld",_dataSource.count);
    return _dataSource.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDentified=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IDentified];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDentified];
    }
    cell.textLabel.text=_dataSource[indexPath.row];
    NSLog(@"%@",cell.textLabel.text);

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
       // [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
//        [_strArr removeObject:<#(nonnull id)#>];
            NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
            NSArray *arr=[_strArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
                int a=[obj1 intValue];
                int b=[obj2 intValue];
                if (a >b) {
                    return NSOrderedDescending;
                }else{
                    return NSOrderedAscending;
                }
            }];
        NSInteger index=[arr indexOfObject:str];
        NSLog(@"%ld",index);
        if (index==0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [_strArr removeObject:str];
            return;
        }
        if (index==arr.count-1) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [_strArr removeObject:str];
            return;
        }
        if ([arr[index+1] intValue]-[arr[index-1] intValue]==4) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [ZKAlertTool showAlertWithMsg:@"您不能取消这行，因为间隔了2小时"];
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            [_strArr removeObject:str];
        }
        
      //  [_strArr removeObject:_strArr.lastObject];
//        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
//        NSMutableArray *removeArr=[NSMutableArray new];
//        removeArr=[_strArr mutableCopy];
//        if ([removeArr containsObject:str]) {
//           _index=[removeArr indexOfObject:str];
//            [removeArr removeObjectAtIndex:_index];
//        }
//        for (int i=0; i<removeArr.count-1; i++) {
//
//            [_cancelArr addObject:[NSString stringWithFormat:@"%d", [removeArr.lastObject intValue]-[removeArr[i] intValue]]];
//            NSLog(@"数组个数%ld",_cancelArr.count);
//            NSLog(@"%@",_cancelArr[i]);
//            if ([_cancelArr containsObject:@"4"] ||[_cancelArr containsObject:@"-4"]) {
//                if ([_cancelArr containsObject:@"2"]) {
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////                     cell.accessoryType = UITableViewCellAccessoryNone;
//                }else{
////                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//                   // [_cancelArr removeObject:_cancelArr.lastObject];
//                   // [_strArr removeObject:_strArr.lastObject];
//                    [_strArr removeObjectAtIndex:_index];
//                }
//            }else{
//                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//            }
//        }
    }else { //未选中
//        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//        [_selectIndexs addObject:@(indexPath.row)]; //添加索引数据到数组
//        if (_selectIndexs.count >=2) {
//            NSIndexPath *i;
//            i=[_selectIndexs objectAtIndex:_selectIndexs.count-2];
//            NSMutableArray *vArr=[NSMutableArray new];
//            for (int z=0; z<_selectIndexs.count; z++) {
//                int j=[_selectIndexs.lastObject intValue]-[[_selectIndexs objectAtIndex:z] intValue];
//                //  NSString *str=[NSString stringWithFormat:@"%d",j];
//                [vArr addObject:[NSString stringWithFormat:@"%d",j]];
//
//            }
//            if ([vArr containsObject:@"2"]) {
//                if ([vArr containsObject:@"1"]){
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//                    [_selectIndexs addObject:@(indexPath.row)];
//                }else{
//                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//                    [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
//                }
//            }
//
//        }
       
//        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
//        [_strArr addObject:str];
//
//        if (_strArr.count>=2) {
//            if ([_strArr.lastObject intValue]-[_strArr[_strArr.count-2] intValue]==4) {
//                cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//                [_strArr removeObject:_strArr.lastObject];
//            }else{
//                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//            }
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//        }
       
        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
        [_strArr addObject:str];
      
        if (_strArr.count>=2) {
          //  int nub=_compareArr[_compareArr.count-_strArr.count];
           // NSLog(@"个数为%d",nub);
            [_compareArr removeAllObjects];
            for (int i=0; i<_strArr.count-1; i++) {
                
                [_compareArr addObject:[NSString stringWithFormat:@"%d", [_strArr.lastObject intValue]-[_strArr[i] intValue]]];
                NSLog(@"数组个数%ld",_compareArr.count);
                NSLog(@"%@",_compareArr[i]);
                
//              //  NSString *num=[_compareArr objectAtIndex:_compareArr.lastObject];
//                NSString *num=[_compareArr lastObject];
//                NSLog(@"num值为%@",num);
//                [numArr addObject:num];
//                NSLog(@"个数是：：：%ld",numArr.count);
//                NSLog(@"值是%@",numArr[i]);
//                if ([_compareArr containsObject:@"4"] ||[_compareArr containsObject:@"-4"]) {
//                    if ([_compareArr containsObject:@"2"]) {
//                        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//
//                    }else{
//                        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//                     //   [_compareArr removeAllObjects];
//                        [_strArr removeObject:_strArr.lastObject];
//                    }
//                }else{
//                     cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//
//                }
            }
            if ([_compareArr containsObject:@"4"] ||[_compareArr containsObject:@"-4"]) {
                if ([_compareArr containsObject:@"2"] ||[_compareArr containsObject:@"-2"]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
                    
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
                    //   [_compareArr removeAllObjects];
                    [ZKAlertTool showAlertWithMsg:@"您不能选择这行，因为间隔了2小时"];
                    [_strArr removeObject:_strArr.lastObject];
                }
            }else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
                
            }
        }else{
             cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        }
        
        
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
//    if (![self login]) {
//        return;
//    }

    [self checkLogin];
    [self createView];
    [self reuqestPlateList];
}

#pragma mark LSXPopMenuDelegate
- (void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.plateBtn setTitle:_placeList[index] forState:UIControlStateNormal];
    placeId=_placeIdArr[index];
}
@end
