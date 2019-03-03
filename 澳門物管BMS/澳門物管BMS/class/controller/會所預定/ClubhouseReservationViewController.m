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
#import "PlaceViewController.h"
#import "TimeCollectionViewCell.h"
@interface ClubhouseReservationViewController ()<UITableViewDelegate,UITableViewDataSource,LSXPopMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *plateBtn;
@property (nonatomic,strong)LSXPopMenu *plateMenu;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
@property (nonatomic,strong) NSMutableArray *selectIndexs;
@property (nonatomic,strong) NSMutableArray *placeList;
@property (nonatomic,strong) NSMutableArray *placeIdArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) PlaceRecord *placeRecord;

@property (weak, nonatomic) IBOutlet UIButton *orderDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic,strong) NSMutableArray *strArr;
@property (nonatomic,strong) NSMutableArray *compareArr;
@property (nonatomic,strong) NSMutableArray *cancelArr;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *dateTimeStr;//预定日期
@property (weak, nonatomic) IBOutlet UILabel *plateNameTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *plateOrderDateLab;
@property (weak, nonatomic) IBOutlet UILabel *plateChooseTimeLab;




@property (weak, nonatomic) IBOutlet UICollectionView *timeCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;


@end
static NSString * const cellIdentifier = @"TimeCollectionViewCell";
@implementation ClubhouseReservationViewController
{
    //NSArray *dataSource;
    //NSString *placeId;
//    NSArray *placeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.title=@"會所預定";
    self.title=LocalizedString(@"string_reservation_place_title");

   // self.edgesForExtendedLayout=UIRectEdgeNone;
    [self createView];
}

- (void)createView {
    _strArr=[NSMutableArray new];
    _compareArr=[NSMutableArray new];
    _cancelArr=[NSMutableArray new];
    _selectIndexs=[NSMutableArray new];
    NSArray *source=@[@"00:00~02:00",@"02:00~04:00",@"04:00~06:00",@"06:00~08:00",@"08:00~10:00",@"10:00~12:00",@"12:00~14:00",@"14:00~16:00",@"16:00~18:00",@"18:00~20:00",@"20:00~22:00",@"22:00~00:00"];
    _dataSource=[source mutableCopy];
    
    _plateNameTitleLab.text=LocalizedString(@"string_plate_name_title");
    _plateOrderDateLab.text=LocalizedString(@"string_plate_order_date_title");
    _plateChooseTimeLab.text=LocalizedString(@"string_plate_choose_time_title");
    
    _orderDateBtn.layer.masksToBounds = YES;
    _orderDateBtn.layer.cornerRadius = 5.0;
    _orderDateBtn.layer.borderColor = RGB(63, 114, 156).CGColor;
    _orderDateBtn.layer.borderWidth =1.0;
    _plateBtn.layer.masksToBounds = YES;
    _plateBtn.layer.cornerRadius = 5.0;
    _plateBtn.layer.borderColor = RGB(63, 114, 156).CGColor;
    _plateBtn.layer.borderWidth =1.0;
    

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing=15;
    flowLayout.minimumInteritemSpacing=10;
    flowLayout.itemSize=CGSizeMake(105, 45);
  //  flowLayout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _timeCollectionView.collectionViewLayout=flowLayout;
    _timeCollectionView.delegate=self;
    _timeCollectionView.dataSource=self;
    _timeCollectionView.alwaysBounceVertical=YES;
    _timeCollectionView.backgroundColor=[UIColor clearColor];
    [self.timeCollectionView registerNib:[UINib nibWithNibName:@"TimeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TimeCollectionViewCell"];
    
    
    

//    _dateTableView.tableFooterView=[UIView new];
//    _dateTableView.separatorInset=UIEdgeInsetsZero;
//    _dateTableView.delegate=self;
//    _dateTableView.dataSource=self;
//
//    NSLog(@"%lu",_strArr.count);
//    [_dateTableView reloadData];
    //  [self reuqestPlateList];
    
//    if (![self login]) {
//        return;
//    }
}


- (void)requestAddPlaceRecord{

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
//        int time=[[arr lastObject] intValue]+2;
//        NSString *lastTime=[NSString stringWithFormat:@"%d",time];
//        NSString *resultStr=[NSString stringWithFormat:@"0%@",lastTime];
//        [arr addObject:resultStr];
        for (int i=0; i<arr.count; i++) {
            NSString *time=[arr[i] stringByAppendingString:@":00:00"];
            [resultArr addObject:time];
            NSLog(@"%@",resultArr[i]);
        }
        stratTime=[resultArr firstObject];
        NSString *lastTime= [[resultArr lastObject] substringToIndex:2];
        int time=[lastTime intValue]+2;
        NSString *resultStr=[NSString stringWithFormat:@"%d",time];
        if (resultStr.length==1) {
            endTime=[NSString stringWithFormat:@"0%@:00:00",resultStr];
        }else{
            endTime=[resultStr stringByAppendingString:@":00:00"];
        }
      //  endTime=[resultArr lastObject];
//        endTime=[resultStr stringByAppendingString:@":00:00"];
    }else if (_strArr.count ==1){
        stratTime=[[_strArr lastObject] stringByAppendingString:@":00:00"];
        int end=[[_strArr lastObject] intValue]+02;
        NSString *timeStr=[@"0" stringByAppendingString:[NSString stringWithFormat:@"%d",end]];
        endTime=[timeStr stringByAppendingString:@":00:00"];
    }else{
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_title")];
        return;
    }

    if (_dateTimeStr.length ==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_date_title")];
        return;
    }
//    for (int j=0; j<arr.count; j++) {
//        arr[j]=[arr[j] componentsSeparatedByString:@":00:00"];
//    }
    if (_placeId.length==0) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_place_title")];
        return;
    }
    
    NSString *orderDateStr=[NSString stringWithFormat:@"%@ %@",_dateTimeStr,stratTime];
    
    NSDictionary *para=@{
                         @"orderDate":orderDateStr,
                         @"placeId":_placeId,
                         @"orderStartTime":stratTime,
                         @"orderEndTime":endTime
                         };

