//
//  TAllScoPayView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoPayView.h"
#import "TUtilities.h"
#import "TBlockPayCardView.h"

#define top_margin    20
#define sp_margin     10

#define font_size     16


#define allsco_choice_height    40
#define allsco_validata_height  40

@implementation TAllScoPayView

- (id)initWithFrame:(CGRect)frame andConfirmPay:(TConfirmPay*)confirmPay {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    self.confirmPay = confirmPay;
    
    // 商户名称
    UILabel *goodsNameLabel = [[UILabel alloc]init];
    goodsNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    goodsNameLabel.numberOfLines = 0;
    [goodsNameLabel setBackgroundColor:[UIColor clearColor]];
    [goodsNameLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [goodsNameLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [goodsNameLabel setText:@"商户名称:  "];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [goodsNameLabel.text sizeWithFont:goodsNameLabel.font constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByWordWrapping];
    [goodsNameLabel setFrame:CGRectMake(0, top_margin, titleSize.width, titleSize.height)];
    [self addSubview:goodsNameLabel];
    float h = goodsNameLabel.frame.origin.y+goodsNameLabel.frame.size.height;
    
    _goodsNameValue = [[UILabel alloc]init];
    _goodsNameValue.lineBreakMode = NSLineBreakByWordWrapping;
    _goodsNameValue.numberOfLines = 0;
    [_goodsNameValue setBackgroundColor:[UIColor clearColor]];
    [_goodsNameValue setFont:[UIFont systemFontOfSize:font_size]];
    [_goodsNameValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [_goodsNameValue setText:@"尚超市BHG"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_goodsNameValue.text sizeWithFont:_goodsNameValue.font constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByWordWrapping];
    [_goodsNameValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, top_margin, titleSize.width, titleSize.height)];
    [self addSubview:_goodsNameValue];
    
    
    // 金额
    UILabel *moneyLabel = [[UILabel alloc]init];
    moneyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    moneyLabel.numberOfLines = 0;
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [moneyLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [moneyLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [moneyLabel setText:@"金额:  "];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [moneyLabel.text sizeWithFont:moneyLabel.font constrainedToSize:maximumLabelSize
                                            lineBreakMode:NSLineBreakByWordWrapping];
    [moneyLabel setFrame:CGRectMake(0,h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:moneyLabel];

    _moneyValue = [[UILabel alloc]init];
    _moneyValue.lineBreakMode = NSLineBreakByWordWrapping;
    _moneyValue.numberOfLines = 0;
    [_moneyValue setBackgroundColor:[UIColor clearColor]];
    [_moneyValue setFont:[UIFont systemFontOfSize:font_size]];
    [_moneyValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [_moneyValue setText:_confirmPay.paidAmount];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_moneyValue.text sizeWithFont:_moneyValue.font constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByWordWrapping];
    [_moneyValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:_moneyValue];
    h = moneyLabel.frame.origin.y+moneyLabel.frame.size.height;
    
    // 订单号
    UILabel *orderNumLabel = [[UILabel alloc]init];
    orderNumLabel.lineBreakMode = NSLineBreakByWordWrapping;
    orderNumLabel.numberOfLines = 0;
    [orderNumLabel setBackgroundColor:[UIColor clearColor]];
    [orderNumLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [orderNumLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [orderNumLabel setText:@"订单号:"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [orderNumLabel.text sizeWithFont:orderNumLabel.font constrainedToSize:maximumLabelSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    [orderNumLabel setFrame:CGRectMake(0,h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:orderNumLabel];
    
    _orderNumValue = [[UILabel alloc]init];
    _orderNumValue.lineBreakMode = NSLineBreakByTruncatingTail;
    _orderNumValue.numberOfLines = 1;
    [_orderNumValue setBackgroundColor:[UIColor clearColor]];
    [_orderNumValue setFont:[UIFont systemFontOfSize:font_size]];
    [_orderNumValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [_orderNumValue setText:_confirmPay.orderIdList];
    maximumLabelSize = CGSizeMake(frame.size.width-goodsNameLabel.frame.origin.x-goodsNameLabel.frame.size.width, font_size);
    titleSize = [_orderNumValue.text sizeWithFont:_moneyValue.font constrainedToSize:maximumLabelSize
                                 lineBreakMode:NSLineBreakByTruncatingTail];
    [_orderNumValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:_orderNumValue];
     h = _orderNumValue.frame.origin.y+_orderNumValue.frame.size.height;
    
    
    // 交易时间
    UILabel *tradeTimeLabel = [[UILabel alloc]init];
    tradeTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tradeTimeLabel.numberOfLines = 0;
    [tradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [tradeTimeLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [tradeTimeLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [tradeTimeLabel setText:@"交易时间:  "];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [tradeTimeLabel.text sizeWithFont:tradeTimeLabel.font constrainedToSize:maximumLabelSize
                                   lineBreakMode:NSLineBreakByWordWrapping];
    [tradeTimeLabel setFrame:CGRectMake(0,h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:tradeTimeLabel];
    
    _tradeTimeValue = [[UILabel alloc]init];
    _tradeTimeValue.lineBreakMode = NSLineBreakByTruncatingTail;
    _tradeTimeValue.numberOfLines = 1;
    [_tradeTimeValue setBackgroundColor:[UIColor clearColor]];
    [_tradeTimeValue setFont:[UIFont systemFontOfSize:font_size]];
    [_tradeTimeValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [_tradeTimeValue setText:_confirmPay.orderDate];
    maximumLabelSize = CGSizeMake(frame.size.width-goodsNameLabel.frame.origin.x-goodsNameLabel.frame.size.width, font_size);
    titleSize = [_tradeTimeValue.text sizeWithFont:_tradeTimeValue.font constrainedToSize:maximumLabelSize
                                    lineBreakMode:NSLineBreakByTruncatingTail];
    [_tradeTimeValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [self addSubview:_tradeTimeValue];
    h = _tradeTimeValue.frame.origin.y+_tradeTimeValue.frame.size.height;
    
    
    // 虚拟卡选择控件
    _choiceView = [[TAllScoChoiceView alloc]initWithFrame:CGRectMake(0, h+2*sp_margin, frame.size.width, allsco_choice_height)];
    _choiceView.userInteractionEnabled = YES;
    [self addSubview:_choiceView];
    
    _validataView = [[TAllScoValidataView alloc]initWithFrame:CGRectMake(0, _choiceView.frame.origin.y+_choiceView.frame.size.height+1.5*sp_margin, frame.size.width, allsco_validata_height)];
    [self addSubview:_validataView];
    
    _tradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tradeBtn  setFrame:CGRectMake(0, _validataView.frame.origin.y+_validataView.frame.size.height+3*sp_margin, frame.size.width, allsco_choice_height)];
    [_tradeBtn setImage:[UIImage imageNamed:@"AllScoPay_PayBtn.png"] forState:UIControlStateNormal];
    [_tradeBtn setImage:[UIImage imageNamed:@"AllScoPay_PayBtn_Clicked.png"] forState:UIControlStateHighlighted];
    [self addSubview:_tradeBtn];
    
    return self;
}

- (void)setTargetForButton:(id)target {
    [_tradeBtn addTarget:target action:@selector(doPayButtonActon:) forControlEvents:UIControlEventTouchUpInside];
    
    [_choiceView setTargetForView:target];
    [_validataView setTargetForView:target];
}

- (void)switchAllscoListView:(BOOL)boolValue {
    [_choiceView switchAllscoListView:boolValue];
}

- (CGPoint)getPointForChoiceView {
    CGPoint point = CGPointMake(_choiceView.frame.origin.x, _choiceView.frame.origin.y+_choiceView.frame.size.height);
    return point;
}

- (void)setValueForChoiceView:(NSString*)value {
    [_choiceView setValueForControl:value];
}

- (int)getSelectCardIndexRowValue {
    return _choiceView.tag;
}

- (void)setSelectCardIndexRowValue:(int)row {
    _choiceView.tag = row;
}

- (void)updateValidataBlock {
    [_validataView updateValidataBlock];
}

- (NSString*)getValidataNum {
    return [_validataView getValidataNum];
}

- (void)cancelBoard {
    [_validataView cancelBoard];
}


- (void)dealloc {
    [super dealloc];
    
    [_confirmPay release];
    _confirmPay = nil;
    
    [_choiceView release];
    _choiceView = nil;
    
    [_validataView release];
    _validataView = nil;
    
    [_goodsNameValue release];
    _goodsNameValue = nil;
    
    [_moneyValue release];
    _moneyValue = nil;
 
    [_orderNumValue release];
    _orderNumValue = nil;
    
    [_tradeTimeValue release];
    _tradeTimeValue = nil;

}

@end
