//
//  PlanToDiscountModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanToDiscountModel.h"
#import "Product.h"
@implementation PlanToDiscountModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _disArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setDisArrayWith:(NSMutableArray *)array
{
    for(NSDictionary *dict in array)
    {
        Product *product = [[Product alloc]init];
        product.productID = [dict objectForKey:@"commodityID"];
        product.catID = [dict objectForKey:@"categoryID"];
        product.commodityName = [dict objectForKey:@"commodityName"];
        product.attrValue = [dict objectForKey:@"commodityImage"];
        product.sellPrice = [[dict objectForKey:@"marketPrice"] floatValue];
        product.marketPrice = [[dict objectForKey:@"sellPrice"] floatValue];
        product.productDescription = [dict objectForKey:@"describecommodity"] ;
        [self.disArray addObject:product];
    }
}
@end
