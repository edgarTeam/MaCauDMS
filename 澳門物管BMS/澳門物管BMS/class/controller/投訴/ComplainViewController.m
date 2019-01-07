//
//  ComplainViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/17.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ComplainViewController.h"

@interface ComplainViewController ()
@property (weak, nonatomic) IBOutlet UITextView *complainTextView;

@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"投訴";
    _complainTextView.layer.masksToBounds=YES;
    _complainTextView.layer.cornerRadius=7.0;
    _complainTextView.layer.borderWidth=0.5;
    _complainTextView.layer.borderColor=RGB(170, 170, 170).CGColor;
}
- (IBAction)submitAction:(UIButton *)sender {
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
