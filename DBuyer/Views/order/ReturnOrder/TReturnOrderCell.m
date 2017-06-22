//
//  TReturnOrderCell.m
//  DBuyer
//
//  Created by dilei liu on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderCell.h"
#import "UIImageView+WebCache.h"
#import "TOrder.h"
#import "TGoods.h"

#define top_label_size          14
#define top_view_h              40

#define image_size_w            70
#define image_size_h            80

#define desc_label_size         14
#define goodsnum_label_size     18
#define goodsnum_price_size     18

#define margin_size             12
#define returnorder_size_w      80

#define cell_h                  150


@implementation TReturnOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1.0]];
    [self setFrame:CGRectMake(0, 0, self.frame.size.width, cell_h)];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width-2*10, self.frame.size.height-2*5)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    bgView.layer.cornerRadius = 3;
    [self.contentView addSubview:bgView];
    
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -2, bgView.frame.size.width+2, top_view_h)];
    [topView setImage:[UIImage imageNamed:@"order_top_gray1.png"]];
    [bgView addSubview:topView];
    
    _orderNum = [[UILabel alloc]init];
    _orderNum.font = [UIFont systemFontOfSize:top_label_size];
    [_orderNum setBackgroundColor:[UIColor clearColor]];
    [_orderNum setTextColor:[UIColor whiteColor]];
    [topView addSubview:_orderNum];
    
    _orderStatus = [[UILabel alloc]init];
    _orderStatus.font = [UIFont systemFontOfSize:top_label_size];
    [_orderStatus setBackgroundColor:[UIColor clearColor]];
    [_orderStatus setTextColor:[UIColor blackColor]];
    [topView addSubview:_orderStatus];
    
    _orderImageView = [[UIImageView alloc]init];
    [bgView addSubview:_orderImageView];
    
    _orderDescrption = [[UILabel alloc]init];
    [_orderDescrption setFont:[UIFont systemFontOfSize:desc_label_size]];
    [_orderDescrption setBackgroundColor:[UIColor clearColor]];
    [_orderDescrption setTextColor:[UIColor blackColor]];
    _orderDescrption.lineBreakMode = NSLineBreakByWordWrapping;
    _orderDescrption.numberOfLines = 2;
    [bgView addSubview:_orderDescrption];
    
    _prefixLabel = [[UILabel alloc]init];
    [_prefixLabel setFont:[UIFont systemFontOfSize:margin_size]];
    [_prefixLabel setBackgroundColor:[UIColor clearColor]];
    [_prefixLabel setTextColor:[UIColor blackColor]];
    [bgView addSubview:_prefixLabel];
    
    _goodsNumLabel = [[UILabel alloc]init];
    [_goodsNumLabel setFont:[UIFont systemFontOfSize:goodsnum_label_size]];
    [_goodsNumLabel setBackgroundColor:[UIColor clearColor]];
    [_goodsNumLabel setTextColor:[UIColor orangeColor]];
    [bgView addSubview:_goodsNumLabel];
    
    _suffixLabel = [[UILabel alloc]init];
    [_suffixLabel setFont:[UIFont systemFontOfSize:margin_size]];
    [_suffixLabel setBackgroundColor:[UIColor clearColor]];
    [_suffixLabel setTextColor:[UIColor blackColor]];
    [bgView addSubview:_suffixLabel];
    
    _totalJLabel = [[UILabel alloc]init];
    [_totalJLabel setFont:[UIFont systemFontOfSize:margin_size]];
    [_totalJLabel setBackgroundColor:[UIColor clearColor]];
    [_totalJLabel setTextColor:[UIColor blackColor]];
    [bgView addSubview:_totalJLabel];
    
    _totalPrice = [[UILabel alloc]init];
    [_totalPrice setFont:[UIFont systemFontOfSize:goodsnum_price_size]];
    [_totalPrice setBackgroundColor:[UIColor clearColor]];
    [_totalPrice setTextColor:[UIColor orangeColor]];
    [bgView addSubview:_totalPrice];
    
    _actionBtn = [[UIButton alloc]init];
    [bgView addSubview:_actionBtn];
    
    return self;
}

