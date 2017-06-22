//
//  SettlementPayMentFooterView.h
//  DBuyer
//
//  Created by simman on 14-1-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  底部结算按钮视图
 */
@interface SettlementPayMentFooterView : UIView

@property (retain, nonatomic) IBOutlet UIButton *goPaymentButton;       // 去支付按钮
@property (retain, nonatomic) IBOutlet UILabel *totalPriceLable;        // 总价

/**
 *  支付按钮事件
 *
 *  @param sender 按钮
 */
- (IBAction)goPaymentButtonAction:(id)sender;

/**
 *  按钮回调
 *
 *  @param target   控制器
 *  @param pyAction 支付按钮事件
 */
- (void)addTarget:(id)target
        payAction:(SEL)pyAction;

@end
