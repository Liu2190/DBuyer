//
//  ProRecView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProRecView.h"

@implementation ProRecView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)showWithProduct:(Product *)product
{
    self.productName.text = product.commodityName;
    // 商品图片
    [self.productImage setImageWithURL:[NSURL URLWithString:product.attrValue]placeholderImage:[UIImage imageNamed:@"placeHolerImage80" ]];
    self.productPrice.text = [NSString stringWithFormat:@"￥%.2f", product.sellPrice];
}
- (void)dealloc {
    [_productImage release];
    [_productPrice release];
    [_productName release];
    [super dealloc];
}
@end
