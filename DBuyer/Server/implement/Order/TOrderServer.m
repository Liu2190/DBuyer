//
//  TOrderServer.m
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderServer.h"
#import "TOrderProgress.h"
#import "TOrder.h"

@implementation TOrderServer

- (void)doOrderFollowUpByOrderId:(NSString*)orderId
                     andCallback:(void(^)(TOrderProgress *orderProgress))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/orderFollowUp", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:orderId forKey:@"ID"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetOrderFollowUp],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doQueryOrderByOrderType:(int)orderType
                       callback:(void (^)(NSString *))callback failureCallback:(void (^)(NSString *))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/queryOrderInfo", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:[NSNumber numberWithInt:orderType] forKey:@"type"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoQueryOrderRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)getReturnOrderListByCallback:(void(^)(NSArray *datas))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/queryOrderInfo", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:@"4" forKey:@"type"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:0 forKey:@"page"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d", [UIDevice currentResolution]] forKey:@"size_code"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DogetReturnOrderListRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doGetOrderNumBycallback:(void (^)(TOrdersNum *))callback failureCallback:(void (^)(NSString *))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/settlementcommotitty/getPersonCenter", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetOrderNumRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doOrderSuccess:(NSString*)orderId callback:(void(^)(NSString *ret))callback
       failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@mermb/result/returnDate", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:orderId forKey:@"orderId"];
    [item setPostValue:@"1" forKey:@"payResult"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoOrderPaySuccessRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doOrderSuccess:(NSString*)orderId andParameter:(TAllScoCharge*)charge
              callback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@mermb/result/returnDate", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:orderId forKey:@"orderId"];
    [item setPostValue:@"1" forKey:@"payResult"];
    
    [item setPostValue:charge.phoneNumber forKey:@"account"];
    [item setPostValue:charge.chargeAmount forKey:@"amount"];
    [item setPostValue:charge.chargeCards forKey:@"chargeCards"];
    
    NSString *flag = @"01";
    if ([charge.payIndexValue isEqualToString:@"0"]) {
        flag = @"01";
    } else {
        flag = @"02";
    }
    [item setPostValue:flag forKey:@"flag"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoOrderPaySuccessRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doOrderSuccessForBuyer:(NSString*)orderId andParameter:(TAllscoGoodPayForm*)payForm
                      callback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@doOrderSuccessForBuyer", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:orderId forKey:@"orderId"];
    [item setPostValue:@"1" forKey:@"payResult"];
    
    [item setPostValue:payForm.phoneNum forKey:@"account"];
    [item setPostValue:[NSString stringWithFormat:@"%i",payForm.amount] forKey:@"amount"];
    [item setPostValue:payForm.purchases forKey:@"purchases"];
    [item setPostValue:payForm.serverId forKey:@"dbuyerOrderId"];
    
    NSString *flag = @"01";
    if (payForm.payFlag == 0) {
        flag = @"01";
    } else {
        flag = @"02";
    }
    [item setPostValue:flag forKey:@"flag"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoOrderPaySuccessRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [super requestFinished:request];
    NSDictionary *requestDictionary = [request userInfo];
    NSDictionary *packData = [requestDictionary objectForKey:@"packedData"];
    
    if ([[packData objectForKey:@"status"]intValue] != 0) {
        NSString *error = [packData objectForKey:@"msg"];
        id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
        ((void(^)(NSString *))failureCallback)(error);
        
        return;
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoQueryOrderRequest) {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString *))callback)(@"");
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetOrderNumRequest) {
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        TOrdersNum *ordersNum = [[TOrdersNum alloc]initWithJsonDictionary:dict];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TOrdersNum *))callback)(ordersNum);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetOrderFollowUp) {
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        TOrderProgress *orderProgress = [[TOrderProgress alloc]initWithJsonDictionary:dict];
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TOrderProgress*))callback)(orderProgress);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DogetReturnOrderListRequest) {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        NSArray *orders = [dict objectForKey:@"orderInfoList"];
        for (NSDictionary *orderDict in orders) {
            TOrder *order = [[TOrder alloc]initWithJsonDictionary:orderDict];
            [datas addObject:order];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(datas);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoRequestPaidDataRequest) {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        NSArray *orders = [dict objectForKey:@"orderInfoList"];
        for (NSDictionary *orderDict in orders) {
            TOrder *order = [[TOrder alloc]initWithJsonDictionary:orderDict];
            [datas addObject:order];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(datas);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoOrderPaySuccessRequest) {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        NSLog(@"%@",packData);
        ((void(^)(NSString*))callback)(@"aaa");
    }
    
    
    
    
}

@end
