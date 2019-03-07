//
//  ChangePswViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/27.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ChangePswViewController.h"
#import "ZKAlertTool.h"
@interface ChangePswViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPsdTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *oldPsdTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *changePsdTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *confirmPsdTitleLab;

@end

@implementation ChangePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"String_change_psd_title");
   // self.baseTitleLab.text=LocalizedString(@"String_change_psd_title");
    
    _oldPsdTitleLab.font=[UIFont systemFontOfSize:15];
    _changePsdTitleLab.font=[UIFont systemFontOfSize:15];
    _confirmPsdTitleLab.font=[UIFont systemFontOfSize:15];
    
    
    
    [_confirmBtn setTitle:LocalizedString(@"String_confirm") forState:UIControlStateNormal];
    _oldPsdTextField.delegate=self;
    _changePsdTextField.delegate=self;
    _confirmPsdTextField.delegate=self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requestChangePSD {
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
                         @"newpassword":_changePsdTextField.text
                         };
    [[WebAPIHelper sharedWebAPIHelper] postUpdatePsd:para completion:^(NSString *result){
        //        if (result ==nil) {
        //            return ;
        //        }
        NSLog(@"%@",result);
        //        [ZKAlertTool showAlertWithMsg:result];
      //  [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_change_psd_alert_title")];
        [ZKAlertTool showAlertWithTitle:nil andMsg:LocalizedString(@"string_change_psd_alert_title") cancelTitle:@"确定" otherTitles:nil handler:^(NSInteger tag){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
    }];
}

- (IBAction)confirmBtnAction:(UIButton *)sender {
    [self requestChangePSD];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_oldPsdTextField resignFirstResponder];
    [_changePsdTextField resignFirstResponder];
    [_confirmPsdTextField resignFirstResponder];
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        if (!CGRectContainsPoint(self.centerView.frame, point)) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
}
#pragma mark UITextField-Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self requestChangePSD];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    if (!CGRectContainsPoint(self.contentView.frame, point)) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}


@end
