//
//  SettlementDeliverTypeCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementDeliverTypeCell.h"

@implementation SettlementDeliverTypeCell

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
-(void)setButtonValueWith:(BOOL)status
{
    self.button.userInteractionEnabled = !status;
    NSString *name = status == YES?@"settlementhighlighted":@"settlementnormal";
    [self.button setImage:[UIImage imageNamed:name]forState:UIControlStateNormal];
}

- (void)dealloc {
    [_name release];
    [_button release];
    [super dealloc];
}
@end
