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
@interface AnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AnnouncementViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"公告";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.tableFooterView=[UIView new];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    if (cell ==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"NoticeTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
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
- (void)requestNoticeList {
    [[WebAPIHelper sharedWebAPIHelper] postNoticeList:nil completion:^(NSDictionary *dic){
        NSMutableArray *array=[dic objectForKey:@"list"];
        dataSource=[Notice mj_objectArrayWithKeyValuesArray:array];
        [_tableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestNoticeList];
}
@end
