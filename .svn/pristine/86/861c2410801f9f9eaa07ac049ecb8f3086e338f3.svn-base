//
//  TAllscoOrderCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderCell.h"

#define cell_top_sep    10

@implementation TAllscoOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor clearColor]];
    
    float bgh = [TAllscoOrderCell heightForCell]-cell_top_sep;
    _bgView = [[TAllscoOrderContent alloc]
                                   initWithFrame:CGRectMake(0, cell_top_sep, self.frame.size.width, bgh)];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_bgView];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0].CGColor;
    sublayer.frame = CGRectMake(0, cell_top_sep, self.frame.size.width, bgh);
    [backgroundView.layer addSublayer:sublayer];
    
    self.selectedBackgroundView = backgroundView;
    
    return self;
}

- (void)setDataForCell:(TAllscoOrderForm*)allscoOrderForm {
    [_bgView setDataForView:allscoOrderForm];
}

+ (float)heightForCell {
    return 150.f;
}

@end
