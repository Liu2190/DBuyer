//
//  TPayWayBlockView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPayWayBlockView.h"

#define btn_width    30
#define btn_height   30

#define logoImage_width     100
#define logoImage_height    25

@implementation TPayWayBlockView

- (id)initWithFrame:(CGRect)frame logoImageName:(NSString*)logoImageName andLogoDescName:(NSString*)logoDescName {
    self = [super initWithFrame:frame];

    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
    
    _selectPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 18, btn_width, btn_height)];
    [_selectPayBtn setImage:[UIImage imageNamed:@"ConfirmPay_unSelected.png"] forState:UIControlStateNormal];
    [_selectPayBtn setImage:[UIImage imageNamed:@"ConfirmPay_hadSelected.png"] forState:UIControlStateHighlighted];
    [self addSubview:_selectPayBtn];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_selectPayBtn.frame.origin.x+btn_width+20, 18, logoImage_width, logoImage_height)];
    [logoImageView setImage:[UIImage imageNamed:logoImageName]];
    [self addSubview:logoImageView];
    
    float x = logoImageView.frame.origin.x+logoImageView.frame.size.width/2;
    if ([logoImageName isEqualToString:@"ConfirmPay_UM_Logo.png"]) {
        x = logoImageView.frame.origin.x+logoImageView.frame.size.width;
    }
    UILabel *payWayNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, 20, 180, 15)];
    [payWayNameLabel setText:logoDescName];
    [payWayNameLabel setTextColor:[UIColor grayColor]];
    [payWayNameLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:payWayNameLabel];
    
    return self;
}

- (void)setActionForTarget:(id)target {
    [_selectPayBtn addTarget:target action:@selector(doPayWayClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTagForBtn:(int)paywayType {
    _selectPayBtn.tag = paywayType;
}

- (int)getTagForBtn {
    return _selectPayBtn.tag;
}

- (BOOL)isSelected2Btn {
    return _selectPayBtn.isSelected;
}

- (void)updateBtnImage:(BOOL)isSelected {
    if (isSelected) {
        [_selectPayBtn setImage:[UIImage imageNamed:@"ConfirmPay_hadSelected.png"] forState:UIControlStateSelected];
        [_selectPayBtn setSelected:YES];
        
    } else {
        [_selectPayBtn setImage:[UIImage imageNamed:@"ConfirmPay_unSelected.png"] forState:UIControlStateNormal];
        [_selectPayBtn setSelected:NO];
        
    }
}

- (void)dealloc {
    [super dealloc];
    [_selectPayBtn release];
    _selectPayBtn = nil;
}


@end
