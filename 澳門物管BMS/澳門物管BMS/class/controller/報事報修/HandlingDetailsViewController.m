//
//  HandlingDetailsViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "HandlingDetailsViewController.h"
#import "ReportMaintenanceDetail.h"
@interface HandlingDetailsViewController ()
@property (nonatomic,strong) ReportMaintenanceDetail *complain;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contactWayLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;



@end

@implementation HandlingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"報事詳情";
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requestComplain {
    NSDictionary *para=@{
                        @"complainId":_complainId
                        };
    [[WebAPIHelper sharedWebAPIHelper] postComplain:para completion:^(NSDictionary *dic){
        if (dic ==nil) {
            return ;
        }
        _complain=[ReportMaintenanceDetail mj_setKeyValues:dic];
        _titleLab.text=_complain.complainClassType;
        _positionLab.text=[NSString stringWithFormat:@"%@,%@",_complain.complainPosition,_complain.complainSpecificPosition];
        _nameLab.text=_complain.complainLiaisonsName;
        _contactWayLab.text=_complain.complainLiaisonsEmail;
        _createTimeLab.text=_complain.createTime;
        _contentTextView.text=_complain.complainDescribe;
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
@end
