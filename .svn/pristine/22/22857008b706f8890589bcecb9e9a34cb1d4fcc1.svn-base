//
//  Order.h
//  DBuyer
//
//  Created by lixinda on 13-11-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"


@interface Order : NSObject

@property (nonatomic,copy)NSString * orderId;

@property (nonatomic,copy) NSMutableArray * productList;
@property (nonatomic, retain) NSString *orderType;  // 订单类型，8为礼包
@property (nonatomic, retain) NSString *giftPrice;  // 如果此订单是礼包的订单总价钱（使用前需要判断 orderType 是否＝＝8）
@property (nonatomic, assign) CGFloat paidAmount;  // 应付价格，此价格为接口返回（里面已经计算了积分、物流等各种费用）
@property (nonatomic, assign) NSInteger integral;   // 此订单反的积分
@property (nonatomic, assign) long long destorTime; // 订单结束时间

//订单ID	ID	必填
//商品列表	goodsList	必填
//商品名称	commodityName
//商品卖价	sellPrice
//商品数量	number
//商品ID	goodsId
//下单时间	orderDate
//商店类别	shopClassification
//商品图片	attrValue

/**
    通过一个字典构造一个订单对象
 */
-(id) initOrderWithOrderDic:(NSDictionary *) orderDic;



/**
 *  返回订单的总价，如果是礼包订单则返回礼包的价格，此方法即将废弃，因为服务器那边可能会假如 paidAmount 字段。
 *
 *  @return 订单中的商品总价
 */
- (CGFloat)orderCountPrice;

@end