//    NSString *temp=[NSString stringWithFormat:@"{\"orderDate\":\"%@\",\"placeId\":\"%@\",\"orderStartTime\":\"%@\",\"orderEndTime\":\"%@\"}",_dateTimeStr,placeId,stratTime,endTime];
//    NSData *jsonData=[temp dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
    
    [[HttpHelper shareHttpHelper] postWithUrl:kAddPlaceRecord body:jsonData showLoading:YES success:^(NSDictionary *resultDic){
        if (resultDic ==nil) {
            return ;
        }
                [CommonUtil isRequestOK:resultDic];
        int code=[[resultDic objectForKey:@"code"] intValue];
                if (code !=200) {
                    return ;
                }
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:LocalizedString(@"string_add_record_title") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAc=[UIAlertAction actionWithTitle:LocalizedString(@"String_confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:alertAc];
        [self presentViewController:alert animated:YES completion:nil];
//        [ZKAlertTool showAlertWithMsg:@"您已經成功預定了會所"];
//             //   _placeRecord=[PlaceRecord mj_objectWithKeyValues:resultDic[@"data"]];
//        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error){
        
    }];
}


- (IBAction)plateBtnAction:(UIButton *)sender {
    
   // self.plateMenu=[LSXPopMenu showRelyOnView:sender titles:_placeList icons:nil menuWidth:100 isShowTriangle:YES delegate:self];
    
    PlaceViewController *placeVC=[PlaceViewController new];
//    placeVC.placeNameBlock=^(NSString *placeName, NSString *placeID){
//        placeId=placeID;
//        [self.plateBtn setTitle:placeName forState:UIControlStateNormal];
//    };
    [self presentViewController:placeVC animated:YES completion:nil];
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
//    [selectDateVC setDidSelectData:^(NSDate *date, NSDate *time, NSString *timeStr) {
//       // _dateTimeStr=timeStr;
//    //    [self.orderDateBtn setTitle:timeStr forState:UIControlStateNormal];
//        _dateTimeStr=[NSDate stringFromDateToDateTimeString:timeStr];
//        [self.orderDateBtn setTitle:[NSDate stringNransformDateAndTimeString:timeStr] forState:UIControlStateNormal];
//    }];
    [selectDateVC setSelectDate:^(NSDate *date,NSString *timeStr){
        _dateTimeStr=[NSDate stringFromDateToDateString:timeStr];
        [self.orderDateBtn setTitle:[NSDate stringNransformDateString:timeStr] forState:UIControlStateNormal];
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


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    // NSLog(@"data的個數%ld",_dataSource.count);
//    return _dataSource.count;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *IDentified=@"cell";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IDentified];
//    if (cell == nil) {
//        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDentified];
//    }
//
//    cell.backgroundColor=[UIColor clearColor];
//    cell.textLabel.textColor=RGB(230, 230, 230);
//    if (_strArr.count==0 || _strArr==nil) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//   // cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.textLabel.text=_dataSource[indexPath.row];
//    NSLog(@"%@",cell.textLabel.text);
//
//    return cell;
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//       // [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
////        [_strArr removeObject:<#(nonnull id)#>];
//            NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
//            NSArray *arr=[_strArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
//                int a=[obj1 intValue];
//                int b=[obj2 intValue];
//                if (a >b) {
//                    return NSOrderedDescending;
//                }else{
//                    return NSOrderedAscending;
//                }
//            }];
//        NSInteger index=[arr indexOfObject:str];
//        NSLog(@"%ld",index);
//        if (index==0) {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            [_strArr removeObject:str];
//            return;
//        }
//        if (index==arr.count-1) {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            [_strArr removeObject:str];
//            return;
//        }
//        if ([arr[index+1] intValue]-[arr[index-1] intValue]==4) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_cancel_title")];
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            [_strArr removeObject:str];
//        }
//
//      //  [_strArr removeObject:_strArr.lastObject];
////        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
////        NSMutableArray *removeArr=[NSMutableArray new];
////        removeArr=[_strArr mutableCopy];
////        if ([removeArr containsObject:str]) {
////           _index=[removeArr indexOfObject:str];
////            [removeArr removeObjectAtIndex:_index];
////        }
////        for (int i=0; i<removeArr.count-1; i++) {
////
////            [_cancelArr addObject:[NSString stringWithFormat:@"%d", [removeArr.lastObject intValue]-[removeArr[i] intValue]]];
////            NSLog(@"数组个数%ld",_cancelArr.count);
////            NSLog(@"%@",_cancelArr[i]);
////            if ([_cancelArr containsObject:@"4"] ||[_cancelArr containsObject:@"-4"]) {
////                if ([_cancelArr containsObject:@"2"]) {
////                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//////                     cell.accessoryType = UITableViewCellAccessoryNone;
////                }else{
//////                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
////                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
////                   // [_cancelArr removeObject:_cancelArr.lastObject];
////                   // [_strArr removeObject:_strArr.lastObject];
////                    [_strArr removeObjectAtIndex:_index];
////                }
////            }else{
////                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////            }
////        }
//    }else { //未选中
////        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////        [_selectIndexs addObject:@(indexPath.row)]; //添加索引数据到数组
////        if (_selectIndexs.count >=2) {
////            NSIndexPath *i;
////            i=[_selectIndexs objectAtIndex:_selectIndexs.count-2];
////            NSMutableArray *vArr=[NSMutableArray new];
////            for (int z=0; z<_selectIndexs.count; z++) {
////                int j=[_selectIndexs.lastObject intValue]-[[_selectIndexs objectAtIndex:z] intValue];
////                //  NSString *str=[NSString stringWithFormat:@"%d",j];
////                [vArr addObject:[NSString stringWithFormat:@"%d",j]];
////
////            }
////            if ([vArr containsObject:@"2"]) {
////                if ([vArr containsObject:@"1"]){
////                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////                    [_selectIndexs addObject:@(indexPath.row)];
////                }else{
////                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
////                    [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
////                }
////            }
////
////        }
//
////        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
////        [_strArr addObject:str];
////
////        if (_strArr.count>=2) {
////            if ([_strArr.lastObject intValue]-[_strArr[_strArr.count-2] intValue]==4) {
////                cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
////                [_strArr removeObject:_strArr.lastObject];
////            }else{
////                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////            }
////        }else{
////            cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////        }
//
//        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
//        [_strArr addObject:str];
//
//        if (_strArr.count>=2) {
//          //  int nub=_compareArr[_compareArr.count-_strArr.count];
//           // NSLog(@"个数为%d",nub);
//            [_compareArr removeAllObjects];
//            for (int i=0; i<_strArr.count-1; i++) {
//
//                [_compareArr addObject:[NSString stringWithFormat:@"%d", [_strArr.lastObject intValue]-[_strArr[i] intValue]]];
//
//            }
////            if ([_compareArr containsObject:@"4"] ||[_compareArr containsObject:@"-4"]) {
////                if ([_compareArr containsObject:@"2"] ||[_compareArr containsObject:@"-2"]) {
////                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////
////                }else{
////                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
////                    //   [_compareArr removeAllObjects];
////                    [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_choose_title")];
////                    [_strArr removeObject:_strArr.lastObject];
////                }
////            }else{
////                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
////
////            }
//            if ([_compareArr containsObject:@"2"] ||[_compareArr containsObject:@"-2"]) {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//            }else{
//                cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//                //   [_compareArr removeAllObjects];
//                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_choose_title")];
//                [_strArr removeObject:_strArr.lastObject];
//            }
//        }else{
//             cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//        }
//
//
//
//
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 40;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TimeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TimeCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TimeCollectionViewCell" owner:self options:nil] lastObject];
    }
    cell.isChoosed=NO;
    cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_no"];
    cell.contentLab.text=_dataSource[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TimeCollectionViewCell *cell=(TimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (cell.isChoosed==NO) {
        NSString *str=[_dataSource[indexPath.row] substringToIndex:2];
        [_strArr addObject:str];

        if (_strArr.count>=2) {
            [_compareArr removeAllObjects];
            for (int i=0; i<_strArr.count-1; i++) {
        
                [_compareArr addObject:[NSString stringWithFormat:@"%d", [_strArr.lastObject intValue]-[_strArr[i] intValue]]];
        
            }
        
            if ([_compareArr containsObject:@"2"] ||[_compareArr containsObject:@"-2"]) {
                           // cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
                cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_yes"];
                cell.isChoosed=YES;
            }else{
                cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_no"];
                cell.isChoosed=NO;
                            //   [_compareArr removeAllObjects];
                [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_choose_title")];
                [_strArr removeObject:_strArr.lastObject];
                        }
        }else{
            cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_yes"];
            cell.isChoosed=YES;
                        // cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        }
        
    }else if (cell.isChoosed==YES){
                //cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
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
                    cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_no"];
                    cell.isChoosed=NO;
                    [_strArr removeObject:str];
                     self.timeLab.text=[NSString stringWithFormat:@"您已经选择%lu小时",_strArr.count*2];
                    return;
                }
                if (index==arr.count-1) {
                    //cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_no"];
                    cell.isChoosed=NO;
                    [_strArr removeObject:str];
                     self.timeLab.text=[NSString stringWithFormat:@"您已经选择%lu小时",_strArr.count*2];
                    return;
                }
                if ([arr[index+1] intValue]-[arr[index-1] intValue]==4) {
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_yes"];
                    cell.isChoosed=YES;
                    [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_place_alert_time_cancel_title")];
                }else{
                    cell.bgImageView.image=[UIImage imageNamed:@"icon_place_time_choose_no"];
                   // cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.isChoosed=NO;
                    [_strArr removeObject:str];
                }
    }
    self.timeLab.text=[NSString stringWithFormat:@"您已经选择%lu小时",_strArr.count*2];
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
[self.plateBtn setTitle:_placeName forState:UIControlStateNormal];

    [self checkLogin];
  //  [self createView];
    [self reuqestPlateList];
}

#pragma mark LSXPopMenuDelegate
- (void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.plateBtn setTitle:_placeList[index] forState:UIControlStateNormal];
    _placeId=_placeIdArr[index];
}
@end
