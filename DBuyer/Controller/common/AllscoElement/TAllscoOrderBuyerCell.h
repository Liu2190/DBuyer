//
//  TAllscoOrderBuyerCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllscoGoodsForm.h"

@interface TAllscoOrderBuyerCell : UITableViewCell {
    UILabel *_faceAmtTitel;
    UILabel *_faceAmt;
    
    UILabel *_countTitle;
    UILabel *_countValue;
    
    UIImageView *_cardImageView;
    UIImageView *_lineImageView;
}

+(float)heightForCell;
- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm;

@end
