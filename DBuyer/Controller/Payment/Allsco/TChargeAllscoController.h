//
//  TChargeAllscoController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TAllscoCard.h"
#import "TAllscoChargeFormController.h"
#import "KQPayOrder.h"
#import "UPOMP.h"

@class TAllscoChargeFormController;

@interface TChargeAllscoController : TRootViewController <UPOMPDelegate> {
    /**
     * 支付成功提示视图
     */
    UIView *successBaseView;
    
    /**
     * 支付失败提示视图
     */
    UIView *fieldBaseView;
    
    KQPayOrder *kQPayOrder;
    
    /**
     * 快钱订单格式的订单值
     */
    NSString *kqOrderString;
    
    TAllScoCharge *_allscoCharge;
}


@property (nonatomic,retain)TAllscoChargeFormController *chargeFormController;
@property (nonatomic,retain)TAllScoCard *card;

- (void)chargeAllscoByCharge:(TAllScoCharge*)allscoCharge;

@end
