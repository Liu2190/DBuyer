//
//  SqliteManager.m
//  DBuyer
//
//  Created by 王帅帅 on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SqliteManager.h"
#import "SqliteMarketListVersionObject.h"
#import <sqlite3.h>

static inline NSString *toto(const char * pStr)
{
    return [NSString stringWithUTF8String:pStr];
}

@interface SqliteManager()
//打开数据库
- (void)_open;
//关闭数据库
- (void)_close;


@end

@implementation SqliteManager
{
    sqlite3 *database;
}

- (NSArray *)itemListFromTable:(NSString *)tableName withMarketType:(NSInteger)marketType {return nil;}

#pragma mark - private methods
//打开数据库
- (void)_open {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    #define kSqliteName @"dbuyer.sqlite"
    //获取数据库文件的路径
    NSString *sqlitePath = [documentPath stringByAppendingFormat:@"/%@",kSqliteName];
    
    //使用函数打开数据库，并且将数据库对象赋值给database
    sqlite3_open([sqlitePath UTF8String], &database);//如果没有这个文件，会自动创建这个文件
}
//关闭数据库
- (void)_close {
    //关闭数据库
    sqlite3_close(database);
}

#pragma mark - singleton
static SqliteManager *s_SqliteManager = nil;
+ (SqliteManager *)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_SqliteManager == nil) {
            s_SqliteManager = [[SqliteManager alloc] init];
        }
    });
    
    return s_SqliteManager;
    
}

//创建数据表格
- (int)createTable:(NSString *)tableName attribute:(NSDictionary *)attribute
{
    [self _open];
    //实例化sql语句
    NSMutableString *sql = [[NSMutableString alloc] init];
    //构造sql语句
    [sql appendString:@"create table "];
    [sql appendString:tableName];
    [sql appendString:@"("];
    NSArray *allKey = [attribute allKeys];
    for (NSString *key in allKey) {
        NSString *value = [attribute objectForKey:key];
        [sql appendFormat:@"%@ %@,",key,value];
    }
    NSRange range = NSMakeRange([sql length]-1, 1);
    [sql deleteCharactersInRange:range];
    [sql appendString:@")"];
    int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    
    [sql release];
    [self _close];
    return result;
}
//插入地区数据
- (int)insertArea:(SqliteAreaObject<SqliteAreaObjectProtocol> *)object
{
    //获取响应的插入语句
    NSString *sql = [object insertSQL];
    //打开数据库
    [self _open];
    //执行
    int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    //关闭数据库
    [self _close];
    return result;
    
}
//插入超市数据
- (int)insertMarket:(SqliteMarketObject<SqliteMarketObjectProtocol> *)object
{
    //获取响应的插入语句
    NSString *sql = [object insertSQL];
    NSLog(@"%@",sql);
    //打开数据库
    [self _open];
    //执行
    int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    //关闭数据库
    [self _close];
    return result;
}


/**
 删除数据表格
 @return
 */
- (int)dropTable:(NSString *)tableName
{
    //获取响应的插入语句
    NSString *sql =[NSString stringWithFormat:@"drop table %@",tableName];
    //打开数据库
    [self _open];
    //执行
    int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    //关闭数据库
    [self _close];
    return result;
}
/**
 查询地区列表
 @return
 */

- (NSArray *)itemListFromTable:(NSString *)tableName {
    [self _open];
    //设置sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    //声明sql执行状态对象
    sqlite3_stmt *statement = NULL;
    //获取执行状态对象
    sqlite3_prepare(database, [sql UTF8String], [sql length], &statement, NULL);
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    //执行sql语句
    while (sqlite3_step(statement) == SQLITE_ROW) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        
        NSString * areaName = toto((char *)sqlite3_column_text(statement, 0));
        NSString * areaId = toto((char *)sqlite3_column_text(statement, 1));
        [dic setObject:areaName forKey:@"name"];
        [dic setObject:areaId forKey:@"id"];
        [resultList addObject:dic];
    }
    
    //终止执行状态对象
    sqlite3_finalize(statement);
    //关闭数据库
    [self _close];
    return [resultList autorelease];
}

