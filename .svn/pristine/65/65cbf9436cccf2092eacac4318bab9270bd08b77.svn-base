//
//  SettlementLogisticsCell.h
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddressItem.h"
/**
 *  结算中心物流Cell
 */
@interface SettlementLogisticsCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *consigneeLable;         // 收货人
@property (retain, nonatomic) IBOutlet UILabel *consigneeTelLable;      //收货人手机号
@property (retain, nonatomic) IBOutlet UILabel *consigneeAddressLable;  //收货人地址

- (IBAction)consigneeEdit:(id)sender;                               // 编辑地址事件
- (void)setCellWithAddressItem:(AddressItem *)addressitem;          // 设置Cell

/**
 *  按钮回调事件
 *
 *  @param target 控制钱
 *  @param action 方法
 */
- (void)addTarget:(id)target
           Action:(SEL)action;
@end

