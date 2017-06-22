//
//  SettlementProductCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementProductCell.h"

@implementation SettlementProductCell

- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setCellValueWith:(Product *)product
{
    [self.productImage setImageWithURL:[NSURL URLWithString:product.attrValue] placeholderImage:[UIImage imageNamed:@"placeHolerImage44"]];
    self.proName.text = product.commodityName;
    self.price.text = [NSString stringWithFormat:@"￥%.2f",product.sellPrice];
    self.count.text = [NSString stringWithFormat:@"x %d",product.count];
    self.totalPrice.text = [NSString stringWithFormat:@"￥%.2f",product.sellPrice*product.count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [_productImage release];
    [_proName release];
    [_price release];
    [_count release];
    [_totalPrice release];
    [super dealloc];
}
@end
