//
//  TAllScoServer.m
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoServer.h"
#import "TAllScoCard.h"
#import "TAllscoOrderForm.h"
#import "TAllscoGoodsForm.h"

@implementation TAllScoServer


- (void)getValidataByPhoneNumber:(NSString*)phoneNumber
                     andCallback:(void(^)(NSString *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/sendVerifyCode",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:phoneNumber forKey:@"account"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoAllScoValidataRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)selectCardsByPhoneNumber:(NSString*)phoneNumber
                     andCallback:(void(^)(NSArray *datas,NSString *usageFor))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/getCard",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:phoneNumber forKey:@"account"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoAllScoCardsListRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];

}

- (void)doPayCardByOrderNo:(NSString*)orderNumber andOrderDate:(NSString*)orderData
            andOrderAmount:(NSString*)orderAmount andAccount:(NSString*)phoneNumber
               andPayCards:(NSString*)payCards andVerifyCode:(NSString*)verifyCode
               andCallback:(void(^)(NSString *datas))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/payCard",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:orderNumber forKey:@"orderNo"];
    [item setPostValue:orderData forKey:@"orderDate"];
    [item setPostValue:orderAmount forKey:@"amount"];
    [item setPostValue:phoneNumber forKey:@"account"];
    [item setPostValue:payCards forKey:@"payCards"];
    [item setPostValue:verifyCode forKey:@"verifyCode"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DotAllScoCardsPayReques],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
    
}

- (void)doBingCardByPhoneNumber:(NSString*)phoneNumber andCardNumber:(NSString*)cardNumber andValidataNumber:(NSString*)validataNumbe andCallback:(void(^)(NSString *datas))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/bingCard",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:phoneNumber forKey:@"account"];
    [item setPostValue:cardNumber forKey:@"cardNo"];
    [item setPostValue:validataNumbe forKey:@"bingCode"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DotAllScoCardsBindingReques],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];

}

/**
 * flag 枚举说明 
 * 0:代表银行   1:代表快钱
 */
