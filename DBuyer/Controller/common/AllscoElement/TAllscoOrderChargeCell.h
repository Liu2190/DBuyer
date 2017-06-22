//
//  TAllscoOrderChargeCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllScoCharge.h"

@interface TAllscoOrderChargeCell : UITableViewCell {
    UILabel *_chargeCardNoTitle;
    UILabel *_chargeCardNo;
    
    UILabel *_chargeAmtTitle;
    UILabel *_chargeAmt;
}

+(float)heightForCell;
- (void)setDataForCell:(TAllScoCharge*)chargeForm;

@end