//查询超市列表
- (NSArray *)itemListFromTable:(NSString *)tableName andInAreaName:(NSString *)inareaName {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
   [array addObjectsFromArray:[self _findAllMarketFromTable:tableName]];
    for (SqliteMarketObject *item in array) {
        if ([item.inAreaName isEqualToString:inareaName]) {
            [resultList addObject:item];
        }
    }
    return resultList;
    
}
//查询超市列表
- (NSArray *)itemListFromTable:(NSString *)tableName andInAreaName:(NSString *)inareaName andType:(NSInteger)marketType {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:[self _findAllMarketFromTable:tableName withType:marketType]];
    for (SqliteMarketObject *item in array) {
        if ([item.inAreaName isEqualToString:inareaName]) {
            [resultList addObject:item];
        }
    }
    return resultList;
    
}
-(NSArray *) _findAllMarketFromTable:(NSString *)tableName WithMarketType:(NSInteger) marketType{
    [self _open];
    //设置sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where storeSort =%d",tableName,marketType];
    //声明sql执行状态对象
    sqlite3_stmt *statement = NULL;
    //获取执行状态对象
    sqlite3_prepare(database, [sql UTF8String], [sql length], &statement, NULL);
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    //执行sql语句
    while (sqlite3_step(statement) == SQLITE_ROW) {
        SqliteMarketObject *market = [[SqliteMarketObject alloc] init];
        
        /*
         [sql appendFormat:@"'%@','%@','%@','%@',%f,%f,%d ",self.inAreaName,self.marketName,self.marketAddress,self.marketId,self.latitude,self.longtitude,self.storeSort];
         */
        market.marketId =toto((char *)sqlite3_column_text(statement, 0));
        market.marketName = toto((char *)sqlite3_column_text(statement, 1));
        market.inAreaName = toto((char *)sqlite3_column_text(statement, 2));
        
        market.marketAddress =toto((char *)sqlite3_column_text(statement, 3));
        
        market.latitude =[toto((char *)sqlite3_column_text(statement, 4)) doubleValue];
        market.longtitude = [toto((char *)sqlite3_column_text(statement, 5)) doubleValue];
        market.storeSort =[toto((char *)sqlite3_column_text(statement, 6)) boolValue];
        
        [resultList addObject:market];
    }
    
    //终止执行状态对象
    sqlite3_finalize(statement);
    //关闭数据库
    [self _close];
    return [resultList autorelease];
}
- (NSArray *)_findAllMarketFromTable:(NSString *)tableName
{
    [self _open];
    //设置sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    //声明sql执行状态对象
    sqlite3_stmt *statement = NULL;
    //获取执行状态对象
    sqlite3_prepare(database, [sql UTF8String], [sql length], &statement, NULL);
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    //执行sql语句
    while (sqlite3_step(statement) == SQLITE_ROW) {
        SqliteMarketObject *market = [[SqliteMarketObject alloc] init];
        
        /*
         [sql appendFormat:@"'%@','%@','%@','%@',%f,%f,%d ",self.inAreaName,self.marketName,self.marketAddress,self.marketId,self.latitude,self.longtitude,self.storeSort];
         */
        market.marketId =toto((char *)sqlite3_column_text(statement, 0));
        market.marketName = toto((char *)sqlite3_column_text(statement, 1));
        market.inAreaId = toto((char *)sqlite3_column_text(statement, 2));
        market.inAreaName = toto((char *)sqlite3_column_text(statement, 3));
        
        market.marketAddress =toto((char *)sqlite3_column_text(statement, 4));
        
        market.latitude =[toto((char *)sqlite3_column_text(statement, 5)) doubleValue];
        market.longtitude = [toto((char *)sqlite3_column_text(statement, 6)) doubleValue];
        market.storeSort =[toto((char *)sqlite3_column_text(statement, 7)) boolValue];
        
        [resultList addObject:market];
    }
    
    //终止执行状态对象
    sqlite3_finalize(statement);
    //关闭数据库
    [self _close];
    return [resultList autorelease];
}
- (NSArray *)_findAllMarketFromTable:(NSString *)tableName withType:(NSInteger) marketType
{
    [self _open];
    //设置sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where storeSort = '%d'",tableName,marketType];
    //声明sql执行状态对象
    sqlite3_stmt *statement = NULL;
    //获取执行状态对象
    sqlite3_prepare(database, [sql UTF8String], [sql length], &statement, NULL);
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    //执行sql语句
    while (sqlite3_step(statement) == SQLITE_ROW) {
        SqliteMarketObject *market = [[SqliteMarketObject alloc] init];
        
        /*
         [sql appendFormat:@"'%@','%@','%@','%@',%f,%f,%d ",self.inAreaName,self.marketName,self.marketAddress,self.marketId,self.latitude,self.longtitude,self.storeSort];
         */
        market.marketId =toto((char *)sqlite3_column_text(statement, 0));
        market.marketName = toto((char *)sqlite3_column_text(statement, 1));
        market.inAreaId = toto((char *)sqlite3_column_text(statement, 2));
        market.inAreaName = toto((char *)sqlite3_column_text(statement, 3));
        
        market.marketAddress =toto((char *)sqlite3_column_text(statement, 4));
        
        market.latitude =[toto((char *)sqlite3_column_text(statement, 5)) doubleValue];
        market.longtitude = [toto((char *)sqlite3_column_text(statement, 6)) doubleValue];
        market.storeSort =[toto((char *)sqlite3_column_text(statement, 7)) boolValue];
        
        [resultList addObject:market];
    }
    
    //终止执行状态对象
    sqlite3_finalize(statement);
    //关闭数据库
    [self _close];
    return [resultList autorelease];
}
-(int) updateMarketVersionWithNetVersion:(NSString * )netVersion{
    //取得当前的marketVersion
    NSString * localStr =  [self getMarketVersion];
    if ([localStr isEqualToString:@""]) {
        //将netVersion插入数据库
        
        SqliteMarketListVersionObject * ob = [[SqliteMarketListVersionObject alloc]init];
        ob.version = netVersion;
         [ob insertSQL];
        
    }
    
    return 0;
}
-(NSString *) getMarketVersion{
    [self _open];
    //设置sql语句
    NSString *sql = @"select version from marketlistVersion";
    //声明sql执行状态对象
    sqlite3_stmt *statement = NULL;
    //获取执行状态对象
    sqlite3_prepare(database, [sql UTF8String], [sql length], &statement, NULL);
    NSString * result = [[NSString alloc]init];
    //执行sql语句
    while (sqlite3_step(statement) == SQLITE_ROW) {
        result =toto((char *)sqlite3_column_text(statement, 0));
    }
    
    //终止执行状态对象
    sqlite3_finalize(statement);
    //关闭数据库
    [self _close];
    return result;
}
//创建数据表格
- (int)cleanTable:(NSString *)tableName
{
    [self _open];
    
    NSString * cleanSQL = [NSString stringWithFormat:@"delete from %@ ",tableName];
//    //实例化sql语句
//    NSMutableString *sql = [[NSMutableString alloc] init];
//    //构造sql语句
//    [sql appendString:@"create table "];
//    [sql appendString:tableName];
//    [sql appendString:@"("];
//    NSArray *allKey = [attribute allKeys];
//    for (NSString *key in allKey) {
//        NSString *value = [attribute objectForKey:key];
//        [sql appendFormat:@"%@ %@,",key,value];
//    }
//    NSRange range = NSMakeRange([sql length]-1, 1);
//    [sql deleteCharactersInRange:range];
//    [sql appendString:@")"];
    int result = sqlite3_exec(database, [cleanSQL UTF8String], NULL, NULL, NULL);
    
    [cleanSQL release];
    [self _close];
    return result;
}

@end
