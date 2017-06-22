//
//  SettlementTitleCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementTitleCell.h"

@implementation SettlementTitleCell

- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)heightOfSettlementTitleCell
{
    return 30;
}
- (void)dealloc {
    [_titleLabel release];
    [_sepLine release];
    [_bottomLine release];
    [super dealloc];
}
@end
