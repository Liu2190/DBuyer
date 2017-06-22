//
//  HomeSever.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
/**
 *首页相关的网络请求
 */
@interface HomeSever : TBaseServer
/**
 *获取首页所有数据接口
 */
-(void)doGetHomeAllThingsBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取特色商品分类数据接口
 */
-(void)doGetCharacteristicCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取特色商品列表数据接口
 */
-(void)doGetCharacteristicListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取每月新品分类数据接口
 */
-(void)doGetMonthlyCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取每月新品列表数据接口
 */
-(void)doGetMonthlyListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取特价商品列表数据
 */
-(void)doGetBargainGoodsByAndPageNum:(int)currentPage andCallback:(void (^)(NSMutableArray *datas,int pageTotal))callback  failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取销售排行分类数据
 */
-(void)doGetSalesRankingCategoryBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取销售排行列表数据
 */
-(void)doGetSalesRankingListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取应季商品列表数据
 */
-(void)doGetSeasonalGoodsListByID:(NSString *)Id AndPageNum:(int)currentPage callback:(void (^)(NSMutableArray *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *获取活动列表数据接口
 */
-(void)doGetActivityListByID:(NSString *)urlString AndPageNum:(int)currentPage callback:(void (^)(NSDictionary *datas,int pageTotal))callback failureCallback:(void (^)(NSString *))failureCallback;
@end