//
//  ConfirmPaymentView.h
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPaymentView : UIView

@property (retain, nonatomic) IBOutlet UILabel *payIntegralLable; // 支付积分
@property (retain, nonatomic) IBOutlet UILabel *presentIntegralLable; // 赠送积分
@property (retain, nonatomic) IBOutlet UILabel *otherContentLable; // 其他内容
@property (retain, nonatomic) IBOutlet UILabel *orderIdLable;

@property (retain, nonatomic) IBOutlet UIButton *paymentTypeButton;  // 支付类别按钮

- (IBAction)paymentTypeAction:(id)sender;  // 支付类别事件

@property (retain, nonatomic) IBOutlet UIView *backgroundView;  // 背景View
@property (retain, nonatomic) IBOutlet UIView *paymenBackgroundView; // 银联背景

@property (retain, nonatomic) IBOutlet UILabel *lineLabel;
@property (retain, nonatomic) IBOutlet UIButton *quickPayButton;

- (IBAction)quickPayAction:(id)sender;

#pragma mark 初始化数据
- (void)SetConfirmPaymenWithOrderId:(NSString *)orderId amountPayable:(NSString *)payable presentIntegral:(NSString *)presentIntegral;

- (id)initWithNib;

- (void)addTarget:(id)target selectPayTypeAction:(SEL)payTypeAction paymentAction:(SEL)paymentAction quickPayAction:(SEL)quickPayAction;


@end
