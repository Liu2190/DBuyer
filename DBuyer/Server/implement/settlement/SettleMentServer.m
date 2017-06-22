//
//  SettleMentServer.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettleMentServer.h"
#import "Product.h"
@implementation SettleMentServer

-(void)doGetDeliveryMethod:(NSString *)productIds andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/deliveryMethod",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    [item setPostValue:productIds forKey:@"commodityIds"];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetDeliveryMethodRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)doGetDefaultAddressBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kQueryAddressList, serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAddressListRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

-(void)doGetFreightAndTimeWithProIds:(NSString *)productIds andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:TransportationPrice,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [item setPostValue:productIds forKey:@"ids"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetFreightAndTimeRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

-(void)doGetDefaultMarketBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:queryUserAttrType,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [item setPostValue:@"1" forKey:@"type"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetDefaultMarketRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

/* 礼包结算规则
 序号	参数描述	参数名称	约束	参数类型及长度	参数值说明	备注
 1	礼包id        lid	必填	string
 2	综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
 3	精超ID        jingAreaId	可选	string	有就填
 4	使用积分        useJF	可选	int
 5	地址ID        areaId	可选	string	有就填	物流时必填
 6	综自提时间	zhongZiTime	可选	string	有就填	自提必填
 7	精自提时间	jingZiTime	可选	string	同上	同上
 8	修改的地址	areaAdd	可选	string	有就填	物流必填
 9	综合物流费	zfreight	可选	int	同上
 10	精物流费        jfreight	可选	int	同上
 11	商品数量        count	必填	int
 12	礼包商品列	ids	必填	Jsonarray	同礼包结算一样
 */
-(void)submitPackageTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    //礼包结算
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:insertBoxOrder,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [item setPostValue:[NSString stringWithFormat:@"%d", [setModel.productlistArray count]] forKey:@"count"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:[MD5 md5] forKey:@"verify"];
    [item setPostValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"] forKey:@"versionNum"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d",[UIDevice currentResolution]] forKey:@"size_code"];
    
    [item setPostValue:setModel.productIdsAndCounts forKey:@"ids"];
    [item setPostValue:setModel.gid forKey:@"lid"];
    [item setPostValue:@"0" forKey:@"useJF"];
    if(setModel.logisticsStatus)
    {
        //物流方式
        //地址ID        areaId	可选	string	有就填	物流时必填
        //修改的地址	areaAdd	可选	string	有就填	物流必填
        //综合物流费	zfreight	可选	int	同上
        NSString *areaAdd=[NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",setModel.addressItem.name,setModel.addressItem.phoneNumber,setModel.addressItem.address];
        [item setPostValue:areaAdd forKey:@"areaAdd"];    // 修改的地址
        [item setPostValue:setModel.addressItem.addressId forKey:@"areaId"];   // 地址ID
        [item setPostValue:[NSString stringWithFormat:@"%.0f", setModel.freight] forKey:@"zfreight"];   // 物流费
    }
    if(!setModel.logisticsStatus)
    {
        //自提方式
        //综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
        //综自提时间	zhongZiTime	可选	string	有就填	自提必填
        [item setPostValue:setModel.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
        NSString *strZiti=[setModel.takeBySelfTime substringToIndex:([setModel.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [item setPostValue:zitiTime forKey:@"zhongZiTime"];
        [item setPostValue:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoSubmitPackageSettlementRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

/* 商品详情结算规则
 序号	参数描述	参数名称           约束	参数类型及长度     参数值说明	备注
 1	商品id        id              必填	string
 2	综合超市ID	 zongAreaId      可选	string          有就填无限制	自提时必填
 3	精超ID        jingAreaId      可选	string          有就填
 4	使用积分       useJF           可选	int
 5	地址ID        areaId          可选	string          有就填	物流时必填
 6	综自提时间	  zhongZiTime     可选	string          有就填	自提必填
 7	精自提时间	  jingZiTime	  可选	string          同上	同上
 8	修改的地址	  areaAdd         可选	string          有就填	物流必填
 9	综合物流费	  zfreight        可选	int             同上
 10	精物流费       jfreight        可选	int             同上
 11	商品数量       count            必填	int
 12	商品类型       type             必填	int
 13	商品分类       categoryID       可选	string	Type=1  必填
*/
-(void)submitProductDetailTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    //商品详情结算
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:insertGoodsOrder,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    Product *pro = [setModel.productlistArray objectAtIndex:0];
    [item setPostValue:pro.productID forKey:@"id"];                       // 商品ID
    [item setPostValue:[NSString stringWithFormat:@"%d", pro.count] forKey:@"count"];                 // 商品数量
    if(pro.type==1){
        [item setPostValue:@"1" forKey:@"type"];        // 商品类型
        [item setPostValue:pro.catID forKey:@"categoryID"];            // 商品分类ID
    }
    if(pro.type == 0)
    {
        [item setPostValue:@"0" forKey:@"type"];
    }
    if(setModel.logisticsStatus)
    {
        //物流方式
        //地址ID        areaId	可选	string	有就填	物流时必填
        //修改的地址	areaAdd	可选	string	有就填	物流必填
        //综合物流费	zfreight	可选	int	同上
        NSString *areaAdd=[NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",setModel.addressItem.name,setModel.addressItem.phoneNumber,setModel.addressItem.address];
        [item setPostValue:areaAdd forKey:@"areaAdd"];    // 修改的地址
        [item setPostValue:setModel.addressItem.addressId forKey:@"areaId"];   // 地址ID
        [item setPostValue:[NSString stringWithFormat:@"%.0f", setModel.freight] forKey:@"zfreight"];   // 物流费
    }
    if(!setModel.logisticsStatus)
    {
        //自提方式
        //综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
        //综自提时间	zhongZiTime	可选	string	有就填	自提必填
        [item setPostValue:setModel.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
        NSString *strZiti=[setModel.takeBySelfTime substringToIndex:([setModel.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [item setPostValue:zitiTime forKey:@"zhongZiTime"];
        [item setPostValue:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoSubmitProductSettlementRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
/* 购物车结算规则
 1	商品id列表	ids  	必填	Jsonarray	{“1”:”2”}
 2	综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
 3	精超ID	jingAreaId	可选	string	有就填
 4	使用积分	useJF	可选	int
 5	地址ID	areaId	可选	string	有就填	物流时必填
 6	综自提时间	zhongZiTime	可选	string	有就填	自提必填
 7	精自提时间	jingZiTime	可选	string	同上	同上
 8	修改的地址	areaAdd	可选	string	有就填	物流必填
 9	综合物流费	zfreight	可选	int	同上
 10	精物流费	jfreight	可选	int	同上
 */
-(void)submitShoppingCartTypeSettlementWith:(SettlementModel *)setModel andCallback:(void(^)(NSDictionary *dict)) callback failureCallback:(void(^)(NSString *resp))failureCallback
{
    //购物车结算
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:PushOrder,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc]initWithURL:url];
    item.stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [item setPostValue:setModel.productIdsAndCounts forKey:@"ids"];                // 商品ID
    if(setModel.logisticsStatus)
    {
        //物流方式
        //地址ID        areaId	可选	string	有就填	物流时必填
        //修改的地址	areaAdd	可选	string	有就填	物流必填
        //综合物流费	zfreight	可选	int	同上
        NSString *areaAdd=[NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",setModel.addressItem.name,setModel.addressItem.phoneNumber,setModel.addressItem.address];
        [item setPostValue:areaAdd forKey:@"areaAdd"];    // 修改的地址
        [item setPostValue:setModel.addressItem.addressId forKey:@"areaId"];   // 地址ID
        [item setPostValue:[NSString stringWithFormat:@"%.0f", setModel.freight] forKey:@"zfreight"];   // 物流费
    }
    if(!setModel.logisticsStatus)
    {
        //自提方式
        //综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
        //综自提时间	zhongZiTime	可选	string	有就填	自提必填
        [item setPostValue:setModel.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
        NSString *strZiti=[setModel.takeBySelfTime substringToIndex:([setModel.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [item setPostValue:zitiTime forKey:@"zhongZiTime"];
        [item setPostValue:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoSubmitCartSettlementRequest],USER_INFO_KEY_TYPE, nil]];
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
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetDeliveryMethodRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoGetAddressListRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoGetFreightAndTimeRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoGetDefaultMarketRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoSubmitPackageSettlementRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoSubmitProductSettlementRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue]==DoSubmitCartSettlementRequest)
    {
        NSDictionary *dataDict = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(dataDict);
    }
}
@end
