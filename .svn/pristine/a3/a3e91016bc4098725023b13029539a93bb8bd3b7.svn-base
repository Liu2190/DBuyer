//
//  TSortBlockView.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TSortBlockView.h"

#define image_width_size    8
#define image_height_size   6

#define margin_size         5

#define font_size           17

@implementation TSortBlockView

- (id)initWithFrame:(CGRect)frame andDict:(NSDictionary*)dict andIndex:(int)index {
    self = [super initWithFrame:frame];
    
    NSString *text = [dict objectForKey:@"text"];
    default_imaeg = [dict objectForKey:@"defaultImage"];
    click_image = [dict objectForKey:@"clickImage"];
    
    _sortTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _sortTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _sortTextLabel.numberOfLines = 0;
    [_sortTextLabel setBackgroundColor:[UIColor clearColor]];
    [_sortTextLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_sortTextLabel setTextColor:[UIColor whiteColor]];
    [_sortTextLabel setText:text];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_sortTextLabel.text sizeWithFont:_sortTextLabel.font constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByWordWrapping];
    
    float x = (frame.size.width-titleSize.width-image_width_size-margin_size)/2;
    float y = (frame.size.height - titleSize.height)/2;
    [_sortTextLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    [self addSubview:_sortTextLabel];
    
    
    float h = image_height_size;
    if (index == 2) h += 5;
    y = (frame.size.height-h)/2;
    _deseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_sortTextLabel.frame.size.width+_sortTextLabel.frame.origin.x+5, y, image_width_size, h)];
    [_deseImageView setImage:[UIImage imageNamed:default_imaeg]];
    [self addSubview:_deseImageView];
    
    _sortBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [_sortBtn setBackgroundColor:[UIColor clearColor]];
    _sortBtn.tag = index;
    [self addSubview:_sortBtn];
    
    return self;
}

- (void)addTargetForAction:(id)obj {
    [_sortBtn addTarget:obj action:@selector(clickSortBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)updateImageViewDis:(BOOL)isClicked {
    if (isClicked) {
        [_deseImageView setImage:[UIImage imageNamed:click_image]];
        [_sortTextLabel setTextColor:[UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1]];
    } else {
        [_deseImageView setImage:[UIImage imageNamed:default_imaeg]];
        [_sortTextLabel setTextColor:[UIColor whiteColor]];
    }
}

- (void)setPriceBlockImage:(BOOL)isAsc {
    if (_sortBtn.tag == 2) {
        if (isAsc) {
            [_deseImageView setImage:[UIImage imageNamed:click_image]];
        } else {
            [_deseImageView setImage:[UIImage imageNamed:@"Image_ProductList_05.png"]];
        }
    }
}

@end
