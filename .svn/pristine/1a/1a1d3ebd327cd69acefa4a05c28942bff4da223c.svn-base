//
//  TOrdersNum.m
//  DBuyer
//
//  Created by dilei liu on 14-3-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrdersNum.h"

@implementation TOrdersNum

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.alreadyGoods = [[dic objectForKey:@"alreadyGoods"]intValue];
    self.collectCount = [[dic objectForKey:@"collectCount"]intValue];
    self.integralInfo = [[dic objectForKey:@"integralInfo"]intValue];
    self.noGetGoods = [[dic objectForKey:@"noGetGoods"]intValue];
    self.noPayOrderInfo = [[dic objectForKey:@"noPayOrderInfo"]intValue];
    self.voucheCountInfo = [[dic objectForKey:@"voucheCountInfo"]intValue];
    self.refundCount = [[dic objectForKey:@"refundCount"]intValue];
    
    self.helpPhone = [dic objectForKey:@"helpPhone"];
}


@end
