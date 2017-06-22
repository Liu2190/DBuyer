
//
//  OrderDetailCellViewCell.m
//  DBuyer
//
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderDetailCellViewCell.h"

@implementation OrderDetailCellViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellWithProduct:(Product *)product
{
    [self.goodsImage setImageWithURL:[NSURL URLWithString:product.attrValue]];
    self.goodsName.text = product.commodityName;
    self.singelPrice.text = [NSString stringWithFormat:@"%0.2f", product.sellPrice];
    self.totalPrice.text = [NSString stringWithFormat:@"%0.2f", product.count * product.sellPrice];
    self.goodsCount.text = [NSString stringWithFormat:@"x %d", product.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc {
    [_goodsImage release];
    [_goodsName release];
    [_singelPrice release];
    [_totalPrice release];
    [_goodsCount release];
    [_backGroundView release];
    [_buttomBackGroundView release];
    [_line release];
    [super dealloc];
}
@end
