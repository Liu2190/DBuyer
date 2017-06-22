//
//  Product.h
//  DBuyer
//
//  Created by lixinda on 13-11-16.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRecord.h"

@interface Product : TRecord

@property (nonatomic,assign) int type;// 商品类型
@property (nonatomic,retain) NSString *catID;// 分类ID
@property (nonatomic,retain) NSString *productID;//商品ID
@property (nonatomic,retain) NSString *attrValue;// 图片
@property (nonatomic,assign) NSInteger collect;
@property (nonatomic,retain) NSString *commodityName;// 商品名
@property (nonatomic,retain) NSString *goodsID;//购物车ID
@property (nonatomic,assign) CGFloat  marketPrice;// 市场价
@property (nonatomic,assign) NSInteger plan;
@property (nonatomic,assign) CGFloat   sellPrice;// 销售价格
@property (nonatomic,assign) NSInteger shopClassification;
@property (nonatomic,retain) NSString  *keyWord;
@property (nonatomic,assign) NSInteger count;// 商品数量
@property (nonatomic,retain) NSString  *orderDate;
@property (nonatomic,assign) NSInteger logisticPattern;
@property (nonatomic,assign) NSInteger ifCheckout;
@property (nonatomic,retain) NSString *beginTime;
@property (nonatomic,retain) NSString *endTime;
@property (nonatomic,assign) CGFloat  amountPayable;
@property (nonatomic,assign) NSInteger buyType;// 购买类型
@property (nonatomic,retain) NSString *productDescription;//商品描述
-(id)initProductWithDic:(NSDictionary *)dic;

@end
