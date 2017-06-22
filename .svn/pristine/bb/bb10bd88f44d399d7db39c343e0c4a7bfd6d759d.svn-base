//
//  TReturnOrderDetailTop.m
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderDetailTop.h"

#define title_size_h    40

#define other_label_size    15

@implementation TReturnOrderDetailTop

- (id)initWithFrame:(CGRect)frame andOrder:(TOrder*)order {
    self = [super initWithFrame:frame];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, title_size_h)];
    [self addSubview:titleView];
    
    UILabel *orderTitle = [[UILabel alloc]init];
    [orderTitle setText:@"订单详情:"];
    orderTitle.font = [UIFont systemFontOfSize:12];
    CGSize maximumLabelSize = CGSizeMake(150, 999);
    CGSize titleSize = [orderTitle.text sizeWithFont:orderTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    float x = 10;
    float y = (titleView.frame.size.height-titleSize.height)/2;
    [orderTitle setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    [orderTitle setBackgroundColor:[UIColor clearColor]];
    [orderTitle setTextColor:[UIColor blackColor]];
    [titleView addSubview:orderTitle];
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, titleView.frame.size.height-.5, titleView.frame.size.width, .5)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [titleView addSubview:lineView];
    
    y += titleView.frame.origin.y+titleView.frame.size.height+1+10;
    
    //
    UILabel *shrLabel = [[UILabel alloc]init];
    NSString *shrValue = [NSString stringWithFormat:@"收货人:%@",@"王五"];
    [shrLabel setText:shrValue];
    shrLabel.font = [UIFont systemFontOfSize:12];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [orderTitle.text sizeWithFont:orderTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [shrLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    [shrLabel setBackgroundColor:[UIColor clearColor]];
    [shrLabel setTextColor:[UIColor blackColor]];
    [self addSubview:shrLabel];
    
    return self;
}


@end
