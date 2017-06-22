//
//  TAllscoGoodBuyerToolBar.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoGoodBuyerToolBar.h"


#define font_size   20
#define btn_size_width  110
#define btn_size_height 35

@implementation TAllscoGoodBuyerToolBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1]];
    moneySize = 0;
    
    UILabel *totalLabel = [[UILabel alloc]init];
    totalLabel.lineBreakMode = NSLineBreakByWordWrapping;
    totalLabel.numberOfLines = 0;
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    [totalLabel setFont:[UIFont systemFontOfSize:font_size]];
    [totalLabel setTextColor:[UIColor whiteColor]];
    [totalLabel setText:@"总计:"];
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [totalLabel.text sizeWithFont:totalLabel.font constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    [totalLabel setFrame:CGRectMake(15, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    [self addSubview:totalLabel];
    
    _totalValueLabel = [[UILabel alloc]init];
    [self addSubview:_totalValueLabel];
    _totalValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _totalValueLabel.numberOfLines = 0;
    [_totalValueLabel setBackgroundColor:[UIColor clearColor]];
    [_totalValueLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_totalValueLabel setTextColor:[UIColor whiteColor]];
    [self updateTotalValueLabel];
    
    _buyerBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-15-btn_size_width, (self.frame.size.height-btn_size_height)/2, btn_size_width, btn_size_height)];
    [_buyerBtn setBackgroundImage:[UIImage imageNamed:@"AllscoGood_Buyer.png"] forState:UIControlStateNormal];
    [_buyerBtn setBackgroundImage:[UIImage imageNamed:@"AllscoGood_Buyer_Clicked.png"] forState:UIControlStateHighlighted];
    [self addSubview:_buyerBtn];
    
    return self;
}

- (NSString*)getMoneyString {
    return [NSString stringWithFormat:@"￥%i",moneySize];
}

- (void)updateTotalValueLabel {
    [_totalValueLabel setText:[self getMoneyString]];
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_totalValueLabel.text sizeWithFont:_totalValueLabel.font constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    [_totalValueLabel setFrame:CGRectMake(70, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
}

- (void)addActionForTarget:(id)target {
    [_buyerBtn addTarget:target action:@selector(doBuyerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMoneySize:(int)size {
    moneySize = size;
    [self updateTotalValueLabel];
}

@end
