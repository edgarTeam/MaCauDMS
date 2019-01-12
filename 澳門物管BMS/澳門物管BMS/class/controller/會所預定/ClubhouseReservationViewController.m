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
@property (nonatomic,strong) PlaceRecord *placeRecord;
@end

@implementation ClubhouseReservationViewController
{
    NSArray *dataSource;
    NSString *placeId;
//    NSArray *placeList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"會所預定";
    _placeList=[NSMutableArray new];
    _placeIdArr=[NSMutableArray new];
    _selectIndexs=[NSMutableArray new];
dataSource=@[@"00:00~02:00",@"02:00~04:00",@"04:00~06:00",@"06:00~08:00",@"08:00~10:00",@"10:00~12:00",@"12:00~14:00",@"14:00~16:00",@"16:00~18:00",@"18:00~20:00",@"20:00~22:00",@"22:00~00:00"];
   // _dateTableView=[[UITableView alloc] init];
    _dateTableView.tableFooterView=[UIView new];
    _dateTableView.delegate=self;
    _dateTableView.dataSource=self;
    [_dateTableView reloadData];
    
}

- (void)requestAddPlaceRecord{
    NSDictionary *para=@{
                         @"placeId":placeId
                         
                         };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:para options:NSJSONWritingPrettyPrinted error:&error];
    NSDictionary *dic=@{
                        @"placeRecord":jsonData
                        };
    [[WebAPIHelper sharedWebAPIHelper] postWithUrl:kAddComplain body:dic showLoading:YES success:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        _placeRecord=[PlaceRecord mj_setKeyValues:dic[@"data"]];
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
     NSLog(@"data的個數%ld",dataSource.count);
    return dataSource.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDentified=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IDentified];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDentified];
    }
    cell.textLabel.text=dataSource[indexPath.row];
    NSLog(@"%@",cell.textLabel.text);

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
        [_selectIndexs removeObject:indexPath]; //数据移除
        
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
        if (_selectIndexs.count >=2) {
            NSIndexPath *i;
            i=[_selectIndexs objectAtIndex:_selectIndexs.count-2];
            NSMutableArray *vArr=[NSMutableArray new];
            for (int z=0; z<_selectIndexs.count; z++) {
                int j=[_selectIndexs.lastObject row]-[[_selectIndexs objectAtIndex:z] row];
                //  NSString *str=[NSString stringWithFormat:@"%d",j];
                [vArr addObject:[NSString stringWithFormat:@"%d",j]];
                
            }
            if ([vArr containsObject:@"2"]) {
                if ([vArr containsObject:@"1"]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
                    [_selectIndexs addObject:indexPath];
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
                    [_selectIndexs removeObject:indexPath]; //数据移除
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
 //   [self reuqestPlateList];
}

#pragma mark LSXPopMenuDelegate
- (void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{
    [self.plateBtn setTitle:_placeList[index] forState:UIControlStateNormal];
    placeId=_placeIdArr[index];
}
@end
