//
//  TOrderMenuView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderMenuView.h"
#import "TOrderMenuBlock.h"

@implementation TOrderMenuView


- (id)initWithFrame:(CGRect)frame andImageNames:(NSArray *)imageNames andDelegate:(id)obj{
    self = [super initWithFrame:frame];
    self.orderMenus = [[NSMutableArray alloc]init];
    self.buttonImageNames = imageNames;
    
    float w = self.frame.size.width/_buttonImageNames.count;
    float h = self.frame.size.height;
    
    for (int i = 0; i<_buttonImageNames.count; i++) {
        NSString *buttonImageName = [_buttonImageNames objectAtIndex:i];
        TOrderMenuBlock *menuBlock = [[TOrderMenuBlock alloc]initWithFrame:CGRectMake(w*i, 0, w, h) andDelegate:obj];
        [menuBlock setFlagForMenuBtn:i];
        [menuBlock setOrderMenuViewData:buttonImageName];
        [self addSubview:menuBlock];
        
        [_orderMenus addObject:menuBlock];
        [menuBlock release];
    }
    
    return self;
}

- (void)showOrderNum:(TOrdersNum*)ordersNum {
    for (TOrderMenuBlock *orderMenuBlock in _orderMenus) {
        if (ordersNum == nil) [orderMenuBlock showMarkNumber:0];
        
        if ([orderMenuBlock getFlagForMenuBtn] == 0) { // 待付款
            [orderMenuBlock showMarkNumber:ordersNum.noPayOrderInfo];
        }
        
        if ([orderMenuBlock getFlagForMenuBtn] == 1) { // 待收货
            [orderMenuBlock showMarkNumber:ordersNum.noGetGoods];
        }
        
        if ([orderMenuBlock getFlagForMenuBtn] == 2) { // 已完成
            [orderMenuBlock showMarkNumber:ordersNum.alreadyGoods];
        }
        
        if ([orderMenuBlock getFlagForMenuBtn] == 3) { // 退款中
            [orderMenuBlock showMarkNumber:ordersNum.refundCount];
        }
        
    }
}

- (void)dealloc {
    [super dealloc];
    
    [_orderMenus release];
    _orderMenus = nil;
}

@end
