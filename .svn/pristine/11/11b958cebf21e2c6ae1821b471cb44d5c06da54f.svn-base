//
//  TAllscoOrderListController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderListController.h"
#import "TBuyerOrderDetailController.h"
#import "TChargeOrderDetailController.h"
#import "TAllscoOrderForm.h"
#import "TAllscoOrderCell.h"
#import "TUtilities.h"

#define tabBar_height_size  45

@implementation TAllscoOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShow = YES;
    
    //
    CGRect rect = CGRectMake(0, 0, self.contentView.frame.size.width, tabBar_height_size);
    NSArray *nameItems = @[@"购卡",@"储值"];
    _orderTabBar = [[TTabBarControl alloc]initWithFrame:rect andNameItems:nameItems];
    _orderTabBar.tabBarDelegate = self;
    _tabBarRect = _orderTabBar.view.frame;
    [self.contentView addSubview:_orderTabBar.view];

    //
    _mainScrollView = [[TAllscoOrderScrollView alloc]initWithFrame:CGRectMake(0, tabBar_height_size, self.contentView.frame.size.width, self.contentView.frame.size.height-tabBar_height_size) andPageNum:2];
    _mainScrollView.delegate = self;
    _contentFrame = _mainScrollView.frame;
    [self.contentView addSubview:_mainScrollView];
    
    //
    _buyerList = [[TBuyerListOrderController alloc]init];
    _buyerList.allscoOrderDelegate = self;
    _buyerList.frame = CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
    
    //
    _chargeList = [[TChargeListOrderController alloc]init];
    _chargeList.allscoOrderDelegate = self;
    _chargeList.frame = CGRectMake(0, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self doTabBarClicked:[_mainScrollView getCurrentPageNO]];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int pageNo = [_mainScrollView getCurrentPageNO];
//    [_orderTabBar updateLineOnSwitch:pageNo];
//    
//    UIView *pageView = [_mainScrollView getPageViewByPageIndex:pageNo];
//    int pagesub = [pageView subviews].count;
//    
//    if (pageNo == 0 && pagesub ==0) {
//        [pageView addSubview:_buyerList.view];
//    } else if (pageNo == 1 && pagesub ==0) {
//        [pageView addSubview:_chargeList.view];
//    }
//}

- (void)doTabBarClicked:(int)index {
    UIView *pageView = [_mainScrollView getPageViewByPageIndex:index];
    int pagesub = [pageView subviews].count;
    
    if (index == 0 && pagesub ==0) {
        [pageView addSubview:_buyerList.view];
    } else if (index == 1 && pagesub ==0) {
        [pageView addSubview:_chargeList.view];
    }
    
    [_mainScrollView scrollPageByPageNum:index];
}

- (void)pushBuyerDetail:(id)detailObj {
    TAllscoOrderForm *orderForm = (TAllscoOrderForm*)detailObj;
    TBuyerOrderDetailController *buyerOrderDetailController = [[TBuyerOrderDetailController alloc]initWithNavigationTitle:@"购卡订单详情" andOrderForm:orderForm];
    [self.navigationController pushViewController:buyerOrderDetailController animated:YES];
    [buyerOrderDetailController release];
}

- (void)pushChargeDetail:(id)detailObj {
    TAllscoOrderForm *orderForm = (TAllscoOrderForm*)detailObj;
    
    TChargeOrderDetailController *buyerOrderDetailController = [[TChargeOrderDetailController alloc]initWithNavigationTitle:@"储值订单详情" andOrderForm:orderForm];
    [self.navigationController pushViewController:buyerOrderDetailController animated:YES];
    [buyerOrderDetailController release];
}

