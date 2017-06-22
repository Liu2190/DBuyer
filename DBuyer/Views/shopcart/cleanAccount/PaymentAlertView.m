
//
//  PaymentAlertView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PaymentAlertView.h"

@implementation PaymentAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

+ (id)paymentAlertView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PaymentAlertView" owner:nil options:nil] lastObject];
}

- (IBAction)backHomeButtonClicked:(UIButton *)sender {
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentAlertViewDidClickedButton:)]) {
        [self.delegate paymentAlertViewDidClickedButton:0];
    }
}

- (IBAction)showOrderButtonClicked:(UIButton *)sender {
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentAlertViewDidClickedButton:)]) {
        [self.delegate paymentAlertViewDidClickedButton:1];
    }
}
@end
