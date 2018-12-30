//
//  ChangePswViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/27.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ChangePswViewController.h"
#import "ZKAlertTool.h"
@interface ChangePswViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPsdTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation ChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_confirmBtn setTitle:LocalizedString(@"String_confirm") forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)confirmBtnAction:(UIButton *)sender {
    if (_oldPsdTextField.text.length ==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:LocalizedString(@"string_old_psw_alert") delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles:nil] show];
        return;
    }
    if (_changePsdTextField.text.length ==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:LocalizedString(@"string_new_psw_alert") delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
        return;
    }
    if (_confirmPsdTextField.text.length ==0) {
        [[[UIAlertView alloc] initWithTitle:nil message:LocalizedString(@"string_confirm_psw_alert")  delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
        return;
    }
    if (_changePsdTextField.text != _confirmPsdTextField.text) {
        [[[UIAlertView alloc] initWithTitle:nil message:LocalizedString(@"string_psw_difference") delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
        return;
    }
    NSDictionary *para=@{
                         @"password":_oldPsdTextField.text,
                         @"newpassword":_changePsdTextField
                         };
    [[WebAPIHelper sharedWebAPIHelper] postUpdatePsd:para completion:^(NSString *result){
        if (result ==nil) {
            return ;
        }
        [ZKAlertTool showAlertWithMsg:result];
    }];
}

@end
