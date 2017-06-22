//
//  TChargeOrderDetailController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TChargeOrderDetailController.h"
#import "TChargeOrderDetailForm.h"

@implementation TChargeOrderDetailController

- (id)initWithNavigationTitle:(NSString *)title andOrderForm:(TAllscoOrderForm*)orderForm {
    self = [super initWithNavigationTitle:title];
    self.orderForm = orderForm;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    TChargeOrderDetailForm *chargeDetailForm = [[[TChargeOrderDetailForm alloc]init]autorelease];
    chargeDetailForm.orderForm = _orderForm;
    [chargeDetailForm.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:chargeDetailForm.view];
}



@end
