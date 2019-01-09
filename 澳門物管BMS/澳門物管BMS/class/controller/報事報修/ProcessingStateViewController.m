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
@interface ProcessingStateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *processingStateTableView;

@end

@implementation ProcessingStateViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"報事狀態";
    _processingStateTableView.delegate=self;
    _processingStateTableView.dataSource=self;
    _processingStateTableView.separatorColor=[UIColor clearColor];
    _processingStateTableView.tableFooterView=[UIView new];
    
}

- (void)requestComplainList {
    [[WebAPIHelper sharedWebAPIHelper] postComplainList:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *array=[dic objectForKey:@"list"];
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
    HandlingDetailsViewController *handVC=[[HandlingDetailsViewController alloc] init];
    ReportMaintenanceDetail *report=[dataSource objectAtIndex:indexPath.row];
    handVC.complainId=report.complainId;
    [self.navigationController pushViewController:handVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportMaintenanceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ReportMaintenanceTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ReportMaintenanceTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setUpModel:[dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return dataSource.count;
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self requestComplainList];
}
@end
