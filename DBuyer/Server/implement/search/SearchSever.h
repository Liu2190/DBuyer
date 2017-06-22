//
//  SearchSever.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
/**
 *搜索页面相关接口
 */
@interface SearchSever : TBaseServer
/**
 *搜索商品接口
 */
-(void)doSearchGoodsByName:(NSString *)productName andCallback:(void(^)(NSArray *productArray)) callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *搜索联想接口
 */
-(void)doSearchEnterWordsByWords:(NSString *)productName andCallback:(void(^)(NSArray *productArray)) callback failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *获取更多推荐接口
 */
-(void)doGetRecommendedGoodsBycallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback;
@end
