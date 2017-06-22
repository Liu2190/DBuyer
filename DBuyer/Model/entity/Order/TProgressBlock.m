//
//  TProgressBlock.m
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProgressBlock.h"

@implementation TProgressBlock

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.createDate = [dic objectForKey:@"createDate"];
    self.execute = [[dic objectForKey:@"execute"]intValue];
    self.orderId = [dic objectForKey:@"orderId"];
    self.status = [[dic objectForKey:@"status"]intValue];
}

@end
