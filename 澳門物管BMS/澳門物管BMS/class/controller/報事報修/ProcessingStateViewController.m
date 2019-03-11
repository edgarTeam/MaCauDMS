//
//  ProcessingStateViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ProcessingStateViewController.h"
#import "ReportMaintenanceTableViewCell.h"
#import "HandlingDetailsViewController.h"
#import "ReportMaintenanceDetail.h"
#import "UIViewController+zk_Additions.h"


#import "ReportMaintenanceViewController.h"
@interface ProcessingStateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *processingStateTableView;
@property (nonatomic,assign) NSInteger start;
@end

@implementation ProcessingStateViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=@"報事狀態";
 //   self.title=LocalizedString(@"string_report_maintenance_list");
    switch (_type) {
        case ReportProcessType:
            {
                self.baseTitleLab.text=LocalizedString(@"string_report_maintenance_list");
            }
            break;
        case ComplainProcessType:
        {
            self.baseTitleLab.text=LocalizedString(@"string_complain_list_title");
        }
            break;
        default:
            break;
    }
    
   // self.baseTitleLab.text=LocalizedString(@"string_report_maintenance_list");
   // self.edgesForExtendedLayout=UIRectEdgeNone;
    _processingStateTableView.delegate=self;
    _processingStateTableView.dataSource=self;
    _processingStateTableView.separatorColor=[UIColor clearColor];
    _processingStateTableView.tableFooterView=[UIView new];
    _processingStateTableView.estimatedRowHeight = 120;
    _processingStateTableView.rowHeight = UITableViewAutomaticDimension;
    _processingStateTableView.backgroundColor=[UIColor clearColor];
//    _processingStateTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self requestComplainList];
//    }];
    _processingStateTableView.mj_header=[self createHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshRequest)];
        _processingStateTableView.mj_footer=[self createFooterWithRefreshingTarget:self refreshingAction:@selector(loadMordRequset)];
    
}

- (void)refreshRequest {
    self.start = 0;
    __weak typeof(self)weakSelf = self;
    [self requestComplain:^(NSInteger pageCount, NSArray<ReportMaintenanceDetail *> *data, NSError *error){
        [weakSelf.processingStateTableView.mj_header endRefreshing];
        dataSource=data;
        [weakSelf.processingStateTableView reloadData];
       // [weakSelf.hud hideAnimated:YES];
      //  [weakSelf.tableView.mj_header endRefreshing];
      //  weakSelf.data = data;
        //[weak_self.tableView reloadData];
    }];
    
    
}

- (void)loadMordRequset {
    self.start++;
    __weak typeof(self)weakSelf = self;
    [self requestComplain:^(NSInteger pageCount, NSArray<ReportMaintenanceDetail *> *data, NSError *error) {
        [weakSelf.processingStateTableView.mj_footer endRefreshing];
        if (error == nil) {
            if (weakSelf.start < pageCount) {
                dataSource = [dataSource arrayByAddingObjectsFromArray:data];
                [weakSelf.processingStateTableView reloadData];
            }
        } else {
            weakSelf.start--;
        }
    }];
}




- (void)requestComplain:(void (^)(NSInteger pageCount, NSArray<ReportMaintenanceDetail *> *data, NSError *error))handle {
    NSInteger limit = 10;
    NSDictionary *para = @{
                           @"pageNo":@(self.start *limit),
                           @"pageSize":@(limit)
                           };
    [[WebAPIHelper sharedWebAPIHelper] postComplainList:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
//        NSMutableArray *array=[dic objectForKey:@"list"];
//        if (_processingStateTableView.mj_header.isRefreshing) {
//            [_processingStateTableView.mj_header endRefreshing];
//        }
        NSInteger pageCount = [dic[@"pageNum"] integerValue];
//        NSArray *data = [NSArray modelArrayWithClass:[ReportMaintenanceDetail class] json:dic[@"list"]];
        NSMutableArray *array=[dic objectForKey:@"list"];
        NSArray *data=[ReportMaintenanceDetail mj_objectArrayWithKeyValuesArray:array];
        handle(pageCount,data,nil);
//        dataSource=[ReportMaintenanceDetail mj_objectArrayWithKeyValuesArray:array];
//        [_processingStateTableView reloadData];
    }];
}






- (void)requestComplainList {
    [[WebAPIHelper sharedWebAPIHelper] postComplainList:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *array=[dic objectForKey:@"list"];
        if (_processingStateTableView.mj_header.isRefreshing) {
            [_processingStateTableView.mj_header endRefreshing];
        }

        dataSource=[ReportMaintenanceDetail mj_objectArrayWithKeyValuesArray:array];
        [_processingStateTableView reloadData];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HandlingDetailsViewController *handVC=[[HandlingDetailsViewController alloc] init];
//    ReportMaintenanceDetail *report=[dataSource objectAtIndex:indexPath.row];
//    handVC.complainId=report.complainId;
//    [self.navigationController pushViewController:handVC animated:YES];
    ReportMaintenanceViewController *reportVC=[ReportMaintenanceViewController new];
    ReportMaintenanceDetail *report=[dataSource objectAtIndex:indexPath.row];
    reportVC.complainId=report.complainId;
    switch (_type) {
        case ReportProcessType:
        {
            reportVC.type=ReportType;
        }
            break;
        case ComplainProcessType:
        {
            reportVC.type=ComplainType;
        }
            break;
        default:
            break;
    }
    reportVC.isNews=YES;
    [self.navigationController pushViewController:reportVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportMaintenanceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReportMaintenanceTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ReportMaintenanceTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setUpModel:[dataSource objectAtIndex:indexPath.row]];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
   // return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportMaintenanceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReportMaintenanceTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ReportMaintenanceTableViewCell" owner:self options:nil] lastObject];
    }
    ReportMaintenanceDetail *model =[dataSource objectAtIndex:indexPath.row];
    CGFloat labelHeight = [cell getlabelHeiight:model.complainDescribe label:cell.contentLab];
//    return 178-21.5+labelHeight;
    return 75-18+labelHeight;
//    return 75;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self requestComplainList];
   // [self refreshRequest];
}
@end
