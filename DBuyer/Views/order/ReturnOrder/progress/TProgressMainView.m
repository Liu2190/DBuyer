//
//  TProgressMainView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-24.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProgressMainView.h"
#import "TProgressBlock.h"
#import "TProgressBlockView.h"

#define margin_left_size        50
#define margin_top_size         20

#define margin_block_size       15

#define line_w  2


@implementation TProgressMainView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _blocks = [[NSMutableArray alloc]init];
    
    
    return self;
}

- (void)setDataForView:(TOrderProgress *)orderProgress {
    float y = margin_top_size;
    float x = margin_left_size;
    
    for (int i=0; i<orderProgress.progress.count; i++) {
        TProgressBlock *progressBlock = [orderProgress.progress objectAtIndex:i];
        if (progressBlock.orderId.length ==0) continue;
        
        CGPoint point = CGPointMake(x, y);
        TProgressBlockView *progressBlockView = [[TProgressBlockView alloc]initWithPoint:point andProgressBlock:progressBlock];
        [self addSubview:progressBlockView];
        y += progressBlockView.frame.size.height+margin_block_size;
        
        [_blocks addObject:progressBlockView];
        [progressBlockView release];
    }
    
    [self computeForDrawLine];
}

- (void)computeForDrawLine {
    for (int i=0; i<_blocks.count; i++) {
        if (i ==_blocks.count-1) continue; // 第一个和最后一个点间线忽略
    
        CGPoint startPoint = [self getOriginForBlockViewByIndex:i];
        CGPoint endPoint = [self getPointSizeByIndex:i+1];
        
        
        [self drawLineForPoints:startPoint andEndPoint:endPoint];
    }
}

- (CGPoint)getPointSizeByIndex:(int)index {
    TProgressBlockView *blockView = [_blocks objectAtIndex:index];
    return blockView.center;
}

- (CGPoint)getOriginForBlockViewByIndex:(int)index {
    TProgressBlockView *blockView = [_blocks objectAtIndex:index];
    CGRect pointRect = [blockView getPointRect];
    
    float y = blockView.center.y;
    float x = margin_left_size + pointRect.origin.x + pointRect.size.width/2-1;
    
    return CGPointMake(x, y);
}

- (void)drawLineForPoints:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint {
    float x = startPoint.x;
    float y = startPoint.y+10;
    
    float h = endPoint.y - startPoint.y;
    h -= 20;
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, line_w, h)];
    [lineImageView setImage:[UIImage imageNamed:@"ReturnOrder_Progress_VLine.png"]];
    [self addSubview:lineImageView];
}

- (void)dealloc {
    [super dealloc];
    
    [_blocks release];
    _blocks = nil;
}



@end
