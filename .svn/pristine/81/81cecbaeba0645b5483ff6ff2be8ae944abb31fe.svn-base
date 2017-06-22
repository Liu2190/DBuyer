//
//  TBlockPayCardView.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBlockPayCardView.h"
#import "UIView+Shadow.h"

@implementation TBlockPayCardView

- (id)initWithFrame:(CGRect)frame andCard:(TAllScoCard*)card {
    self = [super initWithFrame:frame];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, .5, frame.size.width, frame.size.height)];
    [backView makeInsetShadowWithRadius:.5f Color:[UIColor grayColor] Directions:[NSArray arrayWithObjects:@"bottom", nil]];
    [self addSubview:backView];
    
    
    return self;
}


@end
