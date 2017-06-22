//
//  TUMServer.h
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"

@interface TUMServer : TBaseServer

/**
 * 获取银联支付界面所需数据
 */
- (void)getUmPayViewDataByOrderId:(NSString*)orderId
    andCallback:(void(^)(NSString *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback;

@end
