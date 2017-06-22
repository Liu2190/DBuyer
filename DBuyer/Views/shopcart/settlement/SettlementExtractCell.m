//
//  SettlementExtractCell.m
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementExtractCell.h"

@interface SettlementExtractCell() {
    id _target;
    SEL _saction;   // 选择超市事件
    SEL _eaction;   // 选择时间事件
}

@end

@implementation SettlementExtractCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSettlementExtractCellWithMarket:(SqliteMarketObject *)market
{
    self.SuperMaketNameLable.text = market.marketName;
    self.SuperMaketAddressLable.text = market.marketAddress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)addTarget:(id)target SuperMaketAction:(SEL)saction ExtractDateAction:(SEL)eaction
{
    _target = target;
    _saction = saction;
    _eaction = eaction;
}
- (IBAction)ExtractDateAction:(id)sender {
    [_target performSelector:_eaction withObject:self];
}
- (IBAction)SuperMaketAction:(id)sender {
    [_target performSelector:_saction withObject:self];
}
- (void)dealloc {
    [_SuperMaketNameLable release];
    [_SuperMaketAddressLable release];
    [_ExtractDateButton release];
    [super dealloc];
}

@end
