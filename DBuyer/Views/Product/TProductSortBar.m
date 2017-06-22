//
//  TProductSortBar.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProductSortBar.h"
#import "TSortBlockView.h"

@implementation TProductSortBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _blocks = [[NSMutableArray alloc]init];

    NSDictionary *dcit1 = @{@"text":@"新品",@"defaultImage":@"Image_ProductList_02.png",@"clickImage":@"Image_ProductList_01.png"};
    NSDictionary *dcit2 = @{@"text":@"销量",@"defaultImage":@"Image_ProductList_02.png",@"clickImage":@"Image_ProductList_01.png"};
    NSDictionary *dcit3 = @{@"text":@"价格",@"defaultImage":@"Image_ProductList_09.png",@"clickImage":@"Image_ProductList_03.png"};
    NSArray *blocks = @[dcit1,dcit2,dcit3];
    
    float w = frame.size.width/blocks.count;
    float h = frame.size.height;

    for (int i=0;i<blocks.count;i++) {
        float x = i*w; float y = 0;
        NSDictionary *dic = [blocks objectAtIndex:i];
        TSortBlockView *blockView = [[TSortBlockView alloc]initWithFrame:CGRectMake(x, y, w, h) andDict:dic andIndex:i];
        [self addSubview:blockView];
        [_blocks addObject:blockView];
        [blockView release];
    }
    
    return self;
}

- (void)addTargetForAction:(id)obj {
    for (TSortBlockView *blockView in _blocks) {
        [blockView addTargetForAction:obj];
    }
}

- (void)updateImageDis:(int)sortType {
    for (int i =0; i<_blocks.count; i++) {
        TSortBlockView *blockView = [_blocks objectAtIndex:i];
        if (sortType == i) {
            [blockView updateImageViewDis:YES];
        } else {
            [blockView updateImageViewDis:NO];
        }
    }
}

- (void)setPriceBlockImage:(BOOL)isAsc {
    TSortBlockView *blockView = [_blocks lastObject];
    [blockView setPriceBlockImage:isAsc];
}


@end
