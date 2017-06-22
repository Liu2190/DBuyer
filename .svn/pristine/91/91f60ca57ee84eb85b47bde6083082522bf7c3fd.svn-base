//
//  TAllscoBuyerController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TAllscoBuyerFormController.h"
#import "TAllscoGoodsForm.h"
#import "TAllscoBuyerDelegate.h"
#import "UPOMP.h"
#import "KQPayOrder.h"
#import "TAllscoGoodPayForm.h"

@interface TAllscoBuyerController : TRootViewController<TAllscoBuyerDelegate,UPOMPDelegate> {
    TAllscoBuyerFormController *_buyerFormController;
    KQPayOrder *kQPayOrder;
    NSString *kqOrderString;
    
    TAllscoGoodPayForm *_payFormObj;
}

@property (nonatomic,retain)TAllscoGoodsForm *goodsForm;
@property (nonatomic,retain)NSArray *goodItems;

- (id)initWithNavigationTitle:(NSString *)title andGoodsForm:(NSArray*)goodItems;

@end
