//
//  SettlementTakeCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqliteMarketObject.h"
@interface SettlementTakeCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *address;
@property (retain, nonatomic) IBOutlet UIButton *nameButton;
@property (retain, nonatomic) IBOutlet UIButton *timeButton;
- (void)setSettlementExtractCellWithMarket:(SqliteMarketObject *)market;
@end
