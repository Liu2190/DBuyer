//
//  SqliteAreaObject.m
//  DBuyer
//
//  Created by 王帅帅 on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SqliteAreaObject.h"

@implementation SqliteAreaObject
- (NSString *)insertSQL
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"insert into SqliteAreaObject(areaName,areaId) values("];
    [sql appendFormat:@"'%@','%@' ",self.areaName,self.areaId];
    [sql appendString:@")"];
    return sql;
    
}

@end
