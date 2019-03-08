//
//  SelectDatePickerController.m
//  OA.message
//
//  Created by lee on 16/6/25.
//  Copyright © 2016年 sanchun. All rights reserved.
//

#import "SelectDatePickerController.h"

#import "UIView+SDAutoLayout.h"

#define kMargin 10.f

@interface SelectDatePickerController ()
{
    UIButton *_dateButton;
    UIButton *_timeButton;
}
@end

@implementation SelectDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topView = [UIView new];
    [self.contentView addSubview:topView];
    topView.sd_layout
    .leftSpaceToView(self.contentView,kMargin)
    .topSpaceToView(self.contentView,kMargin/2)
    .rightSpaceToView(self.contentView,kMargin);
    
    UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateButton addTarget:self action:@selector(showDatePicker) forControlEvents:UIControlEventTouchUpInside];
    dateButton.selected = YES;
    [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [dateButton setTitle:NSLocalizedString(@"日期",nil) forState:UIControlStateNormal];
    _dateButton = dateButton;
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [timeButton addTarget:self action:@selector(showTimePicker) forControlEvents:UIControlEventTouchUpInside];
    [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [timeButton setTitle:NSLocalizedString(@"時間", nil) forState:UIControlStateNormal];
    _timeButton = timeButton;
    
//    [topView sd_addSubviews:@[dateButton,timeButton]];
//    dateButton.sd_layout.heightIs(30);
//    timeButton.sd_layout.heightIs(30);
//    [topView setupAutoWidthFlowItems:@[dateButton,timeButton] withPerRowItemsCount:2 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    [topView sd_addSubviews:@[dateButton]];
    dateButton.sd_layout.heightIs(30);
   // timeButton.sd_layout.heightIs(30);
    [topView setupAutoWidthFlowItems:@[dateButton] withPerRowItemsCount:1 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    
//    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yellowLine"]];
    UIImageView *line = [[UIImageView alloc]init];
    line.backgroundColor=RGB(63, 114, 156);
    [self.contentView addSubview:line];
    line.sd_layout
    .leftSpaceToView(self.contentView,kMargin)
    .topSpaceToView(topView,kMargin/2)
    .rightSpaceToView(self.contentView,kMargin)
    .heightIs(1.5);
    
    
    UIView *bottomView = [UIView new];
    [self.contentView addSubview:bottomView];
    bottomView.sd_layout
    .leftSpaceToView(self.contentView,kMargin)
    .rightSpaceToView(self.contentView,kMargin)
    .bottomSpaceToView(self.contentView,kMargin);
    
    UIButton *cacelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cacelButton addTarget:self action:@selector(cacelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cacelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
//    [cacelButton setBackgroundImage:[UIImage imageNamed:@"cellColor_3"] forState:UIControlStateNormal];
    [cacelButton setBackgroundColor:RGB(78, 177, 102)];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:NSLocalizedString(@"確定", nil) forState:UIControlStateNormal];
//    [submitButton setBackgroundImage:[UIImage imageNamed:@"cellColor_3"] forState:UIControlStateNormal];
     [submitButton setBackgroundColor:RGB(78, 177, 102)];
    [bottomView sd_addSubviews:@[cacelButton,submitButton]];
    cacelButton.sd_layout.heightIs(30);
    submitButton.sd_layout.heightIs(30);
    [bottomView setupAutoWidthFlowItems:@[cacelButton,submitButton] withPerRowItemsCount:2 verticalMargin:0 horizontalMargin:kMargin verticalEdgeInset:0 horizontalEdgeInset:0];
    
   
//    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yellowLine"]];
    UIImageView *line2 = [[UIImageView alloc]init];
    line2.backgroundColor=RGB(63, 114, 156);
    [self.contentView addSubview:line2];
    line2.sd_layout
    .leftSpaceToView(self.contentView,kMargin)
    .bottomSpaceToView(bottomView,kMargin)
    .rightSpaceToView(self.contentView,kMargin)
    .heightIs(1.5);
    
    UIView *dateView = [UIView new];
    dateView.clipsToBounds = YES;
    [self.contentView addSubview:dateView];
    dateView.sd_layout
    .leftSpaceToView(self.contentView,kMargin)
    .topSpaceToView(line,kMargin)
    .rightSpaceToView(self.contentView,kMargin)
    .bottomSpaceToView(line2,kMargin);
    
    
    
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [dateView addSubview:self.datePicker];
    self.datePicker.sd_layout
    .leftSpaceToView(dateView,0)
    .rightSpaceToView(dateView,0)
    .centerYEqualToView(dateView);
    
    self.timePicker = [[UIDatePicker alloc]init];
    self.timePicker.hidden = YES;
    self.timePicker.datePickerMode = UIDatePickerModeTime;
    self.timePicker.date = [NSDate date];
    [dateView addSubview:self.timePicker];
    self.timePicker.sd_layout
    .leftSpaceToView(dateView,0)
    .rightSpaceToView(dateView,0)
    .centerYEqualToView(dateView);
}

- (void)showDatePicker {
    _dateButton.selected = YES;
    _timeButton.selected = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.datePicker.hidden = NO;
        self.timePicker.hidden = YES;
    }];
}

- (void)showTimePicker {
    _dateButton.selected = NO;
    _timeButton.selected = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.datePicker.hidden = YES;
        self.timePicker.hidden = NO;
    }];

}

#pragma -mark- action
- (void)cacelAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitAction:(UIButton *)button {
    NSString *dateStr = [self stringFormDate:self.datePicker.date format:NSLocalizedString(@"yyyyMMdd", nil)];
    NSString *timeStr = [self stringFormDate:self.timePicker.date format:NSLocalizedString(@"HHmmss", nil)];
    NSString *string = [dateStr stringByAppendingString:timeStr];
//    if (self.didSelectData != nil) {
//        self.didSelectData(self.datePicker.date,self.timePicker.date,string);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    if (self.selectDate != nil) {
        self.selectDate(self.datePicker.date, dateStr);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (NSString *)stringFormDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
