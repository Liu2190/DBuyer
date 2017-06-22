//
//  ShoppingCartEmptyView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-4.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShoppingCartEmptyView.h"

@interface ShoppingCartEmptyView ()

@property (nonatomic, assign) id target;
@property (nonatomic) SEL recommendAction;
@property (nonatomic) SEL collectionAction;

@end

@implementation ShoppingCartEmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)shoppingCartEmptyView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartEmptyView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    // 设置背景颜色
    self.backgroundColor = BACKCOLOR;
    float startPoint = 0.0;
    
    CGRect frame = self.frame;
    frame.origin.y = startPoint;
    self.frame = frame;
}

- (void)addTarget:(id)target recommendAction:(SEL)recommendAction collectionAction:(SEL)collectionAction
{
    self.target = target;
    self.recommendAction = recommendAction;
    self.collectionAction = collectionAction;
}


- (IBAction)recommendButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.recommendAction withObject:self];
}

- (IBAction)collectionButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.collectionAction withObject:self];
}

@end
