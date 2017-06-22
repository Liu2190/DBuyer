//
//  ClickToBuyView.h
//  DBuyer
//
//  Created by chenpeng on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClickToBuyView : UIView

@property (retain, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *selectAllImageView;
@property (retain, nonatomic) IBOutlet UILabel *totalPriceLabel;
// 全选状态
@property (nonatomic) BOOL didSelectAll;


- (IBAction)BuyButtonClicked:(UIButton *)sender;
- (IBAction)selectAllButtonClicked:(UIButton *)sender;

// 遍历构造器方法
+ (id)clickToBuyView;

// 自定义target action 方法
- (void)addTarget:(id)target
  selectAllAction:(SEL)selectAllAction
        buyAction:(SEL)buyAction;

// 设置全选状态
- (void)setSelectAllStatus:(BOOL)status;

// 设置总价显示
- (void)setTotalPrice:(float)price;
@end
