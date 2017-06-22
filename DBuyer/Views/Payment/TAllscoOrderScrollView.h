//
//  TAllscoOrderScrollView.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAllscoOrderScrollView : UIScrollView {
    int _totalPage;
    
    NSMutableArray *_pageViews;
}

- (id)initWithFrame:(CGRect)frame andPageNum:(int)totalPage;

- (UIView*)getPageViewByPageIndex:(int)pageIndex;
- (void)scrollPageByPageNum:(int)pageIndex;

/**
 * 获得当前页号
 */
- (int)getCurrentPageNO;
@end
