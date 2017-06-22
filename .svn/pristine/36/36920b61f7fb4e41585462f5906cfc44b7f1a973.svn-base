//
//  TGoods.m
//  DBuyer
//
//  Created by dilei liu on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TGoods.h"

@implementation TGoods

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.recordId = [dic objectForKey:@"goodsId"];
    self.amountPayable = [dic objectForKey:@"amountPayable"];
    self.attrValue = [dic objectForKey:@"attrValue"];
    self.buyType = [dic objectForKey:@"buyType"];
    self.categoryID = [dic objectForKey:@"categoryID"];
    self.commodityName = [dic objectForKey:@"commodityName"];
    self.number = [[dic objectForKey:@"number"]stringValue];
    self.orderDate = [dic objectForKey:@"orderDate"];
    self.sellPrice = [dic objectForKey:@"sellPrice"];
    self.shopClassification = [dic objectForKey:@"shopClassification"];
    self.type = [dic objectForKey:@"type"];
}

@end
