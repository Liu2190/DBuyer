//
//  SettlementExtractCell.h
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SqliteMarketObject.h"

/**
 *  结算中心自提Cell
 */
@interface SettlementExtractCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *SuperMaketNameLable;    // 超市名称
@property (retain, nonatomic) IBOutlet UILabel *SuperMaketAddressLable; // 超市地址
@property (retain, nonatomic) IBOutlet UIButton *ExtractDateButton;     // 显示自提时间


- (void)setSettlementExtractCellWithMarket:(SqliteMarketObject *)market;    // 设置cell
- (IBAction)SuperMaketAction:(id)sender;                                // 选择超市事件
- (IBAction)ExtractDateAction:(id)sender;                               // 自提时间事件

/**
 *  添加按钮回掉事件
 *
 *  @param target  控制器
 *  @param saction 物流事件
 *  @param eaction 自提事件
 */
- (void)addTarget:(id)target
    SuperMaketAction:(SEL)saction
    ExtractDateAction:(SEL)eaction;


@end
