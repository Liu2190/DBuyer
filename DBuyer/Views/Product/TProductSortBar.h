//
//  TProductSortBar.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TProductSortBar : UIView

@property (nonatomic,retain)NSMutableArray *blocks;

- (void)addTargetForAction:(id)obj;

- (void)updateImageDis:(int)sortType;

- (void)setPriceBlockImage:(BOOL)isAsc;
@end
