//
//  SqliteMarketObject.m
//  DBuyer
//
//  Created by 王帅帅 on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SqliteMarketObject.h"

@implementation SqliteMarketObject

- (id)init
{
    self = [super init];
    if (self) {
        _inAreaName = [[NSString alloc]init];//所在地球的Name
        //@property (nonatomic,retain)NSString *inAreaName;//所在地区的id
        _marketName = [[NSString alloc]init];//超市名称
        _marketId = [[NSString alloc]init];//超市id
        _marketAddress = [[NSString alloc]init];//超市地址
    }
    return self;
}
- (NSString *)insertSQL
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendString:@"insert into SqliteMarketObject(inAreaName,inAreaId,marketName,marketAddress,marketId,latitude,longtitude,storeSort) values("];
    [sql appendFormat:@"'%@','%@','%@','%@','%@',%f,%f,%d ",self.inAreaName,self.marketName,self.inAreaId,self.marketAddress,self.marketId,self.latitude,self.longtitude,self.storeSort];
    [sql appendString:@")"];
    return sql;
    
}

@end
