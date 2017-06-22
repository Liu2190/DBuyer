//
//  THeaderPayView.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "THeaderPayView.h"
#import "TBlockPayAndItemView.h"

#define display_block_num   2

#define ALL_MONEY @"可用金额"
#define WILLPAY_MONEY @"预付金额"
#define NEEDPAY_MONEY @"还需支付"
#define HADCARD_NUM @"预支付卡数"

@implementation THeaderPayView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.blockViews = [[NSMutableArray alloc]init];
    float bloc_w = self.frame.size.width/display_block_num;
    
    for (int i=0; i<display_block_num; i++) {
        NSString *title = @"";
        if (i == 0) title = WILLPAY_MONEY;
        if (i==1) title = ALL_MONEY;
        // if (i == 2) title = NEEDPAY_MONEY;
        // if (i == 3) title = HADCARD_NUM;
        
        CGRect rect = CGRectMake(i*bloc_w, 0, bloc_w, self.frame.size.height);
        TBlockPayAndItemView *blockView = [[[TBlockPayAndItemView alloc]initWithFrame:rect andTitle:title]autorelease];
        [self addSubview:blockView];
        [_blockViews addObject:blockView];
    }
    
    return self;
}

- (void)setValueForBlockViews:(THeaderPayEnity*)headerPayEntity {
    for (int i=0; i<display_block_num; i++) {
        TBlockPayAndItemView *blockPayView = [_blockViews objectAtIndex:i];
        NSString *labelValue = @"";
        if (i == 0) {
            labelValue = headerPayEntity.willPayMoney;
        } else if (i == 1) {
            labelValue = headerPayEntity.allMoney;
        } else if (i == 2) {
            labelValue = headerPayEntity.needPayMoney;
        } else if (i == 3) {
            labelValue = headerPayEntity.hadPayCardNum;
        }
        
        [blockPayView setLabelValue:labelValue];
    }
}

@end
