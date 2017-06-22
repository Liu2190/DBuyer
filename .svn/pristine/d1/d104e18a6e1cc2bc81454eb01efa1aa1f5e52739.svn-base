//
//  TTabBarBlock.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TTabBarBlock.h"

#define labelFont_size  16

@implementation TTabBarBlock

- (id)initWithFrame:(CGRect)frame andItemName:(NSString*)itemName andIndex:(int)index {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0]];
    
    CGRect rect  = CGRectMake(0, 0, frame.size.width, frame.size.height-1);
    _tabBarLabel = [[[UILabel alloc]initWithFrame:rect]autorelease];
    [_tabBarLabel setText:itemName];
    _tabBarLabel.font = [UIFont systemFontOfSize:labelFont_size];
    _tabBarLabel.textAlignment = NSTextAlignmentRight;
    [_tabBarLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_tabBarLabel];
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    CGSize titleSize = [_tabBarLabel.text sizeWithFont:_tabBarLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_tabBarLabel setFrame:CGRectMake((frame.size.width-titleSize.width)/2, (frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    _btn = [[UIButton alloc]initWithFrame:rect];
    _btn.tag = index;
    [self addSubview:_btn];
    
    return self;
}

- (void)updateCompentByisSelect:(BOOL)isSelect {
    if (isSelect) {
        [_tabBarLabel setTextColor:_colorSelected];
    } else {
        [_tabBarLabel setTextColor:_colorDefault];
    }
}

- (void)setActionForTarget:(id)target {
    [_btn addTarget:target action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@end
