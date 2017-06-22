//
//  TOrderServer.h
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderLocalServer.h"
#import "TOrderProgress.h"
#import "TOrdersNum.h"
#import "TAllScoCharge.h"
#import "TAllscoGoodPayForm.h"

@interface TOrderServer : TOrderLocalServer

/**
 * 退款订单进度查询
 *orderId 退款订单刻录ID
 */
- (void)doOrderFollowUpByOrderId:(NSString*)orderId andCallback:(void(^)(TOrderProgress *orderProgress))callback
                  failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 获取退款订单列表
 */
- (void)getReturnOrderListByCallback:(void(^)(NSArray *datas))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 获取订单数量
 */
- (void)doGetOrderNumBycallback:(void(^)(TOrdersNum *ordersNum))callback failureCallback:(void(^)(NSString *resp))failureCallback;


/**
 * 通过订单类型查询订单信息
 */
- (void)doQueryOrderByOrderType:(int)orderType callback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 订单支付成功的回调方法
 */
- (void)doOrderSuccess:(NSString*)orderId
              callback:(void(^)(NSString *ret))callback
       failureCallback:(void(^)(NSString *resp))failureCallback;


/**
 * 充值奥斯卡提交订单状态＝＝＝＝＝》快钱
 */
- (void)doOrderSuccess:(NSString*)orderId andParameter:(TAllScoCharge*)charge
              callback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 购买奥斯卡提交订单状态＝＝＝》快钱
 */
- (void)doOrderSuccessForBuyer:(NSString*)orderId andParameter:(TAllscoGoodPayForm*)payForm
              callback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback;


@end
