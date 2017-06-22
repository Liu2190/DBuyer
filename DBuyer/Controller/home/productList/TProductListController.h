//
//  TProductListController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPullUPRefreshController.h"
#import "TProductSortBar.h"
#import "SearchBarView.h"
#import "ProductListTopView.h"
/**
 * 数据排序规则
 */
typedef enum {
    newType,            // 新品排序
    SaleType,           // 销量排序
    PriceType,      // 价格排序
} Product_SortType;

/**
 * 商品数据类型：分类商品和促销商品
 */
typedef enum {
    cateGoods,     // 分类商品
    SaleGoods,     // 促销商品
} Product_DataType;

@interface TProductListController : TPullUPRefreshController<SearchBarViewDelegate,productListTopViewDelegate> {
    /**
     * 排序枚举值声明(默认为新品排序)
     */
    Product_SortType _sortType;
    
    /**
     * 数据对应的页号
     */
    int _pageNum;
    
    /**
     * 价格排序时升降变量声明
     */
    BOOL isAscending;
    
    TProductSortBar *toolbarView;
    ProductListTopView *topView;
}

/**
 * 基于某一父类节点主键获取表数据源的变量
 */
@property(nonatomic,retain)NSString *parentId;
@property (nonatomic,assign)BOOL isSale;

@end
