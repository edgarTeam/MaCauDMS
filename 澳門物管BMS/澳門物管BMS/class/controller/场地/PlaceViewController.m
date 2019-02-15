//
//  PlaceViewController.m
//  澳門物管BMS
//
//  Created by sc-057 on 2019/2/15.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "PlaceViewController.h"
#import "PlaceTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import "Place.h"
@interface PlaceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *placeTableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *placeAlertLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation PlaceViewController
{
    NSArray *dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.submitBtn setTitle:LocalizedString(@"String_confirm") forState:UIControlStateNormal];
    [self createView];
    
}
- (void)createView {
    _placeTableView.delegate=self;
    _placeTableView.dataSource=self;
    _placeTableView.separatorColor=[UIColor clearColor];
    _placeTableView.tableFooterView=[UIView new];
    _placeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestPlaceList];
    }];
}

- (void)requestPlaceList {
    [[WebAPIHelper sharedWebAPIHelper] postPlaceList:nil completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        NSMutableArray *array=[dic objectForKey:@"list"];
        
        
        dataSource=[Place mj_objectArrayWithKeyValuesArray:array];
        if (_placeTableView.mj_header.isRefreshing) {
            [_placeTableView.mj_header endRefreshing];
        }
        [_placeTableView reloadData];

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PlaceTableViewCell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PlaceTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setUpModel:[dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _placeName=@"";
    _placeId=@"";
    Place *place=[dataSource objectAtIndex:indexPath.row];
    _placeName=place.placeName;
    _placeId=place.placeId;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)submitBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        self.placeNameBlock(_placeName,_placeId);
    }];
}
- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self requestPlaceList];
}
@end
