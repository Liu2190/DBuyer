//
//  TAllscoChargeElement.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "QLabelElement.h"
#import "TAllscoCard.h"

@interface TAllscoChargeElement : QLabelElement {
    TAllScoCard *_card;
}

- (id)initwithCard:(TAllScoCard*)card;

@property (nonatomic,assign)int selectIndex;

@end
