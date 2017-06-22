//
//  TPassScrollView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPassScrollView : UIScrollView

/**
 * 滑动页数组
 */
@property (nonatomic,strong) NSMutableArray *pages;

/**
 * 通过页码跳转到对应的页
 */
- (void)goPageByIndex:(int)pageIndex;

/**
 * 通过页码获取对应的页对象
 */
- (UIView*)getPageByIndex:(int)pageIndex;

/**
 * 通过页码获取找回密码的内容页
 */
- (UIView*)getContentPageByIndex:(int)pageIndex;
@end
