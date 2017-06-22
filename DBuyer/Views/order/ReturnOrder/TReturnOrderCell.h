//
//  TReturnOrderCell.h
//  DBuyer
//
//  Created by dilei liu on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TReturnOrderCell : UITableViewCell {
    UILabel *_orderNum;
    UILabel *_orderStatus;
    UIImageView *_orderImageView;
    
    UILabel *_orderDescrption;
    
    UILabel *_prefixLabel;
    UILabel *_goodsNumLabel;
    UILabel *_suffixLabel;

    UILabel *_totalJLabel;
    UILabel *_totalPrice;
    UIButton *_actionBtn;
}

- (void)setTargetAction:(id)target;
- (void)setDataForCell:(id)data andIndex:(int)indexRow;

@end
