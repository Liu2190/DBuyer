//
//  TMasCnpServer.m
//  DBuyer
//
//  Created by dilei liu on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TMasCnpServer.h"
#import "TUtilities.h"

@implementation TMasCnpServer

- (void)requestPaidDataByOrderId:(NSString*)orderId andOrderAmount:(NSString*)orderAmount 
                     andCallback:(void(^)(TKQPayInfo*))callback failureCallback:(void(^)(NSString *resp))failureCallback {

    // serviceHost
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@mermb/result/requestDateInfo",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:orderId forKey:@"orderId"];
    [item setPostValue:orderAmount forKey:@"orderAmount"];
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [item setPostValue:dbuyerUser.serverId forKey:@"payerId"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoRequestPaidDataRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)senderKQPaidDataByParameter:(NSDictionary*)dict
                        andCallback:(void(^)(NSString *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback {

    NSString *urlString = [NSString stringWithFormat:@"%@mobilegateway/recvMerchantInfoAction.htm",@"https://www.99bill.com/"];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];

    [item setPostValue:[dict objectForKey:@"inputCharset"] forKey:@"inputCharset"];
    [item setPostValue:[dict objectForKey:@"bgUrl"] forKey:@"bgUrl"];
    [item setPostValue:[dict objectForKey:@"version"] forKey:@"version"];
    [item setPostValue:[dict objectForKey:@"language"] forKey:@"language"];
    [item setPostValue:[dict objectForKey:@"signType"] forKey:@"signType"];
    [item setPostValue:[dict objectForKey:@"merchantAcctId"] forKey:@"merchantAcctId"];
    [item setPostValue:[dict objectForKey:@"payerContactType"] forKey:@"payerContactType"];
    [item setPostValue:[dict objectForKey:@"payerContact"] forKey:@"payerContact"];
    [item setPostValue:[dict objectForKey:@"orderId"] forKey:@"orderId"];
    [item setPostValue:[dict objectForKey:@"orderAmount"] forKey:@"orderAmount"];
    [item setPostValue:[dict objectForKey:@"orderTime"] forKey:@"orderTime"];
    [item setPostValue:[dict objectForKey:@"productName"] forKey:@"productName"];
    [item setPostValue:[dict objectForKey:@"productNum"] forKey:@"productNum"];
    [item setPostValue:[dict objectForKey:@"productId"] forKey:@"productId"];
    [item setPostValue:[dict objectForKey:@"payType"] forKey:@"payType"];
    [item setPostValue:[dict objectForKey:@"redoFlag"] forKey:@"redoFlag"];
    [item setPostValue:[dict objectForKey:@"submitType"] forKey:@"submitType"];
    [item setPostValue:[dict objectForKey:@"key"] forKey:@"key"];
    [item setPostValue:[dict objectForKey:@"signMsg"] forKey:@"signMsg"];

    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoRequestPaidForKQRequest],USER_INFO_KEY_TYPE, nil]];
    
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
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoRequestPaidDataRequest) {
        NSDictionary *dict  = [requestDictionary objectForKey:@"packedData"];
        TKQPayInfo *kqPayInfo = [[TKQPayInfo alloc]initWithJsonDictionary:dict];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TKQPayInfo*))callback)(kqPayInfo);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoRequestPaidForKQRequest) {
        NSDictionary *dict  = [requestDictionary objectForKey:@"packedData"];
        NSString *htmlString = [dict objectForKey:@"respvalue"];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(htmlString);
    }
}

@end
