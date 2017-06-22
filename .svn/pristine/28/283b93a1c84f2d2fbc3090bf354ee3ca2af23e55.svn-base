//
//  PlanDatePickerView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanDatePickerView.h"
#import "StartPoint.h"
@interface PlanDatePickerView()
{
    id _target;
    SEL _finishAction;
    SEL _cancelAction;
}
@end
@implementation PlanDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)finishPickDate:(id)sender {
    self.hidden = YES;
    [_target performSelector:_finishAction withObject:nil];
}

- (IBAction)cancelPickDate:(id)sender {
    self.hidden = YES;
}

- (void)dealloc {
    [_planDatePicker release];
    [super dealloc];
}
-(void)addTarget:(id)thisTarget WithFinishAction:(SEL)finishAction
{
    _target = thisTarget;
    _finishAction = finishAction;
}
-(void)setPlanDatePickerVisible
{
    self.hidden = NO;
    self.planDatePicker.backgroundColor = [UIColor clearColor];
    [self.planDatePicker setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc]init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *maxDate = [formatter_minDate dateFromString:@"2030-01-01"];
    NSDate *minDate = [NSDate date];
    [self.planDatePicker setMinimumDate:minDate];
    [self.planDatePicker setMaximumDate:maxDate];
    [self.planDatePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    self.planDatePicker.userInteractionEnabled = YES;
}
@end
