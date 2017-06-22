//
//  TAllScoListFormController.h
//  DBuyer
//
//  Created by dilei liu on 14-4-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "QuickDialog.h"
#import "TAllScoCard.h"

@class TAllScoListController;

@interface TAllScoListFormController : QuickDialogController



@property (nonatomic,retain) TAllScoListController *allscoListController;

/**
 * 添加数据源
 */
- (void)addDataSources:(NSArray*)datas;

/**
 * 删除所有Section
 */
- (void)removeAllSection;

/**
 * 设置footer信息
 */
- (void)setUsageForBtnSectionFooter:(NSString*)usageText;

@end
