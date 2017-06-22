//
//  TConfirmPaymentController.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TConfirmPayOrderView.h"
#import "TConfirmPayWayView.h"
#import "TConfirmPayToolBar.h"
#import "UPOMP.h"
#import "TConfirmPay.h"
#import "TAllscoPayDelgate.h"
#import "KQPayOrder.h"

/**
 * 订单查看与购买订单逻辑控制器
 */
@interface TConfirmPaymentController : TRootViewController<UIScrollViewDelegate,UPOMPDelegate,TAllscoPayDelgate> {
    
    /**
     * 滑动视图，控制主界面高度
     */
    UIScrollView *_mainScrollView;
    
    /**
     * 订单信息视图
     */
    TConfirmPayOrderView *_orderView;
    
    /**
     * 支付方式选举列表
     */
    TConfirmPayWayView *_wayView;
    
    /**
     * Action工具栏视图区域
     */
    TConfirmPayToolBar *_toolBarView;
    
    /**
     * 支付成功提示视图
     */
    UIView *successBaseView;
    
    /**
     * 支付失败提示视图
     */
    UIView *fieldBaseView;
    
    KQPayOrder *kQPayOrder;
}

/**
 * 支付表单实体
 */
@property (nonatomic,retain)TConfirmPay *confirmPay;



- (id)initWithNavigationTitle:(NSString *)title andConfirPay:(TConfirmPay*)confirmPay;

@end
