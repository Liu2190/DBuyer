//
//  SearchSever.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SearchSever.h"
#import "GiftCell.h"
#import "Product.h"
@implementation SearchSever
-(void)doSearchGoodsByName:(NSString *)productName andCallback:(void(^)(NSArray *productArray)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/search/queryView", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    [item setPostValue:productName forKey:@"title"];
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoSearchGoodsRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)doSearchEnterWordsByWords:(NSString *)productName andCallback:(void(^)(NSArray *productArray)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/search/queryWordTwo", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    [item setPostValue:productName forKey:@"keyWord"];
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DosearchEnterConnectWordsRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)doGetRecommendedGoodsBycallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/search/queryHotKeyWord",serviceHost]];
    
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetRecommendedGoodsRequest],USER_INFO_KEY_TYPE, nil]];
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
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetRecommendedGoodsRequest)
    {
        if([[packData objectForKey:@"status"]intValue]!=0)
        {
            NSString *error = [packData objectForKey:@"msg"];
            id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
            ((void(^)(NSString *))failureCallback)(error);
            return;
        }
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        NSMutableArray * returnBox = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in [dataDict objectForKey:@"returnlistbBox"]) {
            GiftCell *giftCell = [[[GiftCell alloc]init] autorelease];
            giftCell.boxPicUrl = [dic objectForKey:@"attrValue"];
            giftCell.title = [dic objectForKey:@"title"];
            giftCell.boxDescription = [dic objectForKey:@"description"];
            giftCell.tpye = [[dic objectForKey:@"findType"] integerValue];
            giftCell.price = [[dic objectForKey:@"boxPrice"] floatValue];
            giftCell.savePrice = [[dic objectForKey:@"totalPrice"] floatValue];
            giftCell.gid = [dic objectForKey:@"id"];
            [returnBox addObject:giftCell];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(returnBox);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoSearchGoodsRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        NSMutableArray * returnBox = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in [dataDict objectForKey:@"returnlist"]) {
            Product * product = [[[Product alloc] init] autorelease];
            product.commodityName = [dic objectForKey:@"title"];
            product.productID = [dic objectForKey:@"ID"];
            product.sellPrice = [[dic objectForKey:@"sellPrice"] floatValue];
            product.attrValue = [dic objectForKey:@"commodityImage"];
            product.keyWord = [dic objectForKey:@"keyWord"];
            product.productDescription = [dic objectForKey:@"description"];
            product.type = [[dic objectForKey:@"type"] intValue];
            [returnBox addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(returnBox);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DosearchEnterConnectWordsRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]];
        NSMutableArray * returnBox = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in [dataDict objectForKey:@"key_list"])
        {
            [returnBox addObject:dic];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(returnBox);
    }
}

@end