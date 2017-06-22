//
//  TAllscoGoodsForm.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-30.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TAllscoGoodsForm : TRecord

@property (nonatomic,retain)NSString *allscoImageUrl;

@property (nonatomic,retain)NSString *allscoTitle;
@property (nonatomic,retain)NSString *allscodesc;

@property (nonatomic,retain)NSString *cardCost;
@property (nonatomic,retain)NSString *sellPrice;

@property (nonatomic,assign)int sellNumber;

- (NSString*)getTotalMoney;

@end
