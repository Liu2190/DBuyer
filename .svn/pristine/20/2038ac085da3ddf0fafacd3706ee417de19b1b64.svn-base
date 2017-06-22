//
//  SettlementLogisticsCell.m
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementLogisticsCell.h"

@interface SettlementLogisticsCell() {
    id _target;         // 控制器
    SEL _action;        // 方法
}

@end

@implementation SettlementLogisticsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setCellWithAddressItem:(AddressItem *)addressitem
{
    self.consigneeLable.text = addressitem.name;
    self.consigneeTelLable.text = addressitem.phoneNumber;
    self.consigneeAddressLable.text = addressitem.address;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)addTarget:(id)target Action:(SEL)action
{
    _target = target;
    _action = action;
}
- (IBAction)consigneeEdit:(id)sender {
    [_target performSelector:_action withObject:self];
}
@end
