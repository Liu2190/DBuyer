//
//  DatePickerOfSettlement.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "DatePickerOfSettlement.h"
@interface DatePickerOfSettlement(){
    id _target;
    SEL _finishAction;
    SEL _cancelAction;
}
@end
@implementation DatePickerOfSettlement

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

- (IBAction)cancel:(id)sender {
    [_target performSelector:_cancelAction withObject:sender];
}

- (IBAction)finish:(id)sender {
    [_target performSelector:_finishAction withObject:sender];
}
- (void)dealloc {
    [_datePicker release];
    [super dealloc];
}
-(void)addTarget:(id)thisTarget withCancelAction:(SEL)cancleAction AndFinishAction:(SEL)finishAction{
    _target = thisTarget;
    _finishAction = finishAction;
    _cancelAction = cancleAction;
}
@end
