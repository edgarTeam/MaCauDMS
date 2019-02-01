//
//  BookingRecordViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BookingRecordViewController.h"
#import "BookingRecordTableViewCell.h"
#import "BookingRecordDetailViewController.h"
#import "PlaceRecord.h"
#import "Place.h"
#import <MJExtension/MJExtension.h>
@interface BookingRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bookingRecordTableView;

@property (nonatomic,strong)Place *place;
@property (nonatomic,strong)NSString *placeId;
@property (nonatomic,strong)NSMutableArray *placeArr;
@end

@implementation BookingRecordViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.title=LocalizedString(@"訂場紀錄");
    //self.title=@"訂場紀錄";
    self.title=LocalizedString(@"string_booking_record_title");
    // Do any additional setup after loading the view from its nib.
    _bookingRecordTableView.delegate=self;
    _bookingRecordTableView.dataSource=self;
    _bookingRecordTableView.separatorColor=RGB(178, 178, 178);
    _bookingRecordTableView.separatorInset=UIEdgeInsetsZero;
    _bookingRecordTableView.tableFooterView=[UIView new];
    _bookingRecordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestPlaceList];
    }];
    _placeArr=[NSMutableArray new];
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
    return dataSource.count;
//  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookingRecordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BookingRecordTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BookingRecordTableViewCell" owner:self options:nil] lastObject];
    }
    cell.numberLab.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell setUpPlaceRecord:[dataSource objectAtIndex:indexPath.row]];
//    if (_placeArr.count !=0) {
//         [cell setUpModel:[_placeArr objectAtIndex:indexPath.row]];
//    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BookingRecordDetailViewController *bookDetailVC=[[BookingRecordDetailViewController alloc] init];
    PlaceRecord *place=[dataSource objectAtIndex:indexPath.row];
//    bookDetailVC.recordId=place.recordId;
  //  Place *place=[dataSource objectAtIndex:indexPath.row];
    //bookDetailVC.recordId=place.placeId;
    bookDetailVC.recordId=place.recordId;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}
- (void)requestPlace {
    NSDictionary *para=@{
                         @"placeId" :_placeId
                         };
    [[WebAPIHelper sharedWebAPIHelper] postPlace:para completion:^(NSDictionary *dic){
        if (dic==nil) {
            return ;
        }
        _place=[Place mj_objectWithKeyValues:dic];
        if (_place ==nil) {
            return;
        }
        [self.placeArr addObject:_place];
//        if (_bookingRecordTableView.mj_header.isRefreshing) {
//            [_bookingRecordTableView.mj_header endRefreshing];
//        }
//        [_bookingRecordTableView reloadData];
//        _palceLab.text=_place.placeName;
//        [self.bookingRecordDetailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,_place.placeImage]]placeholderImage:kEMPTYIMG completed:nil];
    }];
}

- (void)requestPlaceList {
    [[WebAPIHelper sharedWebAPIHelper] postPlaceRecordList:nil completion:^(NSDictionary *dic){
        NSArray *array=[dic objectForKey:@"list"];
        dataSource=[PlaceRecord mj_objectArrayWithKeyValuesArray:array];
        //        [_bookingRecordTableView reloadData];
//        if (dataSource ==nil || dataSource.count==0) {
//
//            return ;
//        }
//        for (PlaceRecord *palceRecord in dataSource) {
//            _placeId=palceRecord.placeId;
//            if (_placeId !=nil) {
//                [self requestPlace];
//            }
//
//        }
        if (_bookingRecordTableView.mj_header.isRefreshing) {
            [_bookingRecordTableView.mj_header endRefreshing];
        }
        [_bookingRecordTableView reloadData];
    }];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
    [self requestPlaceList];
    
//    [[WebAPIHelper sharedWebAPIHelper] postPlaceList:nil completion:^(NSDictionary *dic){
//        if (dic ==nil) {
//            return ;
//        }
//        NSMutableArray *array=[dic objectForKey:@"list"];
//        dataSource=[Place mj_objectArrayWithKeyValuesArray:array];
//        [_bookingRecordTableView reloadData];
//    }];
}
@end
