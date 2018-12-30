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
@end

@implementation BookingRecordViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.title=LocalizedString(@"訂場紀錄");
    self.title=@"訂場紀錄";
    // Do any additional setup after loading the view from its nib.
    _bookingRecordTableView.delegate=self;
    _bookingRecordTableView.dataSource=self;
    _bookingRecordTableView.separatorColor=[UIColor clearColor];
    _bookingRecordTableView.tableFooterView=[UIView new];
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
   // return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookingRecordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BookingRecordTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BookingRecordTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookingRecordDetailViewController *bookDetailVC=[[BookingRecordDetailViewController alloc] init];
  //  PlaceRecord *place=[dataSource objectAtIndex:indexPath.row];
//    bookDetailVC.recordId=place.recordId;
    Place *place=[dataSource objectAtIndex:indexPath.row];
    bookDetailVC.recordId=place.placeId;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
//    [[WebAPIHelper sharedWebAPIHelper] postPlaceRecordList:nil completion:^(NSDictionary *dic){
//        NSMutableArray *array=[dic objectForKey:@"list"];
//        dataSource=[PlaceRecord mj_objectArrayWithKeyValuesArray:array];
//        [_bookingRecordTableView reloadData];
//    }];
    [[WebAPIHelper sharedWebAPIHelper] postPlaceList:nil completion:^(NSDictionary *dic){
        NSMutableArray *array=[dic objectForKey:@"list"];
        dataSource=[Place mj_objectArrayWithKeyValuesArray:array];
        [_bookingRecordTableView reloadData];
    }];
}
@end
