//
//  OrderFooterView.h
//  DBuyer
//
//  Created by simman on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//  结算中心、订单通用底部试图

#import <UIKit/UIKit.h>

@interface OrderFooterView : UIView

@property (retain, nonatomic) IBOutlet UIButton *checkBoxButton;    // 复选框按钮
@property (retain, nonatomic) IBOutlet UILabel *totalTitle;         // 总价标题
@property (retain, nonatomic) IBOutlet UILabel *totalPrice;         // 总价
@property (retain, nonatomic) IBOutlet UIButton *payButton;         // 支付按钮


+ (id)initWithNib;
- (id)initWithTotalPrice:(NSString *)price payButtonTitle:(NSString *)payTitle CheckBoxHidden:(BOOL)isHidden;

- (IBAction)payButtonAction:(id)sender;                             // 支付按钮事件
- (IBAction)checkBoxButtonAction:(id)sender;                        // 复选框事件

- (void)setCheckBoxButtonStatus:(BOOL)isChecked;
- (void)addTarget:(id)target checkBoxAction:(SEL)CBAction payAction:(SEL)pyAction;
- (void)setTotalPrice:(NSString *)price payButtonTitle:(NSString *)payTitle CheckBoxHidden:(BOOL)isHidden;

- (void)clearStatus;

- (void)setFooterViewTotalPrice:(NSString *)price;      // 设置价格
- (void)setFooterviewPayTitle:(NSString *)title;        // 设置标题

- (void)setDidFinishOrderDetailView;    // 设置已经完成订单的样式
- (void)setWaitConsigneeDetailView;     // 设置等待付款FooterView样式

@end
