//
//  ProRecommendView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProRecommendView.h"
#import "ProRecView.h"
#import "Product.h"

#define PROHEIGHT 120

@interface ProRecommendView()<UIScrollViewDelegate>
@property (nonatomic,retain)UIScrollView *scrol;
@end
@implementation ProRecommendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithArray:(NSArray *)productArray startPoint:(CGPoint)point
{
    CGRect frame = CGRectMake(point.x, point.y, 320, PROHEIGHT);
    [super initWithFrame:frame];
    [self initWithFrame:frame];
    self.userInteractionEnabled = YES;
    self.scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, 280, PROHEIGHT)];
    self.scrol.delegate = self;
    self.scrol.userInteractionEnabled = YES;
    [self addSubview:self.scrol];
    self.scrol.contentSize = CGSizeMake(93*productArray.count, PROHEIGHT);
    self.scrol.alwaysBounceHorizontal = NO;
    self.scrol.alwaysBounceVertical = NO;
    for(int i = 0;i<[productArray count];i++)
    {
        Product *product = [productArray objectAtIndex:i];
        ProRecView *proView = [[[NSBundle mainBundle]loadNibNamed:@"ProRecView" owner:self options:nil]lastObject];
        proView.userInteractionEnabled = YES;
        proView.frame = CGRectMake(93*i, 0, 90, PROHEIGHT);
        proView.tag = i;
        [proView showWithProduct:product];
        [self.scrol addSubview:proView];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [proView addGestureRecognizer:tap];
    }
    return self;
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    if(self.delegate && [self.delegate respondsToSelector:@selector(proRecommendDidClick:)])
    {
        [self.delegate proRecommendDidClick:index];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
