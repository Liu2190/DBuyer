//
//  TReturnOrderProgressController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TGoodsListView.h"
#import "TOrder.h"
#import "TProgressMainView.h"

@interface TReturnOrderProgressController : TRootViewController {
    UIScrollView *_mainScrollView;
    TGoodsListView *_goodsListView;
    TProgressMainView *_progressMainView;

}

@property (nonatomic,retain)TOrder *order;



@end

