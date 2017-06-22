//
//  TBuyerOrderDetailForm.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBuyerOrderDetailForm.h"
#import "TAllscoOrderBuyerElement.h"
#import "TAllscoGoodsForm.h"

@implementation TBuyerOrderDetailForm

- (id)init {
    self = [super init];
    self.resizeWhenKeyboardPresented =YES;
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QSection *baseSection = [[[QSection alloc]initWithTitle:@"基本信息:"]autorelease];
    [self.root addSection:baseSection];
    
    QLabelElement *orderNumberElement = [[[QLabelElement alloc]
                                          initWithTitle:@"订单编号:" Value:_orderForm.orderNum]autorelease];
    [baseSection addElement:orderNumberElement];
    
    
    QLabelElement *orderDateElement = [[[QLabelElement alloc]
                                        initWithTitle:@"下单时间:" Value:_orderForm.orderDate]autorelease];
    [baseSection addElement:orderDateElement];
    
    QLabelElement *phoneElement = [[[QLabelElement alloc]
                                    initWithTitle:@"手机号码:" Value:_orderForm.phoneNum]autorelease];
    [baseSection addElement:phoneElement];
    
    QLabelElement *orderAmountElement = [[[QLabelElement alloc]
                                          initWithTitle:@"订单金额:" Value:[NSString stringWithFormat:@"￥%@",_orderForm.orderAmount]]autorelease];
    [orderAmountElement setValueColor:[UIColor redColor]];
    [baseSection addElement:orderAmountElement];
    
    QLabelElement *orderStatusElement = [[[QLabelElement alloc]
                                          initWithTitle:@"订单状态:" Value:_orderForm.orderStatus]autorelease];
    [orderStatusElement setValueColor:[UIColor redColor]];
    [baseSection addElement:orderStatusElement];
    
    //
    QSection *orderSection = [[[QSection alloc]initWithTitle:@"商品清单"]autorelease];
    [self.root addSection:orderSection];
    
    for (TAllscoGoodsForm *goodForm in _orderForm.details) {
        TAllscoOrderBuyerElement *chargeElement = [[[TAllscoOrderBuyerElement alloc]initWithGoodForm:goodForm]autorelease];
        [chargeElement setKey:@"chargeElement"];
        [orderSection addElement:chargeElement];
    }
    
    //
    QSection *paySection = [[[QSection alloc]initWithTitle:@"支付方式:"]autorelease];
    [self.root addSection:paySection];
    
    QLabelElement *payWayElement = [[[QLabelElement alloc]
                                          initWithTitle:_orderForm.payWay Value:[NSString stringWithFormat:@"￥%@",_orderForm.orderAmount]]autorelease];
    [payWayElement setValueColor:[UIColor redColor]];
    [paySection addElement:payWayElement];
}


@end
