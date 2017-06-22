//
//  HomeSever.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HomeSever.h"
#import "Product.h"
@implementation HomeSever
-(void)doGetHomeAllThingsBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:dHomeAll,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetHomeAllThingsRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取特色商品分类数据接口
-(void)doGetCharacteristicCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:teseyiji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"classId",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetCharacteristicCategory],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取特色商品列表数据接口
-(void)doGetCharacteristicListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *,int))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:teseerji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
     NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Id,@"classId",@"1",@"goodsClass",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetCharacteristicList],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取每月新品分类数据接口
-(void)doGetMonthlyCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Meiyuexinpinyiji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"2",@"classId",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetMonthlyCategory],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取每月新品列表数据接口
-(void)doGetMonthlyListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *,int))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Meiyueerji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Id,@"classId",@"2",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetMonthlyList],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取特价商品列表数据
-(void)doGetBargainGoodsByAndPageNum:(int)currentPage andCallback:(void (^)(NSMutableArray *,int))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:TEJIA,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"3",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetBargainGoods],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取销售排行分类数据
-(void)doGetSalesRankingCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Xiaoshoupaihangyiji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"4",@"classId",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetSalesRankingCategory],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取销售排行列表数据
-(void)doGetSalesRankingListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *,int))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Xiaoshoupaihangerji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:Id,@"classId",@"4",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetSalesRankingList],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

//获取应季商品列表数据
-(void)doGetSeasonalGoodsListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *,int))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Yingji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"5",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetSeasonalGoodsList],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
//获取活动列表数据接口
-(void)doGetActivityListByID:(NSString *)urlString AndPageNum:(int)currentPage callback:(void (^)(NSDictionary *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback
{
   
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:Yingji,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"6",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",[NSString stringWithFormat:@"%d",currentPage],@"page",nil];
    for(NSString *key in [params allKeys]) {
        NSString *value=[params objectForKey:key];
        [item setPostValue:value forKey:key];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetActivityListRequest],USER_INFO_KEY_TYPE, nil]];
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
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetHomeAllThingsRequest)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetCharacteristicCategory)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetCharacteristicList)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];;
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSMutableArray*,int))callback)(array,page_count);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetMonthlyCategory)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetMonthlyList)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];;
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSMutableArray*,int))callback)(array,page_count);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetBargainGoods)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];;
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSMutableArray*,int))callback)(array,page_count);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetSalesRankingCategory)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetSalesRankingList)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];;
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSMutableArray*,int))callback)(array,page_count);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetSeasonalGoodsList)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSMutableArray*,int))callback)(array,page_count);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetActivityListRequest)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        int page_count = [[packData objectForKey:@"page_count"] intValue];
        for(NSDictionary *dict1 in [packData objectForKey:@"commodityList"])
        {
            Product * product = [[Product alloc] init] ;
            product.commodityName = [dict1 objectForKey:@"commodityName"];
            product.attrValue = [dict1 objectForKey:@"commodityImage"];
            product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
            product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
            product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
            product.productID = [dict1 objectForKey:@"ID"] ;
            product.keyWord = [dict1 objectForKey:@"keyWord"];
            product.catID = [dict1 objectForKey:@"categoryID"];
            product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
            [array addObject:product];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*,int))callback)(packData,page_count);
    }
}
@end
