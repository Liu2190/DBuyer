
//
//  OrderFooterView.m
//  DBuyer
//
//  Created by simman on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderFooterView.h"

@interface OrderFooterView() {
    id _target;
    SEL _checkBoxAction;
    SEL _payAction;
    BOOL _isChecked; //是否选中
}

@end


@implementation OrderFooterView

+ (id)initWithNib {
    self = [[[NSBundle mainBundle] loadNibNamed:@"OrderFooterView" owner:nil options:nil] lastObject];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self layoutFooterView];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _isChecked = NO;
    self.backgroundColor = [UIColor colorWithRed:0.208 green:0.208 blue:0.208 alpha:0.1];
    
    return self;
}

- (id)initWithTotalPrice:(NSString *)price payButtonTitle:(NSString *)payTitle
          CheckBoxHidden:(BOOL)isHidden {
    self = [[[NSBundle mainBundle] loadNibNamed:@"OrderFooterView" owner:nil options:nil] lastObject];
    _isChecked = NO;
    self.totalPrice.text = price;
    [self.payButton setTitle:payTitle forState:UIControlStateNormal];
    self.checkBoxButton.hidden = isHidden;
    self.backgroundColor = [UIColor colorWithRed:0.208 green:0.208 blue:0.208 alpha:0.8];
    
    [self layoutFooterView];
    
    return self;
}

- (void)layoutFooterView {
    float x = 10;
    float y = (self.frame.size.height-self.totalTitle.frame.size.height)/2;
    self.totalTitle.frame = CGRectMake(x, y, self.totalTitle.frame.size.width, self.totalTitle.frame.size.height);
    
    x = self.totalTitle.frame.origin.x + self.totalTitle.frame.size.width;
    y = (self.frame.size.height-self.totalPrice.frame.size.height)/2;
    self.totalPrice.frame = CGRectMake(x, y, self.totalPrice.frame.size.width, self.totalPrice.frame.size.height);
}

- (void)clearStatus {
    _isChecked = NO;
    self.totalPrice.text = @"0.00";
    
    [self.checkBoxButton setBackgroundImage:[UIImage imageNamed:@"checkBox_null"] forState:UIControlStateNormal];
}


- (void)setDidFinishOrderDetailView {
    self.payButton.hidden = YES;
}

- (void)setWaitConsigneeDetailView {
    [self.payButton setBackgroundImage:[UIImage imageNamed:@"FinishFPView_finishbtn"] forState:UIControlStateNormal];
    [self.payButton setBackgroundImage:[UIImage imageNamed:@"FinishFPView_finishbtn_click"] forState:UIControlStateHighlighted];
}

- (void)setTotalPrice:(NSString *)price payButtonTitle:(NSString *)payTitle
    CheckBoxHidden:(BOOL)isHidden {
    
    _isChecked = NO;
    self.totalPrice.text = price;
    [self.payButton setTitle:payTitle forState:UIControlStateNormal];
    self.checkBoxButton.hidden = isHidden;
    self.backgroundColor = [UIColor colorWithRed:0.208 green:0.208 blue:0.208 alpha:1];
}


#pragma mark 更改价格
- (void)setFooterViewTotalPrice:(NSString *)price {
    self.totalPrice.text = price;
}

#pragma mark 设置支付Title
- (void)setFooterviewPayTitle:(NSString *)title {
    [self.payButton setTitle:title forState:UIControlStateNormal];
}

- (void)addTarget:(id)target checkBoxAction:(SEL)CBAction payAction:(SEL)pyAction {
    _target = target;
    _checkBoxAction = CBAction;
    _payAction = pyAction;
}



#pragma mark 支付按钮事件
- (IBAction)payButtonAction:(id)sender {
    [_target performSelector:_payAction withObject:sender];
}

#pragma mark 复选框按钮
- (void)setCheckBoxButtonStatus:(BOOL)isChecked {
    // 如果是选中状态
    if (isChecked) {
        [self.checkBoxButton setBackgroundImage:[UIImage imageNamed:@"checkBox_highlighted"] forState:UIControlStateNormal];
    } else {
        [self.checkBoxButton setBackgroundImage:[UIImage imageNamed:@"checkBox_null"] forState:UIControlStateNormal];
    }
    
    _isChecked = isChecked;
}

#pragma mark 复选框按钮事件
- (IBAction)checkBoxButtonAction:(id)sender {
    [self setCheckBoxButtonStatus:!_isChecked];
    [_target performSelector:_checkBoxAction withObject:sender];
}

- (void)dealloc {
    [_checkBoxButton release];
    [_totalPrice release];
    [_payButton release];
    [_totalTitle release];
    [super dealloc];
}
@end
