//
//  Product.m
//  DBuyer
//  商品类
//  Created by lixinda on 13-11-16.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)init
{
    //初始化默认值
    self = [super init];
    if (self) {
        _productID = [[NSString alloc]init];
        _attrValue = [[NSString alloc]init];
        _collect = 0;
        _commodityName = [[NSString alloc]init];
        _goodsID = [[NSString alloc]init];
        _marketPrice=0.0f;
        _plan =0;
        _sellPrice = 0.0f;
        _shopClassification =0;
        _keyWord = [[NSString alloc]init];
        _count = 0;
        _ifCheckout =0;
        _orderDate = [[NSString alloc] init];
        _beginTime = [[NSString alloc]init];
        _endTime = [[NSString alloc]init];
        _amountPayable=0.0f;
        _buyType=0;
        _productDescription = [[NSString alloc]init];
    }
    return self;
}

-(void)setCatID:(NSString *)catId{
    //设置ID
    if (![_catID isEqualToString:catId]) {
        
        _catID = [catId copy];
    }
}

-(id)initProductWithDic:(NSDictionary *)dic{
    //商品详细的数据进行赋值
    [self init];
    NSString * tempStr = nil;
    
    if([dic objectForKey:@"goodsID"]!=nil){
        self.productID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsID"]];
    }
    else{
        self.productID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsId"]];
    }
    self.attrValue = [NSString stringWithFormat:@"%@",[dic objectForKey:@"attrValue"]];
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"collect"]];
    self.collect = tempStr.intValue;
    self.commodityName = [NSString stringWithFormat:@"%@", [dic objectForKey:@"commodityName"]];
    self.goodsID  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ID"]];
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"marketPrice"]];
    self.marketPrice = tempStr.floatValue;
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"plan"]];
    self.plan = tempStr.intValue;
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"sellPrice"]];
    self.sellPrice = tempStr.floatValue;
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"shopClassification"]];
    self.shopClassification = tempStr.intValue;
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
    self.count= tempStr.intValue;
    self.orderDate = [NSString stringWithFormat:@"%@", dic[@"orderDate"]];
    self.amountPayable=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"amountPayable"]] floatValue];
    if (![[dic objectForKey:@"beginTime"] isEqual:[NSNull null]]) {
        tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"beginTime"]];
        //        self.beginTime =[tempStr substringWithRange:NSMakeRange(0, 9)];
        self.beginTime =tempStr;
    }
    
    if (![[dic objectForKey:@"endTime"] isEqual:[NSNull null]]) {
        tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"endTime"]];
        //        self.endTime =[tempStr substringWithRange:NSMakeRange(0, 9)];
        self.endTime =tempStr;
    }
    tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]];
    self.type =tempStr.integerValue;
    self.buyType=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"buyType"]] integerValue];
    if (self.type!=0) {
        tempStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryID"]];
        self.catID =tempStr;
    }
    else
    {
        self.catID = @"";
    }
    self.goodsID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ID"]];
    return self;
}

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.attrValue = [dic valueForKey:@"commodityImage"];
    self.sellPrice = [[dic valueForKey:@"sellPrice"] floatValue];
    self.keyWord = [dic valueForKey:@"keyWord"];
    self.commodityName = [dic valueForKey:@"commodityName"];
    self.marketPrice = [[dic valueForKey:@"marketPrice"] floatValue];
    self.productID = [dic valueForKey:@"ID"];
    self.productDescription = [dic valueForKey:@"description"];
}
@end
