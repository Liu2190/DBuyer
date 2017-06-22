//
//  TReturnOrderProgressController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderProgressController.h"
#import "TTopProgressView.h"
#import "TServerFactory.h"
#import "TOrderServer.h"
#import "TActivityView.h"
#import "TUtilities.h"

#define order_baseinfo_h    110


@implementation TReturnOrderProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, _mainScrollView.frame.size.height+1)];
    [self.contentView addSubview:_mainScrollView];
    

    CGRect topRect = CGRectMake(0, 0, self.contentView.frame.size.width, order_baseinfo_h);
    TTopProgressView *topProgressView = [[TTopProgressView alloc]initWithFrame:topRect andTarget:self];
    [topProgressView setBackgroundColor:[UIColor whiteColor]];
    [topProgressView setDataForView:_order];
    [_mainScrollView addSubview:topProgressView];
    
    float y = topRect.size.height;
    _goodsListView = [[TGoodsListView alloc]initWithFrame:CGRectMake(0, y, _mainScrollView.frame.size.width, 0) andGoods:_order.goodss];
    [_mainScrollView addSubview:_goodsListView];
    
    
    y += _goodsListView.frame.size.height;
    float h = _mainScrollView.frame.size.height - topRect.size.height;
    CGRect mainViewRect = CGRectMake(0, y, _mainScrollView.frame.size.width, h);
    _progressMainView = [[TProgressMainView alloc]initWithFrame:mainViewRect];
    [_progressMainView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    [_mainScrollView addSubview:_progressMainView];
    
    TActivityView *activityView = [[TActivityView alloc]initWithFrame:CGRectMake(0, 0, mainViewRect.size.width, mainViewRect.size.height/2)];
    [_progressMainView addSubview:activityView];
    [activityView startAnimation];
    
    [[TServerFactory getServerInstance:@"TOrderServer"]doOrderFollowUpByOrderId:_order.serverId
                                                                    andCallback:^(TOrderProgress *orderProgress) {
                                                                        [activityView stopAnimation];
                                                                        [_progressMainView setDataForView:orderProgress];
                                                                        
                                                                    } failureCallback:^(NSString *resp) {
                                                                        [activityView stopAnimation];
                                                                        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
                                                                    }];
}

/**
 * sender强转button,并对button的select状态作切换
 * 如果为1:则商品列表为显示；如果为0:则商品列表不显示
 */
- (void)doShowProductList:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    btn.selected = !btn.selected;
    float h = [_goodsListView getViewHeight];
    
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"ReturnOrder_progress_uparrow.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ReturnOrder_progress_uparrow.png"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"ReturnOrder_progress_downArrow.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ReturnOrder_progress_downArrow.png"] forState:UIControlStateNormal];
        h = 0;
    }
    
    [UIView animateWithDuration:.5 animations:^{
        float x = _goodsListView.frame.origin.x;
        float y = _goodsListView.frame.origin.y;
        [_goodsListView setFrame:CGRectMake(x, y, _goodsListView.frame.size.width, h)];
        [_progressMainView setFrame:CGRectMake(x, _goodsListView.frame.size.height+_goodsListView.frame.origin.y, _progressMainView.frame.size.width, _progressMainView.frame.size.height)];
    } completion:^(BOOL finished) {
        [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, _progressMainView.frame.size.height+_progressMainView.frame.origin.y+1)];
    }];
}



- (void)dealloc {
    [super dealloc];
    
    
}

@end
