//
//  TChargeTableCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TChargeTableCell.h"
#import "TChargeBlockView.h"

#define block_num       10
#define block_width     50
#define block_height    30

@implementation TChargeTableCell

- (id)initWithFrame:(CGRect)frame andCard:(TAllScoCard*)card andSelectIndex:(int)index {
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    _blocks = [[NSMutableArray alloc]init];
    _card = card;
    
    for (int i=0; i<block_num; i++) {
        float w = frame.size.width;
        float ever_w = w/(block_num/2);
        
        int a = i;
        if (i>=5) a = a-5;
        float x = a*ever_w+(ever_w-block_width)/2;
        
        float h = frame.size.height;
        float ever_h = h/2;
        
        float y = 0;
        if (i>=5)y = ever_h;
        y += (ever_h - block_height)/2;
        
        BOOL isSelected = NO;
        if (index == i) isSelected = YES;
        
        TChargeBlockView *blockView = [[TChargeBlockView alloc]initWithFrame:CGRectMake(x, y, block_width, block_height) andIndex:i and:_card isSelectIndex:isSelected];
        
        [blockView setBackgroundColor:[UIColor whiteColor]];
        [_blocks addObject:blockView];
        [self addSubview:blockView];
    }
    
    return self;
}

- (void)addTargetForButton:(id)obj {
    for (TChargeBlockView *blockView in _blocks) {
        [blockView addTargetForButton:obj];
    }
}


@end