- (void)scrollHidenTabBarByDistance:(float)distance andDirection:(ScrollDirection)direction {
    
    if (direction == direction_up) { // 手势滑动向上，代表翻页并隐藏tabbar
        if ((_orderTabBar.view.frame.origin.y-distance) >= -(_tabBarRect.origin.y+tabBar_height_size)) {
            [self scrollMoveByView:_orderTabBar.view andMoveY:-distance andMoveH:0];
        }
        
        if ((_mainScrollView.frame.origin.y-distance) >= _contentFrame.origin.y-tabBar_height_size) {
            [self scrollMoveByView:_mainScrollView andMoveY:-distance andMoveH:distance];
            
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:distance];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:distance];
            }
        }
    }
    
    if (direction == direction_down) { // 手势滑动向下
        if ((_orderTabBar.view.frame.origin.y+distance) <= _tabBarRect.origin.y) {
            [self scrollMoveByView:_orderTabBar.view andMoveY:distance andMoveH:0];
        }
        
        if ((_mainScrollView.frame.origin.y+distance) <= _contentFrame.origin.y) {
            [self scrollMoveByView:_mainScrollView andMoveY:distance andMoveH:-distance];
            
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:-distance];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:-distance];
            }
        }
    }
    
    if (direction == direction_up_none ) {
        if(fabs(_orderTabBar.view.frame.origin.y) > tabBar_height_size/2) { // step hidden
            // orderTabBar
            float beyond = tabBar_height_size - fabs(_orderTabBar.view.frame.origin.y);
            [self scrollMoveByView:_orderTabBar.view andMoveY:-beyond andMoveH:0];
            // _mainScrollView
            beyond = 0 - fabs(_mainScrollView.frame.origin.y);
            [self scrollMoveByView:_mainScrollView andMoveY:-beyond andMoveH:beyond];
            
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:beyond];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:beyond];
            }
            
        } else {
            // orderTabBar
            float beyond = fabs(_orderTabBar.view.frame.origin.y);
            [self scrollMoveByView:_orderTabBar.view andMoveY:beyond andMoveH:0];
            // _mainScrollView
            beyond = _contentFrame.origin.y - fabs(_mainScrollView.frame.origin.y);
            [self scrollMoveByView:_mainScrollView andMoveY:beyond andMoveH:-beyond];
            
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:-beyond];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:-beyond];
            }
        }
    }
    
    if (direction == direction_down_none){ // convert show
        if(fabs(_orderTabBar.view.frame.origin.y) < tabBar_height_size/2) { // step hidden
            
            // orderTabBar
            float beyond = fabs(_orderTabBar.view.frame.origin.y);
            [self scrollMoveByView:_orderTabBar.view andMoveY:beyond andMoveH:0];
            
            // _mainScrollView
            beyond = _contentFrame.origin.y - fabs(_mainScrollView.frame.origin.y);
            [self scrollMoveByView:_mainScrollView andMoveY:beyond andMoveH:-beyond];
            
            // tableView
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:-beyond];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:-beyond];
            }
        } else {
            // orderTabBar
            float beyond = tabBar_height_size - fabs(_orderTabBar.view.frame.origin.y);
            [self scrollMoveByView:_orderTabBar.view andMoveY:-beyond andMoveH:0];
            // _mainScrollView
            beyond = tabBar_height_size - fabs(_mainScrollView.frame.origin.y);
            [self scrollMoveByView:_mainScrollView andMoveY:-beyond andMoveH:beyond];
            
            // tableView
            if ([_mainScrollView getCurrentPageNO] == 0) {
                [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:beyond];
            }
            
            if ([_mainScrollView getCurrentPageNO] == 1) {
                [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:beyond];
            }
        }
    }
    
    if (direction == direction_top) { // show
        // orderTabBar
        float beyond = fabs(_orderTabBar.view.frame.origin.y);
        [self scrollMoveByView:_orderTabBar.view andMoveY:beyond andMoveH:0];
        
        // _mainScrollView
        beyond = _contentFrame.origin.y - fabs(_mainScrollView.frame.origin.y);
        [self scrollMoveByView:_mainScrollView andMoveY:beyond andMoveH:-beyond];
        
        // tableView
        if ([_mainScrollView getCurrentPageNO] == 0) {
            [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:-beyond];
        }
        
        if ([_mainScrollView getCurrentPageNO] == 1) {
            [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:-beyond];
        }
    }
    
    if (direction == direction_bottom) {  // hiden
        // orderTabBar
        if(fabs(_orderTabBar.view.frame.origin.y) == tabBar_height_size) return;
        
        // _mainScrollView
        float beyond = 0 - fabs(_orderTabBar.view.frame.origin.y);
        beyond = 0 - fabs(_mainScrollView.frame.origin.y);
        [self scrollMoveByView:_mainScrollView andMoveY:-beyond andMoveH:beyond];
        
        if ([_mainScrollView getCurrentPageNO] == 0) {
            [self scrollMoveByView:_buyerList.tableView andMoveY:0 andMoveH:beyond];
        }
        
        if ([_mainScrollView getCurrentPageNO] == 1) {
            [self scrollMoveByView:_chargeList.tableView andMoveY:0 andMoveH:beyond];
        }
    }
}

/**
 * 滑动处理视图位置调整
 */
- (void)scrollMoveByView:(UIView*)moveView andMoveY:(float)moveY andMoveH:(float)moveH {
    
    CGRect rect = moveView.frame;
    rect.origin.y += moveY;
    rect.size.height += moveH;
    moveView.frame = rect;
}

- (void)addSubView {
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navigationBar];
}

@end
