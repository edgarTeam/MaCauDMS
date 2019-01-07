//
//  UserInfoViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/1/1.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *telLab;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"個人信息";
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"");
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
