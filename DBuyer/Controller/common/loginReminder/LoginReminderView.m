//
//  LoginReminderView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "LoginReminderView.h"
@interface LoginReminderView()
{
    id _target;
    SEL _loginAction;
}
@end

@implementation LoginReminderView

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

- (void)dealloc {
    [_reminderLabel release];
    [super dealloc];
}
- (IBAction)reminderButton:(id)sender
{
    [_target performSelector:_loginAction withObject:sender];
}
-(void)addTarget:(id)thisTarget withLoginAction:(SEL)thisAction
{
    _target = thisTarget;
    _loginAction = thisAction;
}
@end
