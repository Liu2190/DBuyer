//
//  SqliteManager.h
//  DBuyer
//
//  Created by 王帅帅 on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteAreaObject.h"
#import "SqliteMarketObject.h"

@interface SqliteManager : NSObject
+ (SqliteManager *)singleton;
- (int)insertArea:(SqliteAreaObject<SqliteAreaObjectProtocol> *)object;
- (int)insertMarket:(SqliteMarketObject<SqliteMarketObjectProtocol> *)objcet;
- (int)createTable:(NSString *)tableName attribute:(NSDictionary *)attribute;
- (int)dropTable:(NSString *)tableName;
-(int) updateMarketVersionWithNetVersion:(NSString * )netVersion;
- (NSArray *)itemListFromTable:(NSString *)tableName;
- (NSArray *)itemListFromTable:(NSString *)tableName andInAreaName:(NSString *)inareaName;
- (NSArray *)_findAllMarketFromTable:(NSString *)tableName;
- (int)cleanTable:(NSString *)tableName;
- (NSArray *)itemListFromTable:(NSString *)tableName andInAreaName:(NSString *)inareaName andType:(NSInteger)marketType;
-(NSArray *) _findAllMarketFromTable:(NSString *)tableName WithMarketType:(NSInteger) marketType;
- (NSArray *)itemListFromTable:(NSString *)tableName withMarketType:(NSInteger) marketType;

@end
