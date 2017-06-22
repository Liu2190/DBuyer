//
//  ShoppingCartServer.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShoppingCartServer.h"
#import "Product.h"
@implementation ShoppingCartServer
-(void)doGetRecommendFromCartBycallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:askAdjustProduct,serviceHost]];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetRecommendFromCartRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSDictionary *requestDictionary = [request userInfo];
    NSDictionary *packData = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
    if([[packData objectForKey:@"status"]intValue]!=0)
    {
        NSString *error = [packData objectForKey:@"msg"];
        id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
        ((void(^)(NSString *))failureCallback)(error);
        return;
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetRecommendFromCartRequest)
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];;
         NSArray *array1=[packData objectForKey:@"recommendCommodity"];
            for(NSDictionary *dict1 in array1)
            {
                Product * product = [[Product alloc] init] ;
                product.commodityName = [dict1 objectForKey:@"title"];
                product.attrValue = [dict1 objectForKey:@"pic_url"];
                product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
                product.sellPrice = [[dict1 objectForKey:@"price"] floatValue];
                product.productID = [dict1 objectForKey:@"id"] ;
                product.keyWord = [dict1 objectForKey:@"keyWord"];
                product.productDescription = [dict1 objectForKey:@"description"];
                [arr addObject:product];
            }

        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(arr);
    }
}
@end
