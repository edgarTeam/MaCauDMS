//
//  AnnouncementViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/17.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "AnnouncementViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "NoticeTableViewCell.h"
#import "Notice.h"
#import "NoticeDetailViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UIViewController+zk_Additions.h"
@interface AnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)SVProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger start;
@end

@implementation AnnouncementViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   //self.title=@"公告";
   // self.title=LocalizedString(@"String_notice_title");
    self.baseTitleLab.text=LocalizedString(@"string_notice_list_title");
   // self.edgesForExtendedLayout=UIRectEdgeNone;
    _tableView.separatorColor=[UIColor clearColor];
//    _tableView.separatorInset=UIEdgeInsetsZero;
    _tableView.tableFooterView=[UIView new];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.mj_header=[self createHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshRequest)];
    _tableView.mj_footer=[self createFooterWithRefreshingTarget:self refreshingAction:@selector(loadMordRequset)];
}


- (void)refreshRequest {
    self.start = 0;
    __weak typeof(self)weakSelf = self;
    [self requestNoticeList:^(NSInteger pageCount, NSArray<Notice *> *data, NSError *error){
        [weakSelf.tableView.mj_header endRefreshing];
        dataSource=data;
        [weakSelf.tableView reloadData];
    }];
}

- (void)loadMordRequset {
    self.start++;
    __weak typeof(self)weakSelf = self;
    [self requestNoticeList:^(NSInteger pageCount, NSArray<Notice *> *data, NSError *error){
        [weakSelf.tableView.mj_footer endRefreshing];
        if (error == nil) {
            if (weakSelf.start < pageCount) {
                dataSource = [dataSource arrayByAddingObjectsFromArray:data];
                [weakSelf.tableView reloadData];
            }
        } else {
            weakSelf.start--;
        }
    }];
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
//    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    if (cell ==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"NoticeTableViewCell" owner:self options:nil] lastObject];
    }
   // cell.backgroundColor=[UIColor clearColor];
    [cell setUpModel:[dataSource objectAtIndex:indexPath.row]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NoticeDetailViewController *noticeVC=[[NoticeDetailViewController alloc] init];
    Notice *notice=[dataSource objectAtIndex:indexPath.row];
    noticeVC.noticeId=notice.noticeId;
    [self.navigationController pushViewController:noticeVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestNoticeList:(void (^)(NSInteger pageCount, NSArray<Notice *> *data, NSError *error))handle {
    NSInteger limit = 10;
    NSDictionary *para = @{
                           @"pageNo":@(self.start *limit),
                           @"pageSize":@(limit)
                           };
    [[WebAPIHelper sharedWebAPIHelper] postNoticeList:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
         NSInteger pageCount = [dic[@"pages"] integerValue];
        NSMutableArray *array=[dic objectForKey:@"list"];
        NSArray *data=[Notice mj_objectArrayWithKeyValuesArray:array];
        handle(pageCount,data,nil);
    }];

}

//- (void)requestNoticeList {
//    [[WebAPIHelper sharedWebAPIHelper] postNoticeList:nil completion:^(NSDictionary *dic){
//        NSMutableArray *array=[dic objectForKey:@"list"];
//        if (_tableView.mj_header.isRefreshing) {
//            [_tableView.mj_header endRefreshing];
//        }
//        dataSource=[Notice mj_objectArrayWithKeyValuesArray:array];
//        [_tableView reloadData];
//    }];
//}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
   // [self requestNoticeList];
    [self refreshRequest];
}
@end
