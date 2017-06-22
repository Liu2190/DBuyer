//
//  TOrder.m
//  DBuyer
//
//  Created by dilei liu on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrder.h"
#import "TGoods.h"

@implementation TOrder

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.goodss = [[NSMutableArray alloc]init];
    
    self.serverId = [dic objectForKey:@"ID"];
    self.addressId = [dic objectForKey:@"addressId"];
    self.amountPayable = [dic objectForKey:@"amountPayable"];
    self.billNumber = [dic objectForKey:@"billNumber"];
    self.buyType = [[dic objectForKey:@"buyType"]stringValue];
    self.destorTime = [dic objectForKey:@"destorTime"];
    self.logisticPattern = [dic objectForKey:@"logisticPattern"];
    self.orderDate = [dic objectForKey:@"orderDate"];
    self.paidAmount = [[dic objectForKey:@"paidAmount"]stringValue];
    self.payDate = [dic objectForKey:@"payDate"];
    self.payPattern = [dic objectForKey:@"payPattern"];
    self.payStatus = [dic objectForKey:@"payStatus"];
    self.price = [dic objectForKey:@"price"];
    self.status = [[dic objectForKey:@"status"]stringValue];
    self.storeID = [dic objectForKey:@"storeID"];
    self.storeName = [dic objectForKey:@"storeName"];
    self.userID = [dic objectForKey:@"userID"];
    
    for (NSDictionary *dict in [dic objectForKey:@"goodsList"]) {
        TGoods *goods = [[TGoods alloc]initWithJsonDictionary:dict];
        [_goodss addObject:goods];
    }
}

@end
