//
//  TChargeTableCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "QTableViewCell.h"
#import "TAllScoCard.h"

@interface TChargeTableCell : QTableViewCell {
    NSMutableArray *_blocks;
    TAllScoCard *_card;
}

- (id)initWithFrame:(CGRect)frame andCard:(TAllScoCard*)card andSelectIndex:(int)index;
- (void)addTargetForButton:(id)obj;
@end
