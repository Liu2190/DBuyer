//
//  TBlockPayAndItemView.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBlockPayAndItemView.h"

#define label_title_fontSize    13
#define label_value_fontSize    13


@implementation TBlockPayAndItemView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title {
    self = [super initWithFrame:frame];
    float h = frame.size.height/2;
    
    UILabel *titleLabel = [[[UILabel alloc]init]autorelease];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:label_title_fontSize]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:title];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByWordWrapping];
    float y = (h - titleSize.height)/2;
    float x = (frame.size.width - titleSize.width)/2;
    [titleLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    [self addSubview:titleLabel];
    
    _valueLabel = [[[UILabel alloc]init]autorelease];
    _valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _valueLabel.numberOfLines = 0;
    [_valueLabel setBackgroundColor:[UIColor clearColor]];
    [_valueLabel setFont:[UIFont boldSystemFontOfSize:label_value_fontSize]];
    [_valueLabel setTextColor:[UIColor whiteColor]];
    y = h+(h - titleSize.height)/2;
    [_valueLabel setFrame:CGRectMake(0, y, 0, 0)];
    [self addSubview:_valueLabel];
    
    UIImageView *line_v = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-.5, 0, 0.5, frame.size.height)];
    [line_v setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:line_v];
    
    y = h-.5/2;
    UIImageView *line_h = [[UIImageView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, y, titleSize.width, .5)];
    [line_h setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:line_h];
    
    return self;
}

- (void)setLabelValue:(NSString*)labelValue {
    [_valueLabel setText:labelValue];

    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_valueLabel.text sizeWithFont:_valueLabel.font constrainedToSize:maximumLabelSize
                                 lineBreakMode:NSLineBreakByWordWrapping];
    float x = (self.frame.size.width - titleSize.width)/2;
    [_valueLabel setFrame:CGRectMake(x, _valueLabel.frame.origin.y, titleSize.width, titleSize.height)];
}

@end
