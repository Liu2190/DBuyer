//
//  RecommendScrollView.h
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

// 有标题视图高度
#define Height1  155
// 无标题
#define Height2  125


@protocol RecommendScrollViewDelegate <NSObject>

@optional
// banner视图代理方法, 返回被点击的图片序号
-(void)RecommendViewDidClicked:(NSUInteger)index;

@end


@interface RecommendScrollView : UIView <UIScrollViewDelegate> {
    BOOL _haveTitle;
}


@property(nonatomic, assign)id <RecommendScrollViewDelegate> RSdelegate;

// 有标题的滚动视图
// 商品数组， 滚动视图标题， 滚动视图起始坐标
- (id)initWithArray:(NSArray *)productArray title:(NSString *)title startPoint:(CGPoint)point;
// 无标题滚动视图
- (id)initWithArray:(NSArray *)productArray startPoint:(CGPoint)point;
// 设置显示数据
- (void)showWithProducts:(NSArray *)productArray;

// 视图高度
- (CGFloat)heightOfRecommendView;
@end

