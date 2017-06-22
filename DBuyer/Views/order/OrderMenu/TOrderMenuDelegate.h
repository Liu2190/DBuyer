//
//  TOrderMenuDelegate.h
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TOrderMenuDelegate <NSObject>

/**
 个人中心待付款列表查看
 */
- (void)toParyOrderList;

/**
 * 个人中心待收货列表查看
 */
- (void)toReceiveOrderList;

/**
 @param canPromptForRating 个人中心完成订单列表查看
 @return
 */
- (void)finishedOrderList;

/**
 @param canPromptForRating 个人中心退货订单列表查看
 @return
 */
- (void)exitOrderList;

@end
