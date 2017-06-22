//
//  ToShoppingCartView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ToShoppingCartView.h"
@interface ToShoppingCartView()
{
    id _thisTarget;
    SEL _thisHideAction;
    SEL _thisIncreaseAction;
    SEL _thisDecreaseAction;
    SEL _ToBuyAction;
}
@end
@implementation ToShoppingCartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_hideButton release];
    [_countTextField release];
    [_totalPriceLabel release];
    [_decreaseButton release];
    [_increaseButton release];
    [_buyButton release];
    [_confirmLabel release];
    [super dealloc];
}
- (IBAction)hideThisView:(id)sender {
    [_thisTarget performSelector:_thisHideAction];
}

- (IBAction)decreaseAction:(id)sender {
    [_thisTarget performSelector:_thisDecreaseAction];
}

- (IBAction)inscreaseAction:(id)sender {
    [_thisTarget performSelector:_thisIncreaseAction];
}

- (IBAction)confirmAction:(id)sender {
    [_thisTarget performSelector:_ToBuyAction];
}
-(void)addAction:(id)target With:(SEL)hideAction And:(SEL)decreaseAction And:(SEL)increaseAction And:(SEL)confirmAction
{
    _thisTarget = target;
    _thisHideAction = hideAction;
    _thisDecreaseAction = decreaseAction;
    _thisIncreaseAction = increaseAction;
    _ToBuyAction = confirmAction;
}
-(void)setShoppingCartViewCount:(int)count AndPrice:(float)price
{
    self.countTextField.text = [NSString stringWithFormat:@"%d",count];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",count*price];
}
-(void)showShopViewWith:(NSString *)title
{
    self.confirmLabel.text = title;
}
@end
