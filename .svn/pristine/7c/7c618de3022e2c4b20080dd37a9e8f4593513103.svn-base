//
//  TProductServer.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProductLocalServer.h"
#import "TProductListController.h"

@interface TProductServer : TProductLocalServer
/**
 *一级分类接口
 */
- (void)doGetAClassGoodsCallback:(void(^)(NSArray *datas))callback
               failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *二级分类接口
 */
-(void)doGetSecondClassGoodsBy:(NSString *)cid andCallback:(void(^)(NSArray *datas))callback
               failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 * 通过sortType获取不同的商品列表
 */
- (void)doGetProductList:(NSString*)classId andPageNum:(int)pageNum andSortType:(Product_SortType)sortType
               andIsSale:(BOOL)isSale andPriceAsc:(BOOL)isAsc andCallback:(void(^)(NSArray *datas,int pageTotal))callback
         failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 普通商品详情接口
 */
- (void)doGetProductDetailById:(NSString*)commitId andCallback:(void(^)(NSDictionary *datas))callback
               failureCallback:(void(^)(NSString *resp))failureCallback;
/**
 *促销商品详情接口
 */
-(void)doGetPromotionalProductByID:(NSString*)commitId AndCategoryID:(NSString *)categoryID andCallback:(void(^)(NSDictionary *datas))callback
                   failureCallback:(void(^)(NSString *resp))failureCallback;
@end
