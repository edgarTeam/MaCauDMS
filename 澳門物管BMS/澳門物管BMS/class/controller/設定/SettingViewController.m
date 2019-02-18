//
//  SettingViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "SettingViewController.h"
#import "LanguageSettingViewController.h"
#import "ChangePswViewController.h"
#import "ContactUSViewController.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changePsdBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *psdBtnHeight;
@property (weak, nonatomic) IBOutlet UIButton *changeLanguageBtn;
@property (weak, nonatomic) IBOutlet UIButton *AboutUsBtn;



@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"設定");
//    if (![self login]) {
//        return;
//    }
    
    self.title=LocalizedString(@"string_set_title");
    [self.changePsdBtn setTitle:LocalizedString(@"String_change_psd_title") forState:UIControlStateNormal];
    [self.changeLanguageBtn setTitle:LocalizedString(@"string_language_setting_title") forState:UIControlStateNormal];
    [self.AboutUsBtn setTitle:LocalizedString(@"string_about_us_title") forState:UIControlStateNormal];
}
- (IBAction)chooseBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:{
            LanguageSettingViewController *languageVC=[LanguageSettingViewController new];
            [self.navigationController pushViewController:languageVC animated:YES];
        }
            break;
        case 1:{
            ChangePswViewController *PsdVC=[ChangePswViewController new];
            [self.navigationController pushViewController:PsdVC animated:YES];
        }
            break;
        case 2:{
//            LanguageSettingViewController *languageVC=[LanguageSettingViewController new];
//            [self.navigationController pushViewController:languageVC animated:YES];
            ContactUSViewController *aboutVC=[ContactUSViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        default:
            break;
    }
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
    if (self.token.length==0) {
        _changePsdBtn.hidden=YES;
        _psdBtnHeight.constant=0;
    }

}
@end
