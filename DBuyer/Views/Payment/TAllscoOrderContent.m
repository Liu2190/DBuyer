//
//  TAllscoOrderContent.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderContent.h"

#define arrow_width_size    8
#define arrow_height_size   13

#define xline_area_height   40
#define cell_right_sep      20
#define cell_left_sep       20

#define font_size   15
#define other_font_size 13

#define cardImage_width_size    125

@implementation TAllscoOrderContent

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIImageView *xlineView = [[UIImageView alloc]initWithFrame:
                              CGRectMake(cell_left_sep, xline_area_height-1, self.frame.size.width-2*cell_right_sep, 1)];
    [xlineView setImage:[UIImage imageNamed:@"AllscoOrder_xLing.png"]];
    [self addSubview:xlineView];
    
    _orderNumberTitle = [[UILabel alloc]init];
    _orderNumberTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _orderNumberTitle.numberOfLines = 0;
    [_orderNumberTitle setBackgroundColor:[UIColor clearColor]];
    [_orderNumberTitle setFont:[UIFont boldSystemFontOfSize:font_size]];
    [_orderNumberTitle setTextColor:[UIColor grayColor]];
    [self addSubview:_orderNumberTitle];
    
    _orderNumber = [[UILabel alloc]init];
    _orderNumber.lineBreakMode = NSLineBreakByWordWrapping;
    _orderNumber.numberOfLines = 0;
    [_orderNumber setBackgroundColor:[UIColor clearColor]];
    [_orderNumber setFont:[UIFont systemFontOfSize:font_size]];
    [_orderNumber setTextColor:[UIColor grayColor]];
    [self addSubview:_orderNumber];
    
    _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-cell_right_sep-arrow_width_size, (xline_area_height-arrow_height_size)/2, arrow_width_size, arrow_height_size)];
    [_arrowImageView setImage:[UIImage imageNamed:@"AllscoOrder_Arrow.png"]];
    [self addSubview:_arrowImageView];
    
    _cardImageView = [[UIImageView alloc]init];
    [self addSubview:_cardImageView];
    
    _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, xline_area_height+10, 1, self.frame.size.height-xline_area_height-20)];
    [_lineImageView setImage:[UIImage imageNamed:@"AllScoGood_BuyLine.png"]];
    [self addSubview:_lineImageView];
    
    _orderDate = [[UILabel alloc]init];
    _orderDate.lineBreakMode = NSLineBreakByWordWrapping;
    _orderDate.numberOfLines = 0;
    [_orderDate setBackgroundColor:[UIColor clearColor]];
    [_orderDate setFont:[UIFont systemFontOfSize:other_font_size]];
    [_orderDate setTextColor:[UIColor grayColor]];
    [self addSubview:_orderDate];
    
    _orderAmountTitle = [[UILabel alloc]init];
    _orderAmountTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _orderAmountTitle.numberOfLines = 0;
    [_orderAmountTitle setBackgroundColor:[UIColor clearColor]];
    [_orderAmountTitle setFont:[UIFont systemFontOfSize:other_font_size]];
    [_orderAmountTitle setTextColor:[UIColor grayColor]];
    [self addSubview:_orderAmountTitle];
    
    _orderAmount = [[UILabel alloc]init];
    _orderAmount.lineBreakMode = NSLineBreakByWordWrapping;
    _orderAmount.numberOfLines = 0;
    [_orderAmount setBackgroundColor:[UIColor clearColor]];
    [_orderAmount setFont:[UIFont systemFontOfSize:other_font_size]];
    [_orderAmount setTextColor:[UIColor redColor]];
    [self addSubview:_orderAmount];
    
    _orderStatusTitle = [[UILabel alloc]init];
    _orderStatusTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _orderStatusTitle.numberOfLines = 0;
    [_orderStatusTitle setBackgroundColor:[UIColor clearColor]];
    [_orderStatusTitle setFont:[UIFont systemFontOfSize:other_font_size]];
    [_orderStatusTitle setTextColor:[UIColor grayColor]];
    [self addSubview:_orderStatusTitle];
    
    _orderStatus = [[UILabel alloc]init];
    _orderStatus.lineBreakMode = NSLineBreakByWordWrapping;
    _orderStatus.numberOfLines = 0;
    [_orderStatus setBackgroundColor:[UIColor clearColor]];
    [_orderStatus setFont:[UIFont systemFontOfSize:other_font_size]];
    [_orderStatus setTextColor:[UIColor redColor]];
    [self addSubview:_orderStatus];
    
    return self;
}

