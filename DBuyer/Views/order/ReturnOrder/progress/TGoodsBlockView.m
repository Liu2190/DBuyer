//
//  TGoodsBlockView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TGoodsBlockView.h"

#define margin_left 15
#define margin_top  10

#define image_view_w   50
#define image_view_h   50

#define FontSize_OrderNumber    15

@implementation TGoodsBlockView


- (id)initWithFrame:(CGRect)frame andGoods:(TGoods*)goods{
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor whiteColor]];
    CGRect imagerect = CGRectMake(margin_left, margin_top, image_view_w, image_view_h);
    _imageview = [[UIImageView alloc]initWithFrame:imagerect];
    [_imageview setImageWithURL:[NSURL URLWithString:goods.attrValue]];
    [self addSubview:_imageview];
    
    _goodsDescLabel = [[UILabel alloc]init];
    [_goodsDescLabel setFont:[UIFont systemFontOfSize:FontSize_OrderNumber-1]];
    _goodsDescLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _goodsDescLabel.numberOfLines = 2;
    [_goodsDescLabel setTextColor:[UIColor grayColor]];
    [_goodsDescLabel setText:goods.commodityName];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_goodsDescLabel.text sizeWithFont:_goodsDescLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_goodsDescLabel setFrame:CGRectMake(_imageview.frame.origin.x+_imageview.frame.size.width+15, _imageview.frame.origin.y, titleSize.width, titleSize.height)];
    [self addSubview:_goodsDescLabel];
    
    _mark1 = [[UILabel alloc]init];
    [_mark1 setFont:[UIFont systemFontOfSize:FontSize_OrderNumber-5]];
    [_mark1 setBackgroundColor:[UIColor clearColor]];
    [_mark1 setTextColor:[UIColor grayColor]];
    [_mark1 setText:@"￥"];
    titleSize = [_mark1.text sizeWithFont:_mark1.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark1 setFrame:CGRectMake(_goodsDescLabel.frame.origin.x, frame.size.height-margin_top-titleSize.height, titleSize.width, titleSize.height)];
    [self addSubview:_mark1];
    
    _mark1Value = [[UILabel alloc]init];
    [_mark1Value setBackgroundColor:[UIColor clearColor]];
    [_mark1Value setFont:[UIFont systemFontOfSize:FontSize_OrderNumber]];
    [_mark1Value setTextColor:[UIColor colorWithRed:239.0/255 green:176.0/255 blue:43/255 alpha:1]];
    [_mark1Value setText:[NSString stringWithFormat:@"%@",goods.sellPrice]];
    titleSize = [_mark1Value.text sizeWithFont:_mark1Value.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark1Value setFrame:CGRectMake(_mark1.frame.origin.x+_mark1.frame.size.width, frame.size.height-margin_top-titleSize.height, titleSize.width, titleSize.height)];
    [self addSubview:_mark1Value];
    
    _mark2 = [[UILabel alloc]init];
    [_mark2 setFont:[UIFont systemFontOfSize:FontSize_OrderNumber-5]];
    [_mark2 setBackgroundColor:[UIColor clearColor]];
    [_mark2 setTextColor:[UIColor grayColor]];
    [_mark2 setText:@"x"];
    titleSize = [_mark2.text sizeWithFont:_mark2.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark2 setFrame:CGRectMake(160, frame.size.height-margin_top-titleSize.height, titleSize.width, titleSize.height)];
    [self addSubview:_mark2];
    
    _mark2Value = [[UILabel alloc]init];
    [_mark2Value setBackgroundColor:[UIColor clearColor]];
    [_mark2Value setFont:[UIFont systemFontOfSize:FontSize_OrderNumber]];
    [_mark2Value setTextColor:[UIColor grayColor]];
    [_mark2Value setText:[NSString stringWithFormat:@"%@",goods.number]];
    titleSize = [_mark2Value.text sizeWithFont:_mark2Value.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark2Value setFrame:CGRectMake(_mark2.frame.origin.x+_mark2.frame.size.width, frame.size.height-margin_top-titleSize.height+1, titleSize.width, titleSize.height)];
    [self addSubview:_mark2Value];
    
    _mark3 = [[UILabel alloc]init];
    [_mark3 setFont:[UIFont systemFontOfSize:FontSize_OrderNumber-5]];
    [_mark3 setBackgroundColor:[UIColor clearColor]];
    [_mark3 setTextColor:[UIColor grayColor]];
    [_mark3 setText:@"小计:"];
    titleSize = [_mark3.text sizeWithFont:_mark3.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark3 setFrame:CGRectMake(230, frame.size.height-margin_top-titleSize.height, titleSize.width, titleSize.height)];
    [self addSubview:_mark3];
    
    _mark3Value = [[UILabel alloc]init];
    [_mark3Value setBackgroundColor:[UIColor clearColor]];
    [_mark3Value setFont:[UIFont systemFontOfSize:FontSize_OrderNumber]];
    [_mark3Value setTextColor:[UIColor colorWithRed:239.0/255 green:176.0/255 blue:43/255 alpha:1]];
    [_mark3Value setText:[NSString stringWithFormat:@"%@",goods.amountPayable]];
    titleSize = [_mark3Value.text sizeWithFont:_mark3Value.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_mark3Value setFrame:CGRectMake(_mark3.frame.origin.x+_mark3.frame.size.width, frame.size.height-margin_top-titleSize.height+1, titleSize.width, titleSize.height)];
    [self addSubview:_mark3Value];
    
    return self;
}

@end
