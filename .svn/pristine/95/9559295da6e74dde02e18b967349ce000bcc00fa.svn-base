//
//  ConfirmPaymentView.m
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ConfirmPaymentView.h"
#import "OrderFooterView.h"
#import "SettlementPayMentFooterView.h"

@interface ConfirmPaymentView() {
    SettlementPayMentFooterView *_footerView;
    id _target;
    SEL _payTypeAction;
    SEL _paymentAction;
    SEL _quickPayAction;
}

@end

@implementation ConfirmPaymentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self.lineLabel setBackgroundColor:[UIColor blueColor]];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    
    return self;
}

- (void)SetConfirmPaymenWithOrderId:(NSString *)orderId amountPayable:(NSString *)payable presentIntegral:(NSString *)presentIntegral {
    self.orderIdLable.text = orderId;
    _footerView.totalPriceLable.text = payable;
    self.presentIntegralLable.text = presentIntegral;
    self.payIntegralLable.text = payable;
}

- (id)initWithNib {
    self = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmPaymentView" owner:nil options:nil] lastObject];
    self.backgroundColor = [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1];
    
    [self setRadius:_backgroundView];
    [self setRadius:_paymenBackgroundView];
    [self.paymentTypeButton setImage:[UIImage imageNamed:@"shop_gouxuan"] forState:UIControlStateNormal];
    [self.paymentTypeButton setImage:[UIImage imageNamed:@"shop_gouxuan_s"] forState:UIControlStateSelected];
    self.paymentTypeButton.selected = NO;
    [self.quickPayButton setImage:[UIImage imageNamed:@"shop_gouxuan"] forState:UIControlStateNormal];
    [self.quickPayButton setImage:[UIImage imageNamed:@"shop_gouxuan_s"] forState:UIControlStateSelected];
    self.quickPayButton.selected = NO;
    // 去付款视图
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"SettlementPayMentFooterView" owner:nil options:nil] lastObject];
    [_footerView addTarget:self payAction:@selector(payButtonAction)];
    _footerView.totalPriceLable.text = @"0.00";
    [_footerView addTarget:self payAction:@selector(payButtonAction:)];
    _footerView.frame = CGRectMake(0, 0, 320, _footerView.bounds.size.height);
    CGRect frame = _footerView.frame;
    // 设置位置，在tabBar之上
    frame.origin.y = WindowHeight - _footerView.frame.size.height;
    _footerView.frame = frame;
    [self addSubview:_footerView];
    
    [self.lineLabel setBackgroundColor:[UIColor colorWithRed:24.0/255.0 green:113/255.0 blue:95.0/255.0 alpha:1.0]];

    return self;
}

- (void)setRadius:(UIView *)view
{
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (IBAction)paymentTypeAction:(id)sender {
    if (_target && _payTypeAction) {
        [_target performSelector:_payTypeAction withObject:sender];
    }
}

- (void)addTarget:(id)target selectPayTypeAction:(SEL)payTypeAction paymentAction:(SEL)paymentAction quickPayAction:(SEL)quickPayAction
{
    _target = target;
    _paymentAction = paymentAction;
    _payTypeAction = payTypeAction;
    _quickPayAction = quickPayAction;
    _footerView.totalPriceLable.text = @"0.00";
    [_footerView addTarget:target payAction:paymentAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)quickPayAction:(id)sender {
    if (_target && _quickPayAction) {
        [_target performSelector:_quickPayAction withObject:sender];
    }
}
- (void)dealloc {
    [_quickPayButton release];
    [super dealloc];
}
@end
