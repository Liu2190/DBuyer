//
//  TAllscoGoodBlock.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoGoodBlock.h"

#define font_size   20

@implementation TAllscoGoodBlock

- (id)init {
    self = [super init];
    _num = 0;
    
    _reduceBtn = [[UIButton alloc]init];
    [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"AllscoGood_reduce.png"] forState:UIControlStateNormal];
    [self addSubview:_reduceBtn];
    
    _plusBtn = [[UIButton alloc]init];
    [_plusBtn setBackgroundImage:[UIImage imageNamed:@"AllscoGood_plus.png"] forState:UIControlStateNormal];
    [self addSubview:_plusBtn];
    
    _lineImage = [[UILabel alloc]init];
    [_lineImage setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_lineImage];
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _numberLabel.numberOfLines = 0;
    [_numberLabel setBackgroundColor:[UIColor clearColor]];
    [_numberLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_numberLabel setTextColor:[UIColor grayColor]];
    [self addSubview:_numberLabel];
    
    return self;
}

- (NSString*)numberLabelValue {
    return [NSString stringWithFormat:@"%i",_num];
}

- (void)updateNumberLabel {
    [_numberLabel setText:[self numberLabelValue]];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_numberLabel.text sizeWithFont:_numberLabel.font constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    [_numberLabel setFrame:CGRectMake((self.frame.size.width-titleSize.width)/2, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_reduceBtn setFrame:CGRectMake(0, 0, frame.size.height-3, frame.size.height-3)];
    [_plusBtn setFrame:CGRectMake(frame.size.width-_reduceBtn.frame.size.width, 0, _reduceBtn.frame.size.width, _reduceBtn.frame.size.width)];
    [_lineImage setFrame:CGRectMake(0, frame.size.height-2, frame.size.width, .5)];
    
    [self updateNumberLabel];
}

- (void)addActinForTarget:(id)target andIndex:(int)index {
    [_reduceBtn addTarget:target action:@selector(doReduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [_plusBtn addTarget:target action:@selector(doPlusAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _reduceBtn.tag = index;
    _plusBtn.tag = index;
}

- (BOOL)addOrderNum {
    _num++;
    [self updateNumberLabel];
    
    return YES;
}

- (BOOL)reduceOrderNum {
    if (_num == 0) return NO;
    
    _num--;
    [self updateNumberLabel];
    return YES;
}

@end
