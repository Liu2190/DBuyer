//
//  SettlementTakeCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementTakeCell.h"

@implementation SettlementTakeCell

- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setSettlementExtractCellWithMarket:(SqliteMarketObject *)market
{
    self.name.text = market.marketName;
    self.address.text = market.marketAddress;
}

- (void)dealloc {
    [_name release];
    [_address release];
    [_timeLabel release];
    [_nameButton release];
    [_timeButton release];
    [super dealloc];
}
@end
