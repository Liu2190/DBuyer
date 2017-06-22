//
//  TChargeBlockView.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TChargeBlockView.h"

#define label_font  12

@implementation TChargeBlockView

- (id)initWithFrame:(CGRect)frame andIndex:(int)index and:(TAllScoCard*)card isSelectIndex:(BOOL)selected{
    self = [super initWithFrame:frame];
    _card = card;
    
    int money = (index+1)*100;
    BOOL boolValue = [self computeLimitByMoney:money];
    UIColor *labelGB = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    UIColor *bordeColor = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    if (!boolValue) {
        bordeColor = [UIColor grayColor];
        labelGB = [UIColor grayColor];
    } else if (selected) {
        // bordeColor = [UIColor colorWithRed:0.0f green:97.0/255.0 blue:77.0/255.0 alpha:1];
        // labelGB = [UIColor colorWithRed:0.0f green:97.0/255.0 blue:77.0/255.0 alpha:1];
        bordeColor = [UIColor redColor];
        labelGB = [UIColor redColor];
    }
    
    
//    self.layer.borderColor = [bordeColor CGColor];
//    self.layer.borderWidth = .3;
    
    _chargeLabel = [[UILabel alloc]init];
    [_chargeLabel setText:[NSString stringWithFormat:@"%i元",money]];
    _chargeLabel.font = [UIFont systemFontOfSize:label_font];
    [_chargeLabel setTextColor:labelGB];
    [_chargeLabel setBackgroundColor:[UIColor clearColor]];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_chargeLabel.text sizeWithFont:_chargeLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_chargeLabel setFrame:CGRectMake((frame.size.width-titleSize.width)/2, (frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    [self addSubview:_chargeLabel];
    
    _chargeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _chargeButton.tag = (index+1);
    _chargeButton.userInteractionEnabled = YES;
    if (!boolValue) {
        _chargeButton.enabled = NO;
    }
    
    
    [self addSubview:_chargeButton];
    
    return self;
}

- (void)addTargetForButton:(id)obj {
    [_chargeButton addTarget:obj action:@selector(doClickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)computeLimitByMoney:(int)money {
    float a = (float)money;
    a += [_card.residual floatValue];
    if (a > 1000.0f)return NO;
    
    return YES;
}

@end
