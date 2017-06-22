//
//  TChargeOrderDetailController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TAllscoOrderForm.h"

@interface TChargeOrderDetailController : TRootViewController

@property (nonatomic,retain)TAllscoOrderForm *orderForm;

- (id)initWithNavigationTitle:(NSString *)title andOrderForm:(TAllscoOrderForm*)orderForm;

@end
