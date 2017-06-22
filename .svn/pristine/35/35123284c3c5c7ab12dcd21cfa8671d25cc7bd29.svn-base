//
//  ActiveView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ActiveView.h"
@interface ActiveView()
{
    int _thisIndex;
}
@end
@implementation ActiveView

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
-(void)setActiveViewValueWith:(Product *)product AndIndex:(int)index
{
    self.backImage.layer.cornerRadius = 2.0;
    [self.activeProImage setImageWithURL:[NSURL URLWithString:product.attrValue] placeholderImage:[UIImage imageNamed:@"placeHolerImage80"]];
    self.activeNameLabel.text = product.commodityName;
    self.activePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",product.sellPrice];
    if(product.sellPrice >= product.marketPrice)
    {
        self.deleteImage.hidden = YES;
        self.marketPrice.hidden = YES;
    }
    else
    {
        self.marketPrice.text = [NSString stringWithFormat:@"￥%.2f",product.marketPrice];
        self.deleteImage = NO;
    }
    _thisIndex = index;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    [self addGestureRecognizer:tap];
}
-(void)TapClick:(UITapGestureRecognizer *)sender
{
    [self.delegate activeDidClick:_thisIndex];
}
- (void)dealloc {
    [_activeProImage release];
    [_activeNameLabel release];
    [_activePriceLabel release];
    [_backImage release];
    [_marketPrice release];
    [_deleteImage release];
    [super dealloc];
}
@end
