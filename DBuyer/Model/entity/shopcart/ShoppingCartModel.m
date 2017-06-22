//
//  ShoppingCartModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShoppingCartModel.h"
#import "Product.h"
#import "DBManager.h"

@implementation ShoppingCartModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _allProductArray = [[NSMutableArray alloc]init];
        _selectProductArray = [[NSMutableArray alloc]init];
        _deleteCellRow = 0;
        _totalPrice = 0.0f;
        _isLogined = YES;
        _tipsFromNet = [[NSString alloc]init];
    }
    return self;
}
-(id)initShoppingCartModelWith:(NSMutableDictionary *)dict
{
    [self init];
    [self.allProductArray removeAllObjects];
    [self.selectProductArray removeAllObjects];
    if([self notEmptyOfString:[dict objectForKey:@"casesMsg"]])
    {
        self.tipsFromNet = [dict objectForKey:@"casesMsg"];
    }
    NSArray *dataArray = [dict objectForKey:@"goods_list"];
    for(NSDictionary *item in dataArray)
    {
        Product *product = [[Product alloc]initProductWithDic:item];//购物车排序，将活动商品置顶
        [self.allProductArray addObject:product];
        [self.selectProductArray addObject:product];
    }
    for (Product * product in self.selectProductArray)
    {
        self.totalPrice += product.sellPrice * product.count;
    }
    self.deleteCellRow = 0;
    return self;
}
//从数据库中读取数据
-(id)initShoppingCartModelWithDBManager
{
    [self init];
    [self.allProductArray removeAllObjects];
    [self.selectProductArray removeAllObjects];
    NSMutableArray *dataArray= [[DBManager sharedDatabase] readThingFromCarlist];
    for(NSDictionary *item in dataArray)
    {
        Product *product = [[Product alloc]initProductWithDic:item];
        [self.allProductArray addObject:product];
        [self.selectProductArray addObject:product];
    }
    for (Product * product in self.selectProductArray)
    {
        self.totalPrice += product.sellPrice * product.count;
    }
    self.deleteCellRow = 0;
    return self;
}
-(float)shoppingCartTotalPrice
{
    float price = 0.0f;
    for(Product *product in self.selectProductArray)
    {
        price += product.sellPrice * product.count;
    }
    return price;
}
-(BOOL)notEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
@end
