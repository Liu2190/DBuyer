//
//  ProToCartButton.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-22.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProToCartButton.h"

@implementation ProToCartButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)awakeFromNib
{
    self.redImageView.userInteractionEnabled = YES;
    self.cartImageView.userInteractionEnabled = YES;
    self.numLabel.userInteractionEnabled = YES;
}
- (void)dealloc {
    [_cartImageView release];
    [_redImageView release];
    [_numLabel release];
    [super dealloc];
}

-(void)setShoppingCartNumWith:(NSInteger)num
{
    self.redImageView.hidden = num == 0?YES:NO;
    self.numLabel.hidden = num == 0?YES:NO;
    if(num<=99)
    {
        NSString *numString = [NSString stringWithFormat:@"%d",num];
        self.numLabel.text = numString;
    }
    else
    {
        self.numLabel.text = @"99+";
    }
}
@end
