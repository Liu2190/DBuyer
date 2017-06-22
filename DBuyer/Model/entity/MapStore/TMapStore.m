//
//  TMapStore.m
//  DBuyer
//
//  Created by dilei liu on 14-4-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TMapStore.h"

@implementation TMapStore

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.serverId = [dic objectForKey:@"ID"];
    self.name = [dic objectForKey:@"NAME"];
    self.xaxis = [[dic objectForKey:@"XAxis"]floatValue];
    self.yaxis = [[dic objectForKey:@"YAxis"]floatValue];
    self.address = [dic objectForKey:@"address"];
    self.areaId = [[dic objectForKey:@"areaId"]intValue];
    self.axis = [dic objectForKey:@"axis"];
    self.cityName = [dic objectForKey:@"cityName"];
    self.storeSort = [[dic objectForKey:@"storeSort"]intValue];
    self.telephone = [dic objectForKey:@"telephone"];
    
}

- (void)dealloc {
    [super dealloc];
    
    [self.name release];
    _name = nil;
    
    [self.address release];
    _address = nil;
    
    [self.axis release];
    _axis = nil;
    
    [self.cityName release];
    _cityName = nil;
    
    [self.telephone release];
    _telephone = nil;
}

@end
