//
//  TPullUPRefreshController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "STableViewController.h"

@interface TPullUPRefreshController : STableViewController

@property (nonatomic,assign) int maxPage;

- (void) addItemsOnTop;
- (void) addItemsOnBottom;

@end
