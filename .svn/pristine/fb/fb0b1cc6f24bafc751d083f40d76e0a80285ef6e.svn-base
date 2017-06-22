//
//  TAllscoOrderForm.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderForm.h"
#import "TAllscoGoodsForm.h"
#import "TAllScoCharge.h"

@implementation TAllscoOrderForm

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.orderNum = [dic objectForKey:@"orderNo"];
    self.orderAmount = [dic objectForKey:@"tranAmt"];
    self.orderDate = [dic objectForKey:@"tranTime"];
    self.phoneNum = [dic objectForKey:@"account"];
    
    int tranStatus = [[dic objectForKey:@"tranStatus"]intValue];
    if (tranStatus == 0) {
        self.orderStatus = @"已接收";
    } else if (tranStatus == 1) {
        self.orderStatus = @"已提交";
    } else if (tranStatus == 2) {
        self.orderStatus = @"已处理";
    } else if (tranStatus == 3) {
        self.orderStatus = @"已下发";
    } else if (tranStatus == 4) {
        self.orderStatus = @"购卡失败";
    }
    
    self.allscoUrl = @"http://img0.bdstatic.com/img/image/shouye/mukamu4.jpg";
}

- (id)initWithDictionary:(NSDictionary*)dict {
    self = [super init];
    self.details = [[NSMutableArray alloc]init];
    
    self.phoneNum = [dict objectForKey:@"account"];
    self.orderNum = [dict objectForKey:@"orderNo"];
    self.orderAmount = [dict objectForKey:@"tranAmt"];
    self.orderDate = [dict objectForKey:@"tranTime"];
    
    int tranStatus = [[dict objectForKey:@"tranStatus"]intValue];
    if (tranStatus == 0) {
        self.orderStatus = @"已接收";
    } else if (tranStatus == 1) {
        self.orderStatus = @"已提交";
    } else if (tranStatus == 2) {
        self.orderStatus = @"已处理";
    } else if (tranStatus == 3) {
        self.orderStatus = @"已下发";
    } else if (tranStatus == 4) {
        self.orderStatus = @"购卡失败";
    }
    
    NSArray *detais = [dict objectForKey:@"details"];
    for (NSDictionary *orderFormdicts in detais) {
        TAllscoGoodsForm *goodsForm = [[TAllscoGoodsForm alloc]init];
        goodsForm.sellPrice = [orderFormdicts objectForKey:@"faceAmt"];
        goodsForm.sellNumber = [[orderFormdicts objectForKey:@"count"]intValue];
        goodsForm.allscoImageUrl = @"http://img0.bdstatic.com/img/image/shouye/mukamu4.jpg";
        [self.details addObject:goodsForm];
        [goodsForm release];
    }
    
    self.payWay = [dict objectForKey:@"payPattern"];
    
    return self;
}

- (id)initChargeWithDictionary:(NSDictionary*)dict {
    self = [super init];
    self.charges = [[NSMutableArray alloc]init];
    
    self.phoneNum = [dict objectForKey:@"account"];
    self.orderNum = [dict objectForKey:@"orderNo"];
    self.orderAmount = [dict objectForKey:@"tranAmt"];
    self.orderDate = [dict objectForKey:@"tranTime"];
    
    int tranStatus = [[dict objectForKey:@"tranStatus"]intValue];
    if (tranStatus == 0) {
        self.orderStatus = @"已接收";
    } else if (tranStatus == 1) {
        self.orderStatus = @"已提交";
    } else if (tranStatus == 2) {
        self.orderStatus = @"已处理";
    } else if (tranStatus == 3) {
        self.orderStatus = @"已下发";
    } else if (tranStatus == 4) {
        self.orderStatus = @"购卡失败";
    }
    
    NSArray *detais = [dict objectForKey:@"details"];
    for (NSDictionary *orderFormdicts in detais) {
        TAllScoCharge *chareForm = [[[TAllScoCharge alloc]init]autorelease];
        chareForm.cardNumber = [orderFormdicts objectForKey:@"cardNo"];
        chareForm.chargeAmount = [orderFormdicts objectForKey:@"chrgAmt"];
        [self.charges addObject:chareForm];
    }
    
    self.payWay = [dict objectForKey:@"payPattern"];
    
    return self;
}

@end
