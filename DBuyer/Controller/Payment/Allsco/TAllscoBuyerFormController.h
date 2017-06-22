//
//  TAllscoBuyerFormController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "QuickDialogController.h"
#import "TAllscoGoodsForm.h"
#import "TAllscoBuyerDelegate.h"

@interface TAllscoBuyerFormController : QuickDialogController

@property (nonatomic,retain)NSArray *goodItems;
@property (nonatomic,assign)id<TAllscoBuyerDelegate> delObj;

- (id)initWithAllscoGoodsForm:(NSArray*)goodItems andDelegate:(id)delObj;
@end
