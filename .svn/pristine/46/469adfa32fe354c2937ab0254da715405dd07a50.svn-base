//
//  ClickToBuyView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ClickToBuyView.h"

@interface ClickToBuyView ()

@property (nonatomic, assign) id target;
@property (nonatomic) SEL selectAllAction;
@property (nonatomic) SEL buyAction;


@end

@implementation ClickToBuyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)clickToBuyView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ClickToBuyView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    // 全选默认关
    self.didSelectAll = NO;
    // 设置显示
    self.selectAllImageView.alpha = 0.0;
}

- (void)addTarget:(id)target selectAllAction:(SEL)selectAllAction buyAction:(SEL)buyAction
{
    self.target = target;
    self.selectAllAction = selectAllAction;
    self.buyAction = buyAction;
}

- (void)setSelectAllStatus:(BOOL)status
{
    self.didSelectAll = status;
    // 设置显示
    if (status) { // 如果全选，则显示
        self.selectAllImageView.alpha = 0.9;
    } else {
        self.selectAllImageView.alpha = 0.0;
    }
}

- (void)setTotalPrice:(float)price
{
    if (price < 0.0) {
        price = 0.0;
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f", price];
}

- (IBAction)BuyButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.buyAction withObject:self];
}

- (IBAction)selectAllButtonClicked:(UIButton *)sender
{
    // 全选按钮反转
    self.didSelectAll = !self.didSelectAll;
    // 设置显示
    if (self.didSelectAll) { // 如果全选，则显示
        self.selectAllImageView.alpha = 0.9;
    } else {
        self.selectAllImageView.alpha = 0.0;
    }
    
    [self.target performSelector:self.selectAllAction withObject:self];
}
- (void)dealloc {
    [_totalPriceLabel release];
    [_selectAllImageView release];
    [_priceTitleLabel release];
    [super dealloc];
}
@end
