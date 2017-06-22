//
//  TStoreMapServer.m
//  DBuyer
//
//  Created by dilei liu on 14-4-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TStoreMapServer.h"
#import "TMapStore.h"

@implementation TStoreMapServer


- (void)doGetAddress2Map:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/store/queryStoreByStoreSort",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAddress2MapRequest],USER_INFO_KEY_TYPE, nil]];
    
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
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAddress2MapRequest) {
        NSMutableArray *storeDatas = [[NSMutableArray alloc]init];
        NSArray *storeList = [packData objectForKey:@"storeList"];
        for (NSDictionary *dict in storeList) {
            TMapStore *mapStore = [[TMapStore alloc]initWithJsonDictionary:dict];
            [storeDatas addObject:mapStore];
            [mapStore release];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(storeDatas);
    }
    
}


@end
