//
//  BookingRecordDetailViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/20.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BookingRecordDetailViewController.h"

@interface BookingRecordDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookingRecordDetailImageView;

@end

@implementation BookingRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"訂場詳情";
    _bookingRecordDetailImageView=[UIImageView new];
    _bookingRecordDetailImageView.layer.masksToBounds=YES;
    _bookingRecordDetailImageView.layer.cornerRadius=10.0;
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