- (void)setDataForView:(TAllscoOrderForm*)orderForm {
    [_orderNumberTitle setText:@"订单编号："];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_orderNumberTitle.text sizeWithFont:_orderNumberTitle.font constrainedToSize:maximumLabelSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    [_orderNumberTitle setFrame:CGRectMake(cell_left_sep, (xline_area_height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    //
    [_orderNumber setText:orderForm.orderNum];
    titleSize = [_orderNumber.text sizeWithFont:_orderNumber.font constrainedToSize:maximumLabelSize
                                              lineBreakMode:NSLineBreakByWordWrapping];
    [_orderNumber setFrame:CGRectMake(_orderNumberTitle.frame.origin.y+_orderNumberTitle.frame.size.width+5, (xline_area_height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    //
    NSURL *url = [NSURL URLWithString:orderForm.allscoUrl];
    [_cardImageView setImageWithURL:url];
    [_cardImageView setFrame:CGRectMake(cell_left_sep, xline_area_height+10, cardImage_width_size, self.frame.size.height-xline_area_height-2*10)];
    
    [_orderDate setText:orderForm.orderDate];
    titleSize = [_orderDate.text sizeWithFont:_orderDate.font constrainedToSize:maximumLabelSize
                                  lineBreakMode:NSLineBreakByWordWrapping];
    [_orderDate setFrame:CGRectMake(self.frame.size.width/2+15, xline_area_height+15, titleSize.width, titleSize.height)];
    
    //
    [_orderAmountTitle setText:@"订单金额："];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_orderAmountTitle.text sizeWithFont:_orderAmountTitle.font constrainedToSize:maximumLabelSize
                                              lineBreakMode:NSLineBreakByWordWrapping];
    [_orderAmountTitle setFrame:CGRectMake(self.frame.size.width/2+15, _orderDate.frame.origin.y+_orderDate.frame.size.height+10, titleSize.width, titleSize.height)];
    
    [_orderAmount setText:[NSString stringWithFormat:@"￥%@",orderForm.orderAmount]];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_orderAmount.text sizeWithFont:_orderAmount.font constrainedToSize:maximumLabelSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    [_orderAmount setFrame:CGRectMake(_orderAmountTitle.frame.size.width+_orderAmountTitle.frame.origin.x+5, _orderDate.frame.origin.y+_orderDate.frame.size.height+10, titleSize.width, titleSize.height)];
    
    [_orderStatusTitle setText:@"订单状态："];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_orderStatusTitle.text sizeWithFont:_orderStatusTitle.font constrainedToSize:maximumLabelSize
                                  lineBreakMode:NSLineBreakByWordWrapping];
    [_orderStatusTitle setFrame:CGRectMake(self.frame.size.width/2+15, _orderAmountTitle.frame.origin.y+_orderAmountTitle.frame.size.height+10, titleSize.width, titleSize.height)];
    
    [_orderStatus setText:orderForm.orderStatus];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_orderStatus.text sizeWithFont:_orderStatus.font constrainedToSize:maximumLabelSize
                                  lineBreakMode:NSLineBreakByWordWrapping];
    [_orderStatus setFrame:CGRectMake(_orderStatusTitle.frame.size.width+_orderStatusTitle.frame.origin.x+5, _orderAmountTitle.frame.origin.y+_orderAmountTitle.frame.size.height+10, titleSize.width, titleSize.height)];
}

@end
