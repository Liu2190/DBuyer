//
//  JiesuanViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
// 结算类型
#import "SettlementViewController.h"
@interface JiesuanViewController : UIViewController
/**
 *  添加到结算中心
 *
 *  @param productArr 商品数组
 *  @param SettType   结算类型
 */
- (void)setSettlementWithProducts:(NSMutableArray *)productArr SeettType:(SettlementType)SettType;

/**
 *  用于礼包详情添加结算时使用
 *
 *  @param productArr 礼包中的商品
 *  @param SettType   结算类型
 *  @param giftId     礼包ID
 */
- (void)setSettlementWithProducts:(NSMutableArray *)productArr SeettType:(SettlementType)SettType GiftID:(NSString *)giftId WithPrice:(float)price;

@end
