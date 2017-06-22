//
//  TChargeBlockView.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllScoCard.h"

@interface TChargeBlockView : UIView {
    UIButton *_chargeButton;
    UILabel *_chargeLabel;
    
    TAllScoCard *_card;
}

- (id)initWithFrame:(CGRect)frame andIndex:(int)index and:(TAllScoCard*)card isSelectIndex:(BOOL)selected;
- (void)addTargetForButton:(id)obj;

@end
