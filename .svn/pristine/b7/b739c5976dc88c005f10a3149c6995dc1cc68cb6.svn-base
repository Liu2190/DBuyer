//
//  TMasCnpServer.h
//  DBuyer
//
//  Created by dilei liu on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
#import "TKQPayInfo.h"

/**
 * 快钱支付接口
 */
@interface TMasCnpServer : TBaseServer

/**
 * 请求快钱支付界面1
 */
- (void)requestPaidDataByOrderId:(NSString*)orderId andOrderAmount:(NSString*)orderAmount
                     andCallback:(void(^)(TKQPayInfo*))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 发送请求到快钱支付平台
 */
- (void)senderKQPaidDataByParameter:(NSDictionary*)dict
                        andCallback:(void(^)(NSString *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback;
@end
