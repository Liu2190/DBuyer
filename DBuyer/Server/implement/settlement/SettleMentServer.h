//
//  SettleMentServer.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
#import "SettlementModel.h"
/**
 *结算中心有关接口
 */
@interface SettleMentServer : TBaseServer
/**
 *获取用户收货地址列表接口
 */
-(void)doGetDefaultAddressBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取收货方式接口
 */
-(void)doGetDeliveryMethod:(NSString *)productIds andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *获得运费以及自提时间
 */
-(void)doGetFreightAndTimeWithProIds:(NSString *)productIds andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *获得自提默认超市
 */
-(void)doGetDefaultMarketBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *提交礼包类型结算接口
 */
-(void)submitPackageTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict))callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *提交商品详情结算接口
 */
-(void)submitProductDetailTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict))callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *提交购物车类型结算接口
 */
-(void)submitShoppingCartTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict))callback failureCallback:(void(^)(NSString *resp))failureCallback;
@end
