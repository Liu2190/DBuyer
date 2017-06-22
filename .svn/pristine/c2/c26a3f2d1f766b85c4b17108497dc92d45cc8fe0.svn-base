//
//  TKQPayInfo.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-17.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TKQPayInfo.h"

@implementation TKQPayInfo

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.bankId = [dic objectForKey:@"bankId"];
    self.bgUrl = [dic objectForKey:@"bgUrl"];
    self.cardNum = [dic objectForKey:@"cardNum"];
    self.ext1 = [dic objectForKey:@"ext1"];
    self.ext2 = [dic objectForKey:@"ext2"];
    self.inputCharset = [[dic objectForKey:@"inputCharset"]intValue];
    self.language = [[dic objectForKey:@"language"]intValue];
    self.merchantAcctId = [dic objectForKey:@"merchantAcctId"];
    self.orderAmount = [dic objectForKey:@"orderAmount"];
    self.orderId = [dic objectForKey:@"orderId"];
    self.orderTime = [dic objectForKey:@"orderTime"];
    self.pageUrl = [dic objectForKey:@"pageUrl"];
    self.payType = [dic objectForKey:@"payType"];
    self.payerContact = [dic objectForKey:@"payerContact"];
    self.payerContactType = [[dic objectForKey:@"payerContactType"]intValue];
    
    self.payerId = [dic objectForKey:@"payerId"];
    self.payerIdType = [[dic objectForKey:@"payerIdType"]intValue];
    self.payerName = [dic objectForKey:@"payerName"];
    self.pid = [[dic objectForKey:@"pid"]intValue];
    self.productDesc = [dic objectForKey:@"productDesc"];
    self.productId = [dic objectForKey:@"productId"];
    self.productName = [dic objectForKey:@"productName"];
    self.productNum = [dic objectForKey:@"productNum"];
    self.redoFlag = [[dic objectForKey:@"redoFlag"]intValue];
    self.remitCode = [dic objectForKey:@"remitCode"];
    self.remitType = [dic objectForKey:@"remitType"];
    self.signMsg = [dic objectForKey:@"signMsg"];
    self.signMsgVal = [dic objectForKey:@"signMsgVal"];
    self.signType = [[dic objectForKey:@"signType"]intValue];
    self.submitType = [dic objectForKey:@"submitType"];
    self.version = [dic objectForKey:@"version"];
    
    NSArray *goodNameList = [dic objectForKey:@"NameList"];
    NSDictionary *goodDict = [goodNameList objectAtIndex:0];
    NSString *goodName = [goodDict objectForKey:@"goodsName"];
    self.goodName = goodName;
    
}
@end
