//
//  ForgetPswViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/23.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "ZKAlertTool.h"
#import "UITextField+PlaceHolder.h"

@interface ForgetPswViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;

@end

@implementation ForgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"string_forget_psd_title");
    
    self.baseTitleLab.text=LocalizedString(@"string_forget_psd_title");
    _userNameLab.font=[UIFont systemFontOfSize:15];
    
    _userNameText.placeHoldColor=RGBA(255, 255, 255, 0.5);
    _userNameText.placeHoldString=LocalizedString(@"String_tips_input_tel");
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=5.0;
    [_submitBtn setTitle:LocalizedString(@"string_confirm_reset_psd_title") forState:UIControlStateNormal];
    
}
- (IBAction)submitBtnAction:(id)sender {
    
    [self requestResetPSD];
    
}

- (void)requestResetPSD {
    if (_userNameText.text.length==0 || _userNameText==nil) {
        [ZKAlertTool showAlertWithMsg:LocalizedString(@"string_username_alert_title")];
        return;
    }
    NSDictionary *para = @{
                           @"username":_userNameText.text
                           
                           };
    [[WebAPIHelper sharedWebAPIHelper] postResetPSD:para completion:^(NSDictionary *dic){
        [ZKAlertTool showAlertWithTitle:LocalizedString(@"string_resetPSD_alert_title") andMsg:LocalizedString(@"string_resetPSD_alert_content")];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}


@end
