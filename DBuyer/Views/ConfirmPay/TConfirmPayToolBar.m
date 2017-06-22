//
//  TConfirmPayToolBar.m
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TConfirmPayToolBar.h"

@implementation TConfirmPayToolBar

- (id)initWithFrame:(CGRect)frame andPayAmount:(NSString*)payAmount {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:99.0/255.0 alpha:.7]];
    
    _payActionBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-180/2-15, 5, 180/2, 40)];
    [_payActionBtn setImage:[UIImage imageNamed:@"ConfirmPay_payBtn_default.png"] forState:UIControlStateNormal];
    [_payActionBtn setImage:[UIImage imageNamed:@"ConfirmPay_payBtn_selected.png"] forState:UIControlStateHighlighted];
    [self addSubview:_payActionBtn];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont systemFontOfSize:14]];
    [textLabel setTextColor:[UIColor whiteColor]];
    [textLabel setText:@"总价:"];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:maximumLabelSize
                                    lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = CGRectMake(30, (frame.size.height-titleSize.height)/2+5, titleSize.width, titleSize.height);
    [textLabel setFrame:rect];
    [self addSubview:textLabel];
    
    
    UILabel *flagLabel = [[UILabel alloc]init];
    flagLabel.lineBreakMode = NSLineBreakByWordWrapping;
    flagLabel.numberOfLines = 0;
    [flagLabel setBackgroundColor:[UIColor clearColor]];
    [flagLabel setFont:[UIFont systemFontOfSize:14]];
    [flagLabel setTextColor:[UIColor blackColor]];
    [flagLabel setText:@"￥"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [flagLabel.text sizeWithFont:flagLabel.font constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByWordWrapping];
    [flagLabel setFrame:CGRectMake(textLabel.frame.origin.x+textLabel.frame.size.width+10, textLabel.frame.origin.y+2, titleSize.width, titleSize.height)];
    [self addSubview:flagLabel];
    
    UILabel *textValueLabel = [[UILabel alloc]init];
    textValueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textValueLabel.numberOfLines = 0;
    [textValueLabel setBackgroundColor:[UIColor clearColor]];
    [textValueLabel setFont:[UIFont systemFontOfSize:22]];
    [textValueLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
    NSString *totalPrice = [NSString stringWithFormat:@"%.2f",[payAmount floatValue]];
    [textValueLabel setText:totalPrice];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [textValueLabel.text sizeWithFont:textValueLabel.font constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByWordWrapping];
    [textValueLabel setFrame:CGRectMake(flagLabel.frame.origin.x+flagLabel.frame.size.width, (frame.size.height-titleSize.height)/2+3, titleSize.width, titleSize.height)];
    [self addSubview:textValueLabel];
    
    return self;
}

- (void)setActionForTarget:(id)target {
    [_payActionBtn addTarget:target action:@selector(doPayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@end
