//
//  ProDetailsView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProDetailsView.h"
@interface ProDetailsView()
{
    float proheight;
}
@end
@implementation ProDetailsView

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
-(void)setProDetailViewWith:(ProductDetail *)thisProduct
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //商品名称高度需要计算
    CGRect frame = self.proName.frame;
    UIFont *font = self.proName.font;
    frame.size.height = [self heightForString:thisProduct.commodityName font:font andWidth:frame.size.width].height;
    self.proName.frame = frame;
    self.proName.text = thisProduct.commodityName;
    CGFloat originY = frame.origin.y + frame.size.height ;
    //促销信息高度需要计算
    if([thisProduct.salesPromotion length]>0)
    {
        originY = originY + 11.0;
        font = self.cuxiaoLabel.font;
        CGFloat height = [self heightForString:thisProduct.salesPromotion font:font andWidth:frame.size.width].height;
        self.cuxiaoLabel.text = thisProduct.salesPromotion;
        frame = self.cuxiaoLabel.frame;
        frame.origin.y = originY;
        frame.size.height = height;
        self.cuxiaoLabel.frame = frame;
        originY = frame.origin.y + frame.size.height;
    }
    else{
        self.cuxiaoLabel.hidden = YES;
    }
    frame = self.moneySymbol.frame;
    frame.origin.y = originY+16;
    self.moneySymbol.frame = frame;
    
    //现价坐标
    
    NSString *sellPriceString = [NSString stringWithFormat:@"%.2f",thisProduct.sellPrice];
    self.sellPrice.text = sellPriceString;
    frame = self.sellPrice.frame;
    frame.size.width = sellPriceString.length * 11;
    frame.origin.y = originY+14;
    self.sellPrice.frame = frame;
    
    if(thisProduct.sellPrice >= thisProduct.marketPrice || thisProduct.marketPrice == 0)
    {
        //如果商品的现价大于或者等于原价
        self.marketPrice.hidden = YES;
        self.deleteImage.hidden = YES;
    }
    else{
        //如果商品的现价小于原价
        CGFloat originX = frame.origin.x + frame.size.width + 23 ;
        self.marketPrice.hidden = NO;
        NSString *marketPriceString = [NSString stringWithFormat:@"￥%.2f",thisProduct.marketPrice];
        self.marketPrice.text = marketPriceString;
        frame = self.marketPrice.frame;
        frame.origin.x = originX;
        frame.origin.y = originY+14 ;
        self.marketPrice.frame = frame;
        CGPoint center = self.marketPrice.center;
        originX = frame.origin.x-2;
        frame = self.deleteImage.frame;
        frame.size.width = self.marketPrice.text.length *8;
        frame.origin.x = originX;
        frame.origin.y = center.y-1;
        self.deleteImage.frame = frame;
    }
    //判断关键词的字数
    if([thisProduct.keyWord count]==1)
    {
        self.bqImage1.alpha = 1;
        self.bqImage2.alpha = 0;
        self.bqImage3.alpha = 0;
        self.bqLabel1.text = [thisProduct.keyWord objectAtIndex:0];
    }
    else if([thisProduct.keyWord count]==2)
    {
        self.bqImage1.alpha = 1;
        self.bqImage2.alpha = 1;
        self.bqImage3.alpha = 0;
        self.bqLabel1.text = [thisProduct.keyWord objectAtIndex:0];
        self.bqLabel2.text = [thisProduct.keyWord objectAtIndex:1];
    }
    else if([thisProduct.keyWord count]>2)
    {
        self.bqImage1.alpha = 1;
        self.bqImage2.alpha = 1;
        self.bqImage3.alpha = 1;
        self.bqLabel1.text = [thisProduct.keyWord objectAtIndex:0];
        self.bqLabel2.text = [thisProduct.keyWord objectAtIndex:1];
        self.bqLabel3.text = [thisProduct.keyWord objectAtIndex:2];
    }
    else
    {
        self.bqImage1.alpha = 0;
        self.bqImage2.alpha = 0;
        self.bqImage3.alpha = 0;
        frame = self.proName.frame;
        frame.size.width = 280;
        self.proName.frame = frame;
    }
    if([thisProduct.realInventory length]!=0){
        self.kucunLabel.text = [NSString stringWithFormat:@"库存量:%@",thisProduct.realInventory];
        frame = self.kucunLabel.frame;
        frame.origin.x = 20;
        frame.origin.y = originY + 43;
        self.kucunLabel.frame = frame;
        originY = frame.origin.y;
    }
    proheight = originY + 30;
   // self.arrowImage.image = (thisProduct.isOpen == YES)?[UIImage imageNamed:@"arrows_bottom_up.png"]:[UIImage imageNamed:@"arrows_bottom.png"];
}
-(float)heightOfPro
{
    return proheight;
}
-(float)getHeight:(ProductDetail *)product
{
    if([product.salesPromotion length]!=0)
    {
        return 160+[self heightForString:product.salesPromotion fontSize:13 andWidth:270];;
    }
    return 155.0f;
}
-(CGSize)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit;
}
//换行
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit.height;
}
- (void)dealloc {
    [_arrowImage release];
    [_proName release];
    [_sellPrice release];
    [_marketPrice release];
    [_bqImage1 release];
    [_bqImage2 release];
    [_bqImage3 release];
    [_bqLabel1 release];
    [_bqLabel2 release];
    [_bqLabel3 release];
    [_cuxiaoLabel release];
    [_kucunLabel release];
    [_spreadButton release];
    [_moneySymbol release];
    [_deleteImage release];
    [super dealloc];
}
@end
