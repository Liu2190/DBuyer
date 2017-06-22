//
//  TAllScoServer.h
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
#import "TAllscoOrderForm.h"

/**
 * 商银信支付有关接口
 */
@interface TAllScoServer : TBaseServer


/**
 * 获取验证码
 */
- (void)getValidataByPhoneNumber:(NSString*)phoneNumber
                     andCallback:(void(^)(NSString *resp))callback
                 failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 查询绑定的卡号
 */
- (void)selectCardsByPhoneNumber:(NSString*)phoneNumber
                     andCallback:(void(^)(NSArray *datas,NSString *usageFor))callback
                 failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 支付接口 
 @param orderNumber:订单号orderData:订单时间
        orderAmount:订单金额phoneNumber:app帐号
        payCards:支付卡号verifyCode:下发验证码
 */
- (void)doPayCardByOrderNo:(NSString*)orderNumber andOrderDate:(NSString*)orderData andOrderAmount:(NSString*)orderAmount andAccount:(NSString*)phoneNumber
               andPayCards:(NSString*)payCards andVerifyCode:(NSString*)verifyCode
            andCallback:(void(^)(NSString *datas))callback failureCallback:(void(^)(NSString *resp))failureCallback;


/**
 * 奥斯卡绑定接口
 */
- (void)doBingCardByPhoneNumber:(NSString*)phoneNumber
                  andCardNumber:(NSString*)cardNumber
              andValidataNumber:(NSString*)validataNumbe
                    andCallback:(void(^)(NSString *datas))callback
                failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 奥斯卡充值接口
 */
- (void)doChargeCardByPhoneName:(NSString*)phoneNumber
                andChargeAmount:(NSString*)orderAmount
                 andChargeCards:(NSString*)chargeCards
                        andFlag:(NSString*)flag
                      orderDate:(NSString*)orderDate
                    andCallback:(void(^)(NSString *datas,NSString *umpData))callback
                failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 获取奥斯卡商品列表
 */
- (void)doGetAllscoCardGoodsByCallback:(void(^)(NSArray *datas))callback
                       failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 购买奥斯卡接口
 */
- (void)doBuyerAllscoCardByAccount:(NSString*)account andAmount:(int)amount
                        andPayFlag:(int)payFlag andPurchases:(NSString*)purchases
                  andTempPurchases:(NSString*)tempPurchases
                       andCallback:(void(^)(NSString *datas,NSString *umpData))callback
                   failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 查询购买奥斯卡订单列表
 */
- (void)doGetBuyerAllscoOrderListByAccount:(NSString*)account
                                 andPageNo:(int)pageNo andPageSize:(int)pageSize
                               andCallback:(void(^)(NSArray*datas))callback
                           failureCallback:(void(^)(NSString *resp))failureCallback;


/**
 * 查询购买奥斯卡订单详情
 */
- (void)doGetBuyerCardDetailByAccount:(NSString*)account
                           andOrderNo:(NSString*)orderNO
                          andCallback:(void(^)(TAllscoOrderForm *orderForm))callback
                      failureCallback:(void(^)(NSString *resp))failureCallback;


/**
 * 查询储值奥斯卡订单列表
 */
- (void)doGetChargeAllscoOrderListByAccount:(NSString*)account
                                  andPageNo:(int)pageNO
                                andPageSize:(int)pageSize
                                andCallback:(void(^)(NSArray*datas))callback
                            failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 查询储值奥斯卡订单详情
 */
- (void)doGetChareCardDetailByAccount:(NSString*)account
                           andOrderNo:(NSString*)orderNO
                          andCallback:(void(^)(TAllscoOrderForm *orderForm))callback
                      failureCallback:(void(^)(NSString *resp))failureCallback;


@end
