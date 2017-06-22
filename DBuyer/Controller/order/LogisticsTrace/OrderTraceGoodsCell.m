//
//  OrderTraceGoodsCell.m
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderTraceGoodsCell.h"
#import "Product.h"

@implementation OrderTraceGoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderTraceGoodsCellWithProduct:(Product *)product
{
    [self.goodsImage setImageWithURL:[NSURL URLWithString:product.attrValue]];
    self.goodsTitle.text = product.commodityName;
    self.unitPrice.text = [NSString stringWithFormat:@"%0.2f", product.sellPrice];
    self.goodsNum.text = [NSString stringWithFormat:@"%d", product.count];
    self.totalPrice.text = [NSString stringWithFormat:@"%0.2f", product.sellPrice * product.count];
}


- (void)dealloc {
    [_goodsImage release];
    [_goodsTitle release];
    [_unitPrice release];
    [_goodsNum release];
    [_totalPrice release];
    [super dealloc];
}
@end
