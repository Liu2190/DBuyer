//
//  SqliteMarketListVersionObject.m
//  DBuyer
//
//  Created by lixinda on 13-11-24.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SqliteMarketListVersionObject.h"

@implementation SqliteMarketListVersionObject

- (NSString *)insertSQL {
    NSDate * date = [NSDate date];
    NSString * dateStr = [date description];
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"insert into marketListVersion(updateDate,version) values("];
    [sql appendFormat:@"'%@','%@'",dateStr,self.version];
    [sql appendString:@")"];
    return sql;
    
}
@end
