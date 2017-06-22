//
//  TUMServer.m
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUMServer.h"

@implementation TUMServer

- (void)getUmPayViewDataByOrderId:(NSString*)orderId
                      andCallback:(void(^)(NSString *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@payMent/result/submitOrder",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:orderId forKey:@"orderId"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoUmPayRequest],USER_INFO_KEY_TYPE, nil]];
    
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
        NSString *error = [packData objectForKey:@"msg"]; // 网络连接失败
        id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
        ((void(^)(NSString *))failureCallback)(error);
        
        return;
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoUmPayRequest) {
        NSDictionary *dict  = [requestDictionary objectForKey:@"packedData"];
        NSString *retrunText = [dict objectForKey:@"lanchPayXml"];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(retrunText);
    }
}


@end
