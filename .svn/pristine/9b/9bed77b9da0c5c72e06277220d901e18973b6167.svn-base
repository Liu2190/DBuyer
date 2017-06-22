//
//  TAllscoGoodsForm.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-30.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoGoodsForm.h"

@implementation TAllscoGoodsForm

- (id)init {
    self = [super init];
    self.sellNumber = 0;
    
    return self;
}

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.serverId = [dic objectForKey:@"ID"];
    self.cardCost = [[dic objectForKey:@"marketPrice"]stringValue];
    self.sellPrice = [[dic objectForKey:@"sellPrice"]stringValue];
    self.allscodesc = [dic objectForKey:@"describeComment"];
    self.allscoTitle = [dic objectForKey:@"commodityName"];
    self.allscoImageUrl = @"http://img0.bdstatic.com/img/image/shouye/mukamu4.jpg";
}

- (NSString*)getTotalMoney {
    float mitotal = [self.sellPrice floatValue] * self.sellNumber;
    NSString *totalstring = [NSString stringWithFormat:@"%.0f元",mitotal];
    
    return totalstring;
}
@end
