//
//  Store.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "Store.h"

@implementation Store

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.name = [dic valueForKey:@"NAME"];
        self.address = [dic valueForKey:@"address"];
        self.telephone = [dic valueForKey:@"telephone"];
        self.areaName = [dic valueForKey:@"cityName"];
        self.YAxis = [[dic valueForKey:@"YAxis"] floatValue];
        self.XAxis = [[dic valueForKey:@"XAxis"] floatValue];
        self.storeId = [[dic valueForKey:@"ID"] intValue];
        self.areaId = [[dic valueForKey:@"areaId"] intValue];
        self.storeSort = [[dic valueForKey:@"storeSort"] intValue];
        self.axis=[dic objectForKey:@"axis"];
    }
    return self;
}

+ (id)storeWithDictionary:(NSDictionary *)dic
{
    return [[[self alloc] initWithDictionary:dic] autorelease];
}

@end
