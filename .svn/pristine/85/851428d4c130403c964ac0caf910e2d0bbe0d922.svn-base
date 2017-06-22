//
//  TPassScrollView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPassScrollView.h"

#define pageNum 3


@implementation TPassScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.contentSize = CGSizeMake(pageNum*frame.size.width, frame.size.height);
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.bounces = NO;
    self.pagingEnabled = YES;
    
    self.pages = [[NSMutableArray alloc]init];
    
    for (int i=0; i<pageNum; i++) {
        float x = i*self.frame.size.width;
        UIScrollView *pageView = [[UIScrollView alloc]initWithFrame:CGRectMake(x, 0, self.frame.size.width, self.frame.size.height)];
        [pageView setContentSize:CGSizeMake(pageView.frame.size.width, pageView.frame.size.height+1)];
        [pageView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
        [self addSubview:pageView];
        
        [_pages addObject:pageView];
    }
    
    return self;
}
- (void)goPageByIndex:(int)pageIndex {
    if (pageIndex > (pageNum-1)) return;
    float x = pageIndex*self.frame.size.width;
    
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (UIView*)getPageByIndex:(int)pageIndex {
    UIView *view = [_pages objectAtIndex:pageIndex];
    
    return view;
}

- (UIView*)getContentPageByIndex:(int)pageIndex {
    UIView *pageView = [self getPageByIndex:pageIndex];
    return [pageView.subviews objectAtIndex:0];
}


- (void)dealloc {
    [super dealloc];
    
    [_pages release];
    _pages = nil;
}

@end
