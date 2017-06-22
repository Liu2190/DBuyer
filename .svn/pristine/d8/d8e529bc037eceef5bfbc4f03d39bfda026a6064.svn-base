
//
//  CollectEmptyView.m
//  DBuyer
//
//  Created by chenpeng on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CollectEmptyView.h"
#import "RecommendScrollView.h"

@interface CollectEmptyView () <RecommendScrollViewDelegate>
@property (nonatomic, assign) RecommendScrollView * recommendView;
@end

@implementation CollectEmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)collectEmptyView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CollectEmptyView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor = BACKCOLOR;
    
    // 添加水平拖动浏览视图
    self.recommendView = [[[RecommendScrollView alloc] initWithArray:self.recommendProductList title:@"更多推荐" startPoint:CGPointMake(0, 280)] autorelease];
    self.recommendView.RSdelegate = self;
    [self addSubview:self.recommendView];
}

- (void)RecommendViewDidClicked:(NSUInteger)index
{
    NSNumber * number = [NSNumber numberWithInteger:index];
    // 回调传值
    if (self.action != nil) {
        [self.target performSelector:self.action withObject:number];
    }
}

- (void)setRecommendProductList:(NSMutableArray *)recommendProductList
{
    if (_recommendProductList != recommendProductList) {
        [_recommendProductList release];
        _recommendProductList = [recommendProductList retain];
        [self.recommendView showWithProducts:_recommendProductList];
    }
}

- (void)addTarget:(id)target selectAction:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)dealloc
{
    self.recommendProductList = nil;
    [super dealloc];
}

@end
