//
//  PickViewController.m
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2019/2/18.
//  Copyright © 2019 geanguo_lucky. All rights reserved.
//

#import "PickViewController.h"

@interface PickViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic,strong) NSString *title;
@end

@implementation PickViewController
{
   // void(^backBlock)(NSString *);
}
-(instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.2];
    
    
    self.dataSource=@[@"11",@"22"];
    self.pickView.delegate=self;
    self.pickView.dataSource=self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //NSString *title=nil;
   // self.title=nil;
    self.title=self.dataSource[row];
    return self.title;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitBtnAction:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
    //backBlock(self.title);
    [self dismissViewControllerAnimated:YES completion:^{
        self.backBlock(self.title);
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

@end
