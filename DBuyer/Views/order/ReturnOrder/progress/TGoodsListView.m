//
//  TGoodsListView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-24.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TGoodsListView.h"
#import "TGoodsBlockView.h"
#import "TGoods.h"

#define GoodsBlock_View_H   70

@implementation TGoodsListView

- (id)initWithFrame:(CGRect)frame andGoods:(NSArray*)goodss {
    self = [super initWithFrame:frame];
    
    for (int i=0; i<goodss.count; i++) {
        TGoods *goods = [goodss objectAtIndex:i];
        TGoodsBlockView *goodsBlockView = [self genGoodsBlockView:goods andIndex:i];
        [self addSubview:goodsBlockView];
        [goodsBlockView release];
        H += goodsBlockView.frame.size.height;
    }
    
    return self;
}

- (TGoodsBlockView*) genGoodsBlockView:(TGoods*)goods andIndex:(int)index {
    float x = 0;
    float y = index*GoodsBlock_View_H;
    CGRect rect = CGRectMake(x, y, self.frame.size.width, GoodsBlock_View_H);
    TGoodsBlockView *goodsBlockView = [[TGoodsBlockView alloc]initWithFrame:rect andGoods:goods];
    
    return goodsBlockView;
}

- (float)getViewHeight {
    return H;
}

@end
