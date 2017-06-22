//
//  TBuyerTableCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-30.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllscoGoodsForm.h"

@interface TBuyerTableCell : UITableViewCell {
    UIImageView *_cardImageView;
    UILabel *_cardTitleLabel;
    UILabel *_moneyLabel;
    UILabel *_numberLabel;
    UILabel *_subTotalLabel;
    
    UIImageView *_lineImageView;
}

+ (float)heightForCell;
- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm;

@end
