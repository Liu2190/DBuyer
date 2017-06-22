//
//  TAllscoOrderListController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TabBarDelegate.h"
#import "TAllscoOrderScrollView.h"
#import "TAllscoOrderDelegate.h"
#import "TTabBarControl.h"
#import "TBuyerListOrderController.h"
#import "TChargeListOrderController.h"

@interface TAllscoOrderListController : TRootViewController<TabBarDelegate,
    TAllscoOrderDelegate,UIScrollViewDelegate> {
        
        TAllscoOrderScrollView *_mainScrollView;
        TTabBarControl *_orderTabBar;
        
        TBuyerListOrderController *_buyerList;
        TChargeListOrderController *_chargeList;
        
        CGRect _contentFrame;
        CGRect _tabBarRect;
        BOOL _isShow;
}

@end
