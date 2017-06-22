//
//  SettlementSectionHeader.h
//  DBuyer
//
//  Created by simman on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettlementModel.h"
/**
 *  结算中心Section物流、自提选择
 */
@interface SettlementSectionHeader : UIView

@property (retain, nonatomic) IBOutlet UIImageView *backGroundView;     // 背景
@property (retain, nonatomic) IBOutlet UIButton *logisticsCheckBox;     // 物流复选框
@property (retain, nonatomic) IBOutlet UIButton *extractCheckBox;       // 自提复选框
@property (retain, nonatomic) IBOutlet UILabel *logisticsPrice;         // 物流费用

- (IBAction)logisticsCheckBoxAction:(id)sender;             // 物流复选框事件
- (IBAction)extractCheckBoxAction:(id)sender;               // 自提复选框事件
- (void)setSectionLogisticsPrice:(NSInteger)price;          // 设置物流价钱
@property (retain, nonatomic) IBOutlet UILabel *wuliuLabel;
@property (retain, nonatomic) IBOutlet UILabel *zitiLabel;

/**
 *  添加物流、自提按钮回掉事件
 *
 *  @param target  控制器
 *  @param laction 物流
 *  @param eaction 自提
 */
- (void)addTarget:(id)target
  logisticsAction:(SEL)laction
    extractAction:(SEL)eaction;
- (void)setButtonCanClickWith:(BOOL)logistics AndZitiHidden:(BOOL)isVIP AndlogisticsPrice:(float)price;
- (void)setDeliveryMethod:(SettlementModel *)thisModel;
@end
