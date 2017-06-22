//
//  TTopProgressView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-24.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TTopProgressView.h"
#import "UIButton+Extensions.h"
#import "TGoods.h"

#define margin_landscape    15
#define margin_portrait     10

#define FontSize_OrderNumber      14
#define ImageSize_MoneyMark_W     15
#define ImageSize_MoneyMark_H     20

#define Opration_Size_W     50
#define Opration_Size_H     30


@implementation TTopProgressView


- (id)initWithFrame:(CGRect)frame andTarget:(id)target{
    self = [super initWithFrame:frame];
    
    _orderNumberLabel = [[UILabel alloc]init];
    [_orderNumberLabel setFont:[UIFont boldSystemFontOfSize:FontSize_OrderNumber]];
    [_orderNumberLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_orderNumberLabel];
    
    _orderTotalPrice = [[UILabel alloc]init];
    [_orderTotalPrice setFont:[UIFont boldSystemFontOfSize:FontSize_OrderNumber]];
    [_orderTotalPrice setTextColor:[UIColor grayColor]];
    [self addSubview:_orderTotalPrice];
    
    _returnOrderMoney = [[UILabel alloc]init];
    [_returnOrderMoney setFont:[UIFont boldSystemFontOfSize:FontSize_OrderNumber]];
    [_returnOrderMoney setTextColor:[UIColor grayColor]];
    [self addSubview:_returnOrderMoney];
    
    _goodsMarkImage = [[UIImageView alloc]init];
    [self addSubview:_goodsMarkImage];
    
    _goodsListLabel = [[UILabel alloc]init];
    [_goodsListLabel setFont:[UIFont systemFontOfSize:FontSize_OrderNumber-2]];
    [_goodsListLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_goodsListLabel];
    
    _oprationBtn = [[UIButton alloc]init];
    [_oprationBtn addTarget:target action:@selector(doShowProductList:) forControlEvents:UIControlEventTouchUpInside];
    _oprationBtn.tag = 0; //默认为隐藏状态
    [self addSubview:_oprationBtn];
    
    _lineView = [[UIView alloc]init];
    [_lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [_lineView setFrame:CGRectMake(0, frame.size.height-.5, frame.size.width, .5)];
    [self addSubview:_lineView];
    
    return self;
}

- (void)setDataForView:(TOrder *)orderEnity {
    float x = margin_landscape;
    float y = margin_portrait;
    
    //
    NSString *orderNumber = [NSString stringWithFormat:@"订单编号: "]; //
    [_orderNumberLabel setText:orderNumber];
    CGSize maximumLabelSize = CGSizeMake(300, 999);
    CGSize titleSize = [_orderNumberLabel.text sizeWithFont:_orderNumberLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [_orderNumberLabel setFrame:CGRectMake(x, y, titleSize.width, FontSize_OrderNumber)];
    
    UILabel *billNumberLabel = [[UILabel alloc]init];
    billNumberLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    billNumberLabel.numberOfLines = 1;
    [billNumberLabel setFont:[UIFont systemFontOfSize:FontSize_OrderNumber]];
    [billNumberLabel setTextColor:[UIColor grayColor]];
    [billNumberLabel setText:orderEnity.billNumber];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [billNumberLabel.text sizeWithFont:billNumberLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByTruncatingTail];
    [billNumberLabel setFrame:CGRectMake(_orderNumberLabel.frame.size.width+_orderNumberLabel.frame.origin.x, y, titleSize.width, FontSize_OrderNumber)];
    [self addSubview:billNumberLabel];
    
    
    y += _orderNumberLabel.frame.size.height+5;
    NSString *orderTotalPrice = [NSString stringWithFormat:@"订单总价: ￥"]; //
    [_orderTotalPrice setText:orderTotalPrice];
    titleSize = [_orderTotalPrice.text sizeWithFont:_orderTotalPrice.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_orderTotalPrice setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    
    UILabel *totalPriceLabel = [[UILabel alloc]init];
    [totalPriceLabel setFont:[UIFont systemFontOfSize:FontSize_OrderNumber+4]];
    [totalPriceLabel setTextColor:[UIColor colorWithRed:239.0/255 green:176.0/255 blue:43/255 alpha:1]];
    [totalPriceLabel setText:orderEnity.paidAmount];
    titleSize = [totalPriceLabel.text sizeWithFont:totalPriceLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [totalPriceLabel setFrame:CGRectMake(_orderTotalPrice.frame.size.width+_orderTotalPrice.frame.origin.x,y-2,titleSize.width, titleSize.height)];
    [self addSubview:totalPriceLabel];
    
    
    y += _orderTotalPrice.frame.size.height+5;
    NSString *returnOrderMoney = [NSString stringWithFormat:@"退款金额: ￥"]; //
    [_returnOrderMoney setText:returnOrderMoney];
    titleSize = [_returnOrderMoney.text sizeWithFont:_returnOrderMoney.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_returnOrderMoney setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    
    UILabel *returnPriceLabel = [[UILabel alloc]init];
    [returnPriceLabel setFont:[UIFont systemFontOfSize:FontSize_OrderNumber+3]];
    [returnPriceLabel setTextColor:[UIColor colorWithRed:239.0/255 green:176.0/255 blue:43/255 alpha:1]];
    [returnPriceLabel setText:orderEnity.paidAmount];
    titleSize = [returnPriceLabel.text sizeWithFont:returnPriceLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [returnPriceLabel setFrame:CGRectMake(_returnOrderMoney.frame.size.width+_returnOrderMoney.frame.origin.x,y-2,titleSize.width, titleSize.height)];
    [self addSubview:returnPriceLabel];
    
    y += _returnOrderMoney.frame.size.height+8;
    [_goodsMarkImage setImage:[UIImage imageNamed:@"ReturnOrder_MoneyMark.png"]];
    [_goodsMarkImage setFrame:CGRectMake(x, y, ImageSize_MoneyMark_W, ImageSize_MoneyMark_H)];
    
    [_oprationBtn setImage:[UIImage imageNamed:@"ReturnOrder_progress_downArrow.png"] forState:UIControlStateNormal];
    [_oprationBtn setImage:[UIImage imageNamed:@"ReturnOrder_progress_downArrow.png"] forState:UIControlStateHighlighted];
    [_oprationBtn setFrame:CGRectMake(self.frame.size.width-margin_landscape-Opration_Size_W-5, y, Opration_Size_W, Opration_Size_H)];
    [_oprationBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -30)];
    
    int goodsNumber = 0;
    for (TGoods *goods in orderEnity.goodss) goodsNumber += [goods.number intValue];
    [_goodsListLabel setText:[NSString stringWithFormat:@"商品清单(共%i件商品)",goodsNumber]];
    titleSize = [_goodsListLabel.text sizeWithFont:_goodsListLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_goodsListLabel setFrame:CGRectMake(x+_goodsMarkImage.frame.origin.x+5, y+5, titleSize.width, titleSize.height)];
}

@end


