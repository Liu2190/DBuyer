//
//  DBManager.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#define dataBasePath  [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"dbuyer.db"
@interface DBManager : NSObject{
    FMDatabase *mDB;
}
+ (DBManager *)sharedDatabase;
+(NSString*)filePath:(NSString*)fileName;

/**
 *  从搜索历史中读取数据
 *
 */
-(NSMutableArray *)readThingFromSearchHistory;

/**
 *  将搜索记录添加到搜索历史中
 *
 */
-(void)insertIntoSearchHistory:(NSString *)history;

/**
 *  在本地删除所有的搜索记录
 *
 */
-(void)deleteAllThingFromSearchHistory;

@property(nonatomic,retain)NSString * rememberplanid;

/**
 *  读取用户的收藏记录
 *
 */
-(NSMutableArray *)readThingFromCollectlist;
/**
 *  登录的情况下将购物车中的商品提交到服务器
 *
 */
-(NSMutableDictionary *)dictInsertToGoods;
/**
 *  批量加入购物车
 *
 */
-(NSString *)batchInsertToNet;
/**
 *  未登录的情况下修改购物车中的商品数量
 *
 */
-(void)changeCarlistWith:(NSString *)count AndID:(NSString *)ID;

/**
 *  未登录的情况下删除购物车中的某一条数据
 *
 */
-(void)deleteDataFromCarlistWithID:(NSString *)ID;

/**
 *  未登录的情况下将商品添加到购物车中
 *
 */
-(void)insertIntoCarlist:(NSMutableDictionary *)dict;
/**
 *  未登录的情况下删除购物车中的所有数据
 *
 */
-(void)deleteAllthingInShoppinglist;

/**
 *  未登录的情况下获取购物车中所有数量
 *
 */
-(int)getAllcountfromShoppinglist;
/**
 *  未登录的情况下读取购物车中的所有数据
 *
 */
-(NSMutableArray *)readThingFromCarlist;

/**
 *  登录的情况下将用户的购物计划添加到数据库中
 *
 *  @param dict 计划列表数据
 *  @param userName 用户名称
 */
-(void)getListFromNetWithDict:(NSDictionary *)dict WithUsername:(NSString *)userName;

/**
 *  从数据库中读取计划
 *
 */
-(NSMutableArray *)readThingFromShoppingplan;

/**
 *  修改计划的值
 *
 */
-(void)changeShopinglist:(NSDictionary *)dict;

/**
 *  获取提醒时间
 *
 */
-(NSMutableArray *)getClockArrayFromShoppinglist;

/**
 *  删除计划
 *
 */
-(void)deleteItemFromShoppingplanWith:(NSString *)planid;
-(void)thingDeletedFromshoppingplanWith:(NSString *)planid;

/**
 *  计划数据写入数据库中
 *
 */
-(void)insertintoShoppinglist:(NSMutableDictionary *)dict;

/**
 *  判断计划是否已经存在
 *
 */
-(BOOL)isExistInShoppinglist:(NSString *)string;

/**
 *  获取未完成计划的数量
 *
 */
-(int)getNumofnotfinished;
-(void)updateShoppinglistToNet;
-(void)deleteItemToNet;
-(void)saveimageWith:(NSString *)planid AndWithpath:(NSString *)path;//数据库保存图片
-(void)saveimageWith:(NSString *)planid AndWithimgid:(NSString *)imgid;
-(void)insertintoAreaIDlist:(NSMutableDictionary *)dict;
-(NSString *)selectAreaIdWihtAreaname:(NSString *) name;
-(NSMutableArray  *)selectAreaListFromAreaId;
-(NSInteger) updateMarketListVersion:(NSInteger) netVersion;
-(void)deleteItemFromAreaIDList;
@end
