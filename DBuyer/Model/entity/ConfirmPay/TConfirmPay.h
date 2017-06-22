//
//  TConfirmPay.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

/**
 * 支付表单实体
 */
@interface TConfirmPay : TRecord

/**
 * 多订单支付时对应订单ID字符串，订单号之间以','隔开
 */
@property (nonatomic,retain)NSString *orderIdList;

/**
 * 订单支付时映射出来一个订单标识符，以并多订单支付时可以统一改变这些订单的状态
 */
@property (nonatomic,retain)NSString *orderId;

/**
 * 本次支付所需金额
 */
@property (nonatomic,retain)NSString *paidAmount;

/**
 * 本次支付所获积分(如果此次支付是多个订单，则积分应该累加总和)
 */
@property (nonatomic,retain)NSString *integral;

/**
 * 交易时间
 */
@property (nonatomic,retain)NSString *orderDate;

/**
 * 支付方式列表
 */
@property (nonatomic,retain)NSArray *payWays;

@end
