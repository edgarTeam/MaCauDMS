//
//  ContactUSViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "ContactUSViewController.h"

@interface ContactUSViewController ()
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@end

@implementation ContactUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title=LocalizedString(@"聯繫我們");
 //   self.title=@"聯繫我們";
    self.baseTitleLab.text=LocalizedString(@"string_contact_us_title");
   // self.baseTitleLab.text=@"联系我们";
    self.title=LocalizedString(@"string_contact_us_title");
    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//让电话居左
}
- (IBAction)phoneBtnAction:(id)sender {
    [self callTel:@"853-66223344"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)callTel:(NSString *)telString{
    NSString *cmdString = [NSString stringWithFormat:@"tel:%@",telString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cmdString] options:@{} completionHandler:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;

}
@end
