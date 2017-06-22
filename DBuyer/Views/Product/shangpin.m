//
//  shangpin.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-31.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "shangpin.h"
#import "Product.h"

@implementation shangpin

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)shangPin
{
    return [[[NSBundle mainBundle] loadNibNamed:@"shangpin" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor=[UIColor clearColor];
    self.userInteractionEnabled=YES;
}

- (void)showWithProduct:(Product *)product
{
    self.productNameLabel.text = product.commodityName;
    // 商品图片
    [self.productImageView setImageWithURL:[NSURL URLWithString:product.attrValue]placeholderImage:[UIImage imageNamed:@"placeHolerImage80" ]];
    self.productPriceLabel.text = [NSString stringWithFormat:@"%.2f", product.sellPrice];
}

- (void)dealloc {
    
    [_productImageView release];
    [_productNameLabel release];
    [_productPriceLabel release];
    [super dealloc];
}
@end
