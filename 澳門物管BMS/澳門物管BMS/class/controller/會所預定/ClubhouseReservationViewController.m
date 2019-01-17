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
@interface ClubhouseReservationViewController ()<UITableViewDelegate,UITableViewDataSource,LSXPopMenuDelegate>
@property (weak, nonatomic) IBOutlet UIButton *plateBtn;
@property (nonatomic,strong)LSXPopMenu *plateMenu;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
@property (nonatomic,strong) NSMutableArray *selectIndexs;
@property (nonatomic,strong) NSMutableArray *placeList;
@property (nonatomic,strong) NSMutableArray *placeIdArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) PlaceRecord *placeRecord;
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


    _selectIndexs=[NSMutableArray new];
    NSArray *source=@[@"00:00~02:00",@"02:00~04:00",@"04:00~06:00",@"06:00~08:00",@"08:00~10:00",@"10:00~12:00",@"12:00~14:00",@"14:00~16:00",@"16:00~18:00",@"18:00~20:00",@"20:00~22:00",@"22:00~00:00"];
    _dataSource=[source mutableCopy];
   // _dateTableView=[[UITableView alloc] init];
    _dateTableView.tableFooterView=[UIView new];
    _dateTableView.delegate=self;
    _dateTableView.dataSource=self;
    [_dateTableView reloadData];
  //  [self reuqestPlateList];
    if (![self login]) {
        return;
    }
}

- (void)createView {
    
}


- (void)requestAddPlaceRecord{
    NSMutableArray *resultArr=[NSMutableArray new];
    for (int i=0; i<_selectIndexs.count; i++) {
       //dataSource[]
     NSString *str1=  _dataSource[[_selectIndexs[i] intValue]];
        NSString *str=[str1 stringByReplacingOccurrencesOfString:@"~" withString:@""];
//        NSString *str=[_dataSource[_selectIndexs[i]] stringByReplacingOccurrencesOfString:@"~" withString:@""];
        NSString *handlerStr=[str stringByReplacingOccurrencesOfString:@":" withString:@""];
        NSString *resultStr=[handlerStr substringToIndex:2];
        [resultArr addObject:resultStr];
    }
    NSArray *arr=[resultArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
        int a=[obj1 intValue];
        int b=[obj2 intValue];
        if (a >b) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
       
    }];
    NSInteger indexFirst = 0;
    NSInteger indexLast = 0;
    if ([resultArr containsObject:arr[0]]) {
        indexFirst=[resultArr indexOfObject:arr[0]];
    }
    if ([resultArr containsObject:arr[arr.count-1]]) {
        indexLast=[resultArr indexOfObject:arr[arr.count-1]];
    }
    
    
    
    NSDictionary *para=@{
                         @"orderDate":@"2018-08-08 00:00:00",
                         @"placeId":placeId,
                         @"orderStartTime":@"12:00:00",
                         @"orderEndTime":@"14:00:00"
                         };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
    NSDictionary *dic=@{
                        @"placeRecord":jsonData
                        };
    [[WebAPIHelper sharedWebAPIHelper] postWithUrl:kAddComplain body:dic showLoading:YES success:^(NSDictionary *resultDic){
        if (resultDic ==nil) {
            return ;
        }
        _placeRecord=[PlaceRecord mj_setKeyValues:resultDic[@"data"]];
    } failure:^(NSError *error){
        NSLog(@"%@",error);
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
        for (Place *place in placeArr) {
            [_placeList addObject:place.placeName];
            [_placeIdArr addObject:place.placeId];
        }
    }];
    
    
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
        [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
        
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [_selectIndexs addObject:@(indexPath.row)]; //添加索引数据到数组
        if (_selectIndexs.count >=2) {
            NSIndexPath *i;
            i=[_selectIndexs objectAtIndex:_selectIndexs.count-2];
            NSMutableArray *vArr=[NSMutableArray new];
            for (int z=0; z<_selectIndexs.count; z++) {
//                int j=[_selectIndexs.lastObject]-[_selectIndexs objectAtIndex:z] ;
                int j=[_selectIndexs.lastObject intValue]-[[_selectIndexs objectAtIndex:z] intValue];
                //  NSString *str=[NSString stringWithFormat:@"%d",j];
                [vArr addObject:[NSString stringWithFormat:@"%d",j]];
                
            }
            if ([vArr containsObject:@"2"]) {
                if ([vArr containsObject:@"1"]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
                    [_selectIndexs addObject:@(indexPath.row)];
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
                    [_selectIndexs removeObject:@(indexPath.row)]; //数据移除
                }
            }
            
        }
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    if (![self login]) {
        return;
    }
//    [self checkLogin];
    [self reuqestPlateList];
}

#pragma mark LSXPopMenuDelegate
- (void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.plateBtn setTitle:_placeList[index] forState:UIControlStateNormal];
    placeId=_placeIdArr[index];
}
@end
