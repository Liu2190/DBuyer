//
//  ToShoppingCartView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToShoppingCartView : UIView
@property (retain, nonatomic) IBOutlet UIButton *hideButton;
@property (retain, nonatomic) IBOutlet UITextField *countTextField;
@property (retain, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (retain, nonatomic) IBOutlet UIButton *decreaseButton;
@property (retain, nonatomic) IBOutlet UIButton *increaseButton;
@property (retain, nonatomic) IBOutlet UIButton *buyButton;
@property (retain, nonatomic) IBOutlet UILabel *confirmLabel;
- (IBAction)hideThisView:(id)sender;
- (IBAction)decreaseAction:(id)sender;
- (IBAction)inscreaseAction:(id)sender;
- (IBAction)confirmAction:(id)sender;
-(void)addAction:(id)target With:(SEL)hideAction And:(SEL)decreaseAction And:(SEL)increaseAction And:(SEL)confirmAction;
-(void)showShopViewWith:(NSString *)title;
-(void)setShoppingCartViewCount:(int)count AndPrice:(float)price;
@end
