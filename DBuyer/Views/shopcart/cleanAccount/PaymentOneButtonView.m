//
//  PaymentOneButtonView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PaymentOneButtonView.h"


@implementation PaymentOneButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)paymentOneButtonView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PaymentOneButtonView" owner:nil options:nil] lastObject];
}

- (IBAction)OKButtonClicked:(UIButton *)sender
{
    // do something ...
    
    [self removeFromSuperview];
}
@end
