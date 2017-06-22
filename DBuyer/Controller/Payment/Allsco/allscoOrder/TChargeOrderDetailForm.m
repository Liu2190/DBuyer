//
//  TChargeOrderDetailForm.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TChargeOrderDetailForm.h"
#import "TAllscoOrderChargeElement.h"
#import "TAllScoCharge.h"

@implementation TChargeOrderDetailForm


- (id)init {
    self = [super init];
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    QSection *baseSection = [[[QSection alloc]init]autorelease];
    [self.root addSection:baseSection];
    
    QLabelElement *orderNoElement = [[[QLabelElement alloc]initWithTitle:@"订单编号:"
                                                                 Value:_orderForm.orderNum]autorelease];
    [baseSection addElement:orderNoElement];
    
    QLabelElement *orderDateElement = [[[QLabelElement alloc]initWithTitle:@"下单时间:"
                                                                   Value:_orderForm.orderDate]autorelease];
    [baseSection addElement:orderDateElement];
    
    QLabelElement *phoneNOElement = [[[QLabelElement alloc]initWithTitle:@"手机号码:"
                                                                     Value:_orderForm.phoneNum]autorelease];
    [baseSection addElement:phoneNOElement];
    
    QLabelElement *orderAmtElement = [[[QLabelElement alloc]initWithTitle:@"订单金额:"
                                                                       Value:[NSString stringWithFormat:@"￥%@",_orderForm.orderAmount]]autorelease];
    [orderAmtElement setValueColor:[UIColor redColor]];
    [baseSection addElement:orderAmtElement];
    
    QLabelElement *orderStatusElement = [[[QLabelElement alloc]initWithTitle:@"订单状态:"
                                                                   Value:_orderForm.orderStatus]autorelease];
    [baseSection addElement:orderStatusElement];
    
    
    QSection *productSection = [[[QSection alloc]initWithTitle:@"商品清单"]autorelease];
    [self.root addSection:productSection];
    
    for (TAllScoCharge *charge in _orderForm.charges) {
        TAllscoOrderChargeElement *chargeElement = [[TAllscoOrderChargeElement alloc]initWithGoodForm:charge];
        [productSection addElement:chargeElement];
        [chargeElement release];
    }
    
    QSection *payWaySection = [[[QSection alloc]initWithTitle:@"支付方式"]autorelease];
    [self.root addSection:payWaySection];
    
    QLabelElement *payWayElement = [[[QLabelElement alloc]initWithTitle:@"银联在线"
                                                                       Value:[NSString stringWithFormat:@"￥%@",_orderForm.orderAmount]]autorelease];
    [payWaySection addElement:payWayElement];
}


@end
