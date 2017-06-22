//
//  SettlementFooterView.m
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementFooterView.h"
#import "keyBoardView.h"

@interface SettlementFooterView() {
    id _target;             // 控制器
    SEL _action;            // 方法
    SEL _cancelAction;      // 键盘Cancel事件
    SEL _finishAction;      // 键盘Finish事件
}

@end

@implementation SettlementFooterView

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

- (id)initWithNib
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SettlementFooterView" owner:nil options:nil] lastObject];
    // keyboardView
    keyBoardView *keyV = [[keyBoardView alloc] initWithNib];
    [keyV addTarget:self finishAction:@selector(keyBoardFinishAction:) cancelAction:@selector(keyBoardCancelAction:)];
    self.useIntegralTextField.inputAccessoryView = keyV;
    return self;
}
- (void)keyBoardFinishAction:(id)sender
{
    if (_finishAction && _target) {
        [_target performSelector:_finishAction withObject:sender];
    }
}
- (void)keyBoardCancelAction:(id)sender
{
    if (_cancelAction && _target) {
        [_target performSelector:_cancelAction withObject:sender];
    }
}
- (void)addTarget:(id)target Action:(SEL)action KeyBoardFinshAction:(SEL)finishAction KeyBoardCancelAction:(SEL)cancelAction
{
    _target = target;
    _action = action;
    _finishAction = finishAction;
    _cancelAction = cancelAction;
}
- (IBAction)useIntegralAction:(id)sender {
    if (_action && _target) {
        [_target performSelector:_action withObject:sender];
    }
}
- (void)dealloc {
    [_integralLable release];
    [_priceLable release];
    [_useIntegralTextField release];
    [super dealloc];
}
@end