- (void)setDataForCell:(id)data andIndex:(int)indexRow {
    TOrder *order = (TOrder*)data;
    
    // top view
    [_orderNum setText:[NSString stringWithFormat:@"订单编号:%@",order.billNumber]];
    CGSize maximumLabelSize = CGSizeMake(180, 999);
    CGSize titleSize = [_orderNum.text sizeWithFont:_orderNum.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_orderNum setFrame:CGRectMake(5, (_orderNum.superview.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    [_orderStatus setText:@"退货中"];// order.status
    titleSize = [_orderStatus.text sizeWithFont:_orderStatus.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_orderStatus setFrame:CGRectMake(_orderStatus.superview.frame.size.width-titleSize.width-20, (_orderStatus.superview.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    // main image
    TGoods *goods = [order.goodss objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:goods.attrValue];
    [_orderImageView setImageWithURL:url];
    [_orderImageView setFrame:CGRectMake(20, _orderStatus.superview.frame.size.height+10, image_size_w, image_size_h)];
    [_orderImageView setBackgroundColor:[UIColor grayColor]];
    
    // product desc
    NSString *goodsName = goods.commodityName;
    [_orderDescrption setText:goodsName];
    titleSize = [_orderDescrption.text sizeWithFont:_orderDescrption.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_orderDescrption setFrame:CGRectMake(_orderImageView.frame.origin.x+_orderImageView.frame.size.width+20, _orderImageView.frame.origin.y, titleSize.width, titleSize.height)];
    
    float a = 20;
    if (_orderDescrption.frame.size.height>20) a = 10;
    [_prefixLabel setText:@"共有"];
    titleSize = [_prefixLabel.text sizeWithFont:_prefixLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_prefixLabel setFrame:CGRectMake(_orderDescrption.frame.origin.x, _orderDescrption.frame.origin.y+_orderDescrption.frame.size.height+a, titleSize.width, titleSize.height)];
    
    int goodsNum = 0;
    for (TGoods *goods in order.goodss) {
        goodsNum += [goods.number intValue];
    }
    
    NSString *number =  [NSString stringWithFormat:@"%i",goodsNum];
    [_goodsNumLabel setText:number];
    titleSize = [_goodsNumLabel.text sizeWithFont:_goodsNumLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_goodsNumLabel setFrame:CGRectMake(_prefixLabel.frame.origin.x+_prefixLabel.frame.size.width+3, _prefixLabel.frame.origin.y-2, titleSize.width, titleSize.height)];
    
    [_suffixLabel setText:@"件商品"];
    titleSize = [_suffixLabel.text sizeWithFont:_suffixLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_suffixLabel setFrame:CGRectMake(_goodsNumLabel.frame.origin.x+_goodsNumLabel.frame.size.width+3, _prefixLabel.frame.origin.y, titleSize.width, titleSize.height)];
    
    [_totalJLabel setText:@"总计:"];
    titleSize = [_totalJLabel.text sizeWithFont:_totalJLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_totalJLabel setFrame:CGRectMake(_orderDescrption.frame.origin.x, _suffixLabel.frame.origin.y+20, titleSize.width, titleSize.height)];
    
    [_totalPrice setText:order.paidAmount];
    titleSize = [_totalPrice.text sizeWithFont:_totalPrice.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_totalPrice setFrame:CGRectMake(_totalJLabel.frame.origin.x+_totalJLabel.frame.size.width+3, _totalJLabel.frame.origin.y-3, titleSize.width, titleSize.height)];
    
    [_actionBtn setFrame:CGRectMake(_actionBtn.superview.frame.size.width-15-returnorder_size_w, _prefixLabel.frame.origin.y, returnorder_size_w, 35)];
    [_actionBtn setBackgroundImage:[UIImage imageNamed:@"Order_Return_Progress.png"] forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:[UIImage imageNamed:@"Order_Return_Progress.png"] forState:UIControlStateHighlighted];
    _actionBtn.tag = indexRow;
}

- (void)setTargetAction:(id)target {
    [_actionBtn addTarget:target action:@selector(doProgressAction:) forControlEvents:UIControlEventTouchUpInside];
}


@end
