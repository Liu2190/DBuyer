//
//  TReturnOrderDetailController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderDetailController.h"
#import "TReturnOrderProgressController.h"
#import "TReturnOrderDetailView.h"
#import "TReturnOrderDetailTop.h"

#define Tool_Size_H     60

#define ReturnOrder_Progress_H  30
#define ReturnOrder_Progress_W  80

#define DetailTop_H             110

@implementation TReturnOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景可滑动效果
    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height-Tool_Size_H)];
    [bgScrollView setBackgroundColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1.0]];
    [bgScrollView setContentSize:CGSizeMake(bgScrollView.frame.size.width, bgScrollView.frame.size.height+.5)];
    [self.contentView addSubview:bgScrollView];
    
    // 顶部内容区域
    TReturnOrderDetailTop *detailTopView = [[TReturnOrderDetailTop alloc]initWithFrame:
                                            CGRectMake(0, 0, bgScrollView.frame.size.width, DetailTop_H) andOrder:_order];
    [detailTopView setBackgroundColor:[UIColor whiteColor]];
    [bgScrollView addSubview:detailTopView];

    
    // 中部内容区域
    TReturnOrderDetailView *detailMiddleView = [[TReturnOrderDetailView alloc]initWithFrame:CGRectMake(0, detailTopView.frame.size.height, bgScrollView.frame.size.width, bgScrollView.frame.size.height-detailTopView.frame.size.height-Tool_Size_H)];
    [detailMiddleView setBackgroundColor:[UIColor clearColor]];
    [bgScrollView addSubview:detailMiddleView];
    
    
    // 底部工具栏
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-Tool_Size_H, self.contentView.frame.size.width, Tool_Size_H)];
    [toolView setBackgroundColor:[UIColor colorWithHue:53/255.0 saturation:53/255.0 brightness:53/255.0 alpha:1.0]];
    [self.contentView addSubview:toolView];
    
    float x = toolView.frame.size.width-10-ReturnOrder_Progress_W;
    float y = (toolView.frame.size.height - ReturnOrder_Progress_H)/2;
    
    UIButton *actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, ReturnOrder_Progress_W, ReturnOrder_Progress_H)];
    [actionBtn setBackgroundImage:[UIImage imageNamed:@"Order_Return_Progress.png"] forState:UIControlStateNormal];
    [actionBtn setBackgroundImage:[UIImage imageNamed:@"Order_Return_Progress.png"] forState:UIControlStateHighlighted];
    [actionBtn addTarget:self action:@selector(doReturnOrderProgress:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:actionBtn];
}

- (void)doReturnOrderProgress:(id)sender {
    TReturnOrderProgressController *returnOrderprogressController = [[TReturnOrderProgressController alloc]initWithNavigationTitle:@"退款订单进度"];
    returnOrderprogressController.isPushOpen = NO;
    returnOrderprogressController.order = _order;
    [self.navigationController presentViewController:returnOrderprogressController animated:YES completion:nil];
}

- (void)dealloc {
    [super dealloc];
    
    [_order release];
    _order = nil;
}

@end
