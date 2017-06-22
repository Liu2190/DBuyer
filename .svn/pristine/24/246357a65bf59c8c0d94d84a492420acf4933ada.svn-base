//
//  TOrderListController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TAllscoOrderDelegate.h"
#import "TPullUPRefreshController.h"

@interface TOrderListController : TPullUPRefreshController

@property (nonatomic,assign) id<TAllscoOrderDelegate> allscoOrderDelegate;

/**
 * 列表显示区域
 */
@property (nonatomic,assign)CGRect frame;

/**
 * 上拉翻页对应的页号
 */
@property (nonatomic,assign)int pageNum;

/**
 * 上拉刷新控制
 */
@property (nonatomic,assign)BOOL canLoad;

/**
 * 列表上下滑动的时候，开始位置
 */
@property (nonatomic,assign)float startY;

/**
 * 列表上下滑动的距离
 */
@property (nonatomic,assign)float distance;


@end
