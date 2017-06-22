//
//  TOrder.h
//  DBuyer
//
//  Created by dilei liu on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TOrder : TRecord

/**
 * 获取地址id
 */
@property (nonatomic,retain)NSString *addressId;

/**
 * 应付金额
 */
@property (nonatomic,retain)NSString *amountPayable;

/**
 *订单号
 */
@property (nonatomic,retain)NSString *billNumber;

/**
 * 购买类型
 */
@property (nonatomic,retain)NSString *buyType;


/**
 * 消失时间
 */
@property (nonatomic,retain)NSString *destorTime;


/**
 * 订单下的商品
 */
@property (nonatomic,retain) NSMutableArray *goodss;


/**
 * 收货方式
 */
@property (nonatomic,retain)NSString *logisticPattern;

/**
 * 已付金额
 */
@property (nonatomic,retain)NSString *paidAmount;

/**
 * 支付日期
 */
@property (nonatomic,retain)NSString *payDate;

/**
 *支付方式
 */
@property (nonatomic,retain)NSString *payPattern;

/**
 * 支付状态
 */
@property (nonatomic,retain)NSString *payStatus;

/**
 * 价格
 */
@property (nonatomic,retain)NSString *price;

/**
 * 订单状态
 */
@property (nonatomic,retain)NSString *status;

/**
 *
 */
@property (nonatomic,retain)NSString *storeID;

/**
 * 订单日期
 */
@property (nonatomic,retain)NSString *orderDate;



/**
 *
 */
@property (nonatomic,retain)NSString *storeName;

/**
 * 用户ID
 */
@property (nonatomic,retain)NSString *userID;


@end
