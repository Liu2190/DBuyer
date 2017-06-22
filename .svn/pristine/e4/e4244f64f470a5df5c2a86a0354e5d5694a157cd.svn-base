//
//  TBuyerOrderDetailController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBuyerOrderDetailController.h"
#import "TBuyerOrderDetailForm.h"

@implementation TBuyerOrderDetailController

- (id)initWithNavigationTitle:(NSString *)title andOrderForm:(TAllscoOrderForm*)orderForm {
    self = [super initWithNavigationTitle:title];
    self.orderForm = orderForm;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TBuyerOrderDetailForm *buyerOrderForm = [[[TBuyerOrderDetailForm alloc]init]autorelease];
    buyerOrderForm.orderForm = _orderForm;
    [buyerOrderForm.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:buyerOrderForm.view];
}


@end
