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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
@end
