//
//  BannerView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BannerViewDelegate <NSObject>

@optional
// banner视图代理方法, 返回被点击的图片序号
-(void)bannerViewDidClicked:(NSUInteger)index;

@end

@interface BannerView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	UIScrollView *scrollView;
	NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    id<BannerViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
}

@property (nonatomic, assign) id<BannerViewDelegate> delegate;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, retain) NSTimer * timer;

// 设置banner视图自动浏览时间间隔
- (void)setChangeTime:(CGFloat)time;

// 初始化方法
- (id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArray TitleArray:(NSArray *)titlArray;
- (id)initWithImageArray:(NSArray *)imgArray TitleArray:(NSArray *)titlArray;
- (id)initWithImageArray:(NSArray *)imgArray;

//- (void)setImageArray:(NSArray *)imgArray;

@end