- (void)doChargeCardByPhoneName:(NSString*)phoneNumber andChargeAmount:(NSString*)orderAmount
                 andChargeCards:(NSString*)chargeCards andFlag:(NSString*)flag orderDate:(NSString*)orderDate
                    andCallback:(void(^)(NSString *datas,NSString*umpData))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/createOrder",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:phoneNumber forKey:@"account"];
    [item setPostValue:orderAmount forKey:@"amount"];
    [item setPostValue:chargeCards forKey:@"chargeCards"];
    [item setPostValue:orderDate forKey:@"orderDate"];
    if ([flag isEqualToString:@"0"]) {
        flag = @"01";
    } else {
        flag = @"02";
    }
    
    [item setPostValue:flag forKey:@"flag"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DotAllScoCardsChargeRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

/**
 * 查询虚拟卡商品列表
 */
- (void)doGetAllscoCardGoodsByCallback:(void(^)(NSArray *datas))callback
                       failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/commodity/getAskCommodityinfo",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAllScoCardsGoodsRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doBuyerAllscoCardByAccount:(NSString*)account andAmount:(int)amount andPayFlag:(int)payFlag
                      andPurchases:(NSString*)purchases andTempPurchases:(NSString*)tempPurchases
                       andCallback:(void(^)(NSString *datas,NSString *umpData))callback
                   failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/order/createAskBuyOrder",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSString *flag = @"01"; if (payFlag == 1) flag = @"02";
    
    [item setPostValue:account forKey:@"account"];
    [item setPostValue:[NSString stringWithFormat:@"%i",amount] forKey:@"amount"];
    [item setPostValue:flag forKey:@"flag"];
    [item setPostValue:purchases forKey:@"purchases"];
    [item setPostValue:tempPurchases forKey:@"tempPurchases"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoBuyerAllScoCardsGoodsRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doGetBuyerAllscoOrderListByAccount:(NSString*)account andPageNo:(int)pageNo andPageSize:(int)pageSize
                               andCallback:(void(^)(NSArray*datas))callback
                           failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/getBuyCardList",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSDateFormatter *hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [hzdateParserFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *timeStamp = [hzdateParserFormatter stringFromDate:[NSDate date]];
    
    [item setPostValue:account forKey:@"account"];
    [item setPostValue:timeStamp forKey:@"timeStamp"];
    [item setPostValue:[NSString stringWithFormat:@"%i",pageSize] forKey:@"pageSize"];
    [item setPostValue:[NSString stringWithFormat:@"%i",pageNo] forKey:@"pageNo"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAllScoBuyerOrderListRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doGetBuyerCardDetailByAccount:(NSString*)account
                           andOrderNo:(NSString*)orderNO
                          andCallback:(void(^)(TAllscoOrderForm *orderForm))callback
                      failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/getBuyCardDetail",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSDateFormatter *hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [hzdateParserFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *timeStamp = [hzdateParserFormatter stringFromDate:[NSDate date]];
    
    [item setPostValue:account forKey:@"account"];
    [item setPostValue:timeStamp forKey:@"timeStamp"];
    [item setPostValue:orderNO forKey:@"orderNo"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAllScoBuyerOrderDetailRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doGetChargeAllscoOrderListByAccount:(NSString*)account andPageNo:(int)pageNO andPageSize:(int)pageSize
                                andCallback:(void(^)(NSArray*datas))callback
                            failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/getChargeCardList",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSDateFormatter *hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [hzdateParserFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *timeStamp = [hzdateParserFormatter stringFromDate:[NSDate date]];
    
    [item setPostValue:account forKey:@"account"];
    [item setPostValue:timeStamp forKey:@"timeStamp"];
    [item setPostValue:[NSString stringWithFormat:@"%i",pageSize] forKey:@"pageSize"];
    [item setPostValue:[NSString stringWithFormat:@"%i",pageNO] forKey:@"pageNo"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAllScoChargeOrderListRequest],USER_INFO_KEY_TYPE, nil]];
    
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doGetChareCardDetailByAccount:(NSString*)account
                           andOrderNo:(NSString*)orderNO
                          andCallback:(void(^)(TAllscoOrderForm *orderForm))callback
                      failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/card/getChargeCardDetail",serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSDateFormatter *hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [hzdateParserFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *timeStamp = [hzdateParserFormatter stringFromDate:[NSDate date]];
    
    [item setPostValue:account forKey:@"account"];
    [item setPostValue:timeStamp forKey:@"timeStamp"];
    [item setPostValue:orderNO forKey:@"orderNo"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAllScoChargeOrderDetailRequest],USER_INFO_KEY_TYPE, nil]];
    
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
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoAllScoValidataRequest) {
        NSString *success = [packData objectForKey:@"msg"];
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(success);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoAllScoCardsListRequest) {
        NSDictionary *dic = [packData objectForKey:@"bindCards"];
        NSString *usageFor = [packData objectForKey:@"usageofcard"];
        NSMutableArray *datas = [[[NSMutableArray alloc]init]autorelease];
        
        
        for (NSDictionary *dict in dic) {
            TAllScoCard *allscoCard = [[TAllScoCard alloc]initWithJsonDictionary:dict];
            [datas addObject:allscoCard];
            [allscoCard release];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*,NSString*))callback)(datas,usageFor);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DotAllScoCardsPayReques) {
        NSString *msg = [packData objectForKey:@"msg"];
        
        if ([[packData objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            msg = [packData objectForKey:@"retMsg"];
            id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
            ((void(^)(NSString *))failureCallback)(msg);
            
            return;
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(msg);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DotAllScoCardsBindingReques) {
        NSString *msg = [packData objectForKey:@"msg"];
            
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(msg);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DotAllScoCardsChargeRequest) {
        NSString *msg = [packData objectForKey:@"msg"];
        NSString *orderId = [packData objectForKey:@"orderId"];
        NSString *umpData = [packData objectForKey:@"lanchPayXml"];
        
        if ([[packData objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            msg = [packData objectForKey:@"retMsg"];
            id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
            ((void(^)(NSString *))failureCallback)(msg);
            
            return;
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*,NSString*))callback)(orderId,umpData);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAllScoCardsGoodsRequest) {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in [packData objectForKey:@"askList"]) {
            TAllscoGoodsForm *allscoGoodsForm = [[TAllscoGoodsForm alloc]initWithJsonDictionary:dict];
            [datas addObject:allscoGoodsForm];
            [allscoGoodsForm release];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(datas);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoBuyerAllScoCardsGoodsRequest) {
        NSString *msg = [packData objectForKey:@"msg"];
        NSString *orderId = [packData objectForKey:@"orderId"];
        NSString *umpData = [packData objectForKey:@"lanchPayXml"];
        
        if ([[packData objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            msg = [packData objectForKey:@"retMsg"];
            id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
            ((void(^)(NSString *))failureCallback)(msg);
            
            return;
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*,NSString*))callback)(orderId,umpData);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAllScoBuyerOrderListRequest) {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        
        NSArray *orders = [packData objectForKey:@"trans"];
        for (NSDictionary *orderDic in orders) {
            TAllscoOrderForm *orderForm = [[TAllscoOrderForm alloc]initWithJsonDictionary:orderDic];
            [datas addObject:orderForm];
            [orderDic release];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(datas);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAllScoChargeOrderListRequest) {
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        
        NSArray *orders = [packData objectForKey:@"trans"];
        for (NSDictionary *orderDic in orders) {
            TAllscoOrderForm *orderForm = [[TAllscoOrderForm alloc]initWithJsonDictionary:orderDic];
            [datas addObject:orderForm];
            [orderDic release];
        }
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(datas);
    }

    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAllScoBuyerOrderDetailRequest) {
        TAllscoOrderForm *orderForm = [[[TAllscoOrderForm alloc]initWithDictionary:packData]autorelease];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TAllscoOrderForm *))callback)(orderForm);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAllScoChargeOrderDetailRequest) {
        TAllscoOrderForm *orderForm = [[TAllscoOrderForm alloc]initChargeWithDictionary:packData];
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TAllscoOrderForm *))callback)(orderForm);
    }
    
    
}


@end
