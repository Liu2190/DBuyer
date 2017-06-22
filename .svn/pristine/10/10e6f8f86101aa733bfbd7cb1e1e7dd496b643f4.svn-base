//
//  TAllscoGoodCell.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAllscoGoodsForm.h"
#import "TAllscoGoodBlock.h"

@interface TAllscoGoodCell : UITableViewCell {
    /**
     * 卡图
     */
    UIImageView *_imageView;
    
    /**
     * 标题
     */
    UILabel *_titleDesc;
    
    /**
     * 标题
     */
    UILabel *_allscoDesc;
    
    
    /**
     * 卡成本
     */
    UILabel *_cardCost;
    
    /**
     * 售价
     */
    UILabel *_sellPrice;
    
    /**
     * 操作区域
     */
    TAllscoGoodBlock *blockView;
}

+ (float)heightForCell;

- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm andTarget:(id)target andIndex:(int)index;

- (BOOL)addOrderNum;
- (BOOL)reduceOrderNum;

@end
