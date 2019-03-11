//
//  LoginViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/13.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "LoginViewController.h"
#import "WebAPIHelper.h"
#import "HttpHelper.h"
#import "User.h"
#import "ChangePswViewController.h"
#import "ForgetPswViewController.h"
#import "CommonUtil.h"
#import "UITextField+PlaceHolder.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *psdLab;

@end

@implementation LoginViewController

//- (instancetype)init{
//    if (self = [super initWithNibName:@"BaseViewController" bundle:nil]) {
//        // 初始化
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backBtn.hidden=YES;
    _accountLab.font=[UIFont systemFontOfSize:15];
    _psdLab.font=[UIFont systemFontOfSize:15];
    _loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    
    self.view.backgroundColor=[UIColor blackColor];
    _headImg.layer.masksToBounds=YES;
    _headImg.layer.cornerRadius=40;
    
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5.0;
    _accountTextField.delegate=self;
    _psdTextField.delegate=self;
    
    _accountTextField.placeHoldColor=RGBA(255, 255, 255, 0.5);
    _accountTextField.placeHoldString=LocalizedString(@"請輸入帳號");
    _accountTextField.tintColor=[UIColor whiteColor];
    _psdTextField.placeHoldColor=RGBA(255, 255, 255, 0.5);
    _psdTextField.placeHoldString=LocalizedString(@"請輸入密碼");
    _psdTextField.tintColor=[UIColor whiteColor];
    
//    _psdTextField.placeHoldColor=[UIColor redColor];
//    _psdTextField.placeHoldString=@"11";
//    _psdTextField.tintColor=[UIColor redColor];//设置光标颜色
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginBtnAction:(id)sender {
    [self requestLogin];
}

- (void)requestLogin {
    if(_accountTextField.text.length ==0){
        [[[UIAlertView alloc]initWithTitle:@"" message:LocalizedString(@"String_tips_input_tel") delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
    }else if (_psdTextField.text.length ==0){
        [[[UIAlertView alloc]initWithTitle:@"" message:LocalizedString(@"String_tips_input_password") delegate:nil cancelButtonTitle:LocalizedString(@"String_confirm") otherButtonTitles: nil] show];
    }else{
        NSString *registrationId=[[NSUserDefaults standardUserDefaults] objectForKey:@"registrationId"];
        NSDictionary *dic =[NSDictionary  dictionaryWithObjectsAndKeys:_accountTextField.text,@"username",_psdTextField.text,@"password",registrationId,@"registrationId",nil];
        [[WebAPIHelper sharedWebAPIHelper]postUserLogin:dic completion:^(NSDictionary *dic){
            if(dic !=nil){
                [CommonUtil clearDefuatUser];
                User *user=[User shareUser];
                
                user =  [User mj_objectWithKeyValues:[dic objectForKey:@"user"]];
                
                //                user=[dic objectForKey:@"user"];
                //  User *user=[User objectWithKeyValues:dic];
                NSString * loginToken=[dic objectForKey:@"token"];
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setObject:loginToken forKey:LoginToken];
                [[HttpHelper shareHttpHelper] resetToken:loginToken];
                [CommonUtil storeUser];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        //  [self.navigationController popViewControllerAnimated:YES];
    }
    
}




- (IBAction)forgetBtnAction:(id)sender {
    ForgetPswViewController *forgetVC=[[ForgetPswViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_psdTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
}


#pragma mark UITextField-Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField ==self.psdTextField && textField.text.length !=0) {
        [self requestLogin];
    }
    return YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
@end
