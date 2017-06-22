//
//  Order.m
//  DBuyer
//
//  Created by lixinda on 13-11-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "Order.h"

@implementation Order

- (id)init
{
    self = [super init];
    if (self) {
        _orderId = [[NSString alloc]init];
        _productList = [[NSMutableArray alloc]init];
    }
    return self;
}
-(id) initOrderWithOrderDic:(NSDictionary *) orderDic{

    [self init];
    self.orderId = [orderDic objectForKey:@"ID"];
    NSArray * goodsList = [orderDic objectForKey:@"goodsList"];
    self.giftPrice = [orderDic objectForKey:@"amountPayable"];
    self.orderType = [orderDic objectForKey:@"buyType"];
    self.paidAmount = [[orderDic objectForKey:@"paidAmount"] floatValue];
    self.destorTime = [[orderDic objectForKey:@"destorTime"] longLongValue];
    for (NSDictionary * goodsDic in goodsList) {
        Product * product = [[Product alloc]initProductWithDic:goodsDic];
        [self.productList addObject:product];
    }
    return self;
}


#pragma mark 返回订单的总价格-- 如果是礼包则返回礼包的价钱。
- (CGFloat)orderCountPrice
{
    CGFloat priceCount = 0.00;
    for (Product *pro in self.productList) {
        priceCount += pro.sellPrice * pro.count;
    }
    if ([self.orderType integerValue] == 8) {
        priceCount = [self.giftPrice floatValue];
    }
    return priceCount;
}



@end
