

//
//  OrderTraceHeaderView.m
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderTraceHeaderView.h"

@interface OrderTraceHeaderView() {
    id _target;
    SEL _action;
    BOOL _arrows;
}

@end


@implementation OrderTraceHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _arrows = NO;
    }
    return self;
}

- (void)setOrderTraceHeaderViewDataWithOrder:(Order *)order isShowAllProduct:(BOOL)showAll
{
    if (showAll) {
        [self.arrowsButton setBackgroundImage:[UIImage imageNamed:@"sec_retract_image"] forState:UIControlStateNormal];
    } else {
        [self.arrowsButton setBackgroundImage:[UIImage imageNamed:@"arrows_bottom"] forState:UIControlStateNormal];
    }
    
    self.haulierName.text = @"物流公司";
    self.orderId.text = order.orderId;
    self.totalPrice.text = [NSString stringWithFormat:@"%0.2f", order.paidAmount];
    self.goodsCount.text = [NSString stringWithFormat:@"%d", [order.productList count]];
}

- (void)addTarget:(id)target Action:(SEL)action
{
    _target = target;
    _action = action;
}
#pragma mark 按钮回调
- (IBAction)arrowsAction:(id)sender
{
    [_target performSelectorInBackground:_action withObject:sender];
}

- (void)dealloc {
    [_haulierName release];
    [_orderId release];
    [_totalPrice release];
    [_goodsCount release];
    [_arrowsButton release];
    [super dealloc];
}

@end
