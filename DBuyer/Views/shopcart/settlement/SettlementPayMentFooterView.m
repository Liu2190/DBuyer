//
//  SettlementPayMentFooterView.m
//  DBuyer
//
//  Created by simman on 14-1-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementPayMentFooterView.h"

@interface SettlementPayMentFooterView() {
    id _target;             // 控制器
    SEL _checkBoxAction;
    SEL _payAction;
}

@end

@implementation SettlementPayMentFooterView

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

- (IBAction)goPaymentButtonAction:(id)sender {
    [_target performSelector:_payAction withObject:sender];
}
- (void)addTarget:(id)target payAction:(SEL)pyAction
{
    _target = target;
    _payAction = pyAction;
}
- (void)dealloc {
    [_goPaymentButton release];
    [_totalPriceLable release];
    [super dealloc];
}

@end
