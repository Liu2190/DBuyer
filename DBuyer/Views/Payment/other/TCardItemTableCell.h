//
//  TCardItemTableCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllScoCard.h"
#import "THeaderPayEnity.h"

@interface TCardItemTableCell : UITableViewCell {
    UILabel *_cardNumLabel;
    UILabel *_residualMoneyLabel;
    
    UIButton *_checkBoxBtn;
    
    UILabel *_payMoneyLabel;    // 支付金额Label
    UILabel *_payResidualLabel; // 支付余额Label
}
+ (float)heightForCell;

- (void)setTargetForAction:(id)obj;
- (void)setDataForCell:(TAllScoCard*)card andHeaderPayInfo:(THeaderPayEnity*)payEnity andIndex:(int)index;



@end
