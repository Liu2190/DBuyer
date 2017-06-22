//
//  SettlementViewController.h
//  DBuyer
//
//  Created by simman on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettlementSectionHeader.h"

// 结算类型
typedef enum __SettlementType{
    ISGift = 0,     // 礼包
    GoodsDetail,    // 商品详情
    ShoopingCar     // 购物车
}SettlementType;

/**
 *  结算中心视图控制器
 */
@interface SettlementViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,retain)NSString *gid;
@property (nonatomic,assign)float giftPrice;
@property (nonatomic,assign)BOOL isVIP;
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
- (void)setSettlementWithProducts:(NSMutableArray *)productArr SeettType:(SettlementType)SettType GiftID:(NSInteger)giftId;

@end
