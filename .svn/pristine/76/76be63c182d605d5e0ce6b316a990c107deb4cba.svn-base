//
//  OrderTraceHeaderView.h
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderTraceHeaderView : UIView


@property (retain, nonatomic) IBOutlet UILabel *haulierName;    // 承运人
@property (retain, nonatomic) IBOutlet UILabel *orderId;    // 订单编号
@property (retain, nonatomic) IBOutlet UILabel *totalPrice; // 订单总价
@property (retain, nonatomic) IBOutlet UILabel *goodsCount; // 订单商品数量
@property (retain, nonatomic) IBOutlet UIButton *arrowsButton;  // 箭头按钮
- (IBAction)arrowsAction:(id)sender;    // 箭头事件

- (void)setOrderTraceHeaderViewDataWithOrder:(Order *)order isShowAllProduct:(BOOL)showAll
;
- (void)addTarget:(id)target Action:(SEL)action;

@end
