//
//  ProductListTopView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProductListTopView.h"

@implementation ProductListTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    self.xinpin.tag = 0;
    self.xiaoliang.tag = 1;
    self.jiage.tag = 2;
    self.xinpin.userInteractionEnabled = YES;
    self.xiaoliang.userInteractionEnabled = YES;
    self.jiage.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.xinpin addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.xiaoliang addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.jiage addGestureRecognizer:tap3];
}
-(void)tapAction:(UITapGestureRecognizer *)sender
{
    int index = sender.view.tag;
    if(self.delegate && [self.delegate respondsToSelector:@selector(productListTopViewDidClick:)])
    {
        [self.delegate productListTopViewDidClick:index];
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
-(void)setButtonImageWith:(int)num And:(BOOL)priceStatus
{
    if(num == 0)
    {
        self.xinpin.image = [UIImage imageNamed:@"prolistxinHigh"];
        self.xiaoliang.image = [UIImage imageNamed:@"prolistxiao"];
        self.jiage.image = [UIImage imageNamed:@"prolistjia"];
    }
    if(num == 1)
    {
        self.xinpin.image = [UIImage imageNamed:@"prolistxin"];
        self.xiaoliang.image = [UIImage imageNamed:@"prolistxiaoHigh"];
        self.jiage.image = [UIImage imageNamed:@"prolistjia"];
    }
    if(num == 2)
    {
        self.xinpin.image = [UIImage imageNamed:@"prolistxin"];
        self.xiaoliang.image = [UIImage imageNamed:@"prolistxiao"];
        if(priceStatus == YES)
        {
            
            self.jiage.image = [UIImage imageNamed:@"prolistjiaAsc"];
        }
        else
        {
            self.jiage.image = [UIImage imageNamed:@"prolistjiaDesc"];
        }
    }
}
- (void)dealloc {
    [_xinpin release];
    [_xiaoliang release];
    [_jiage release];
    [super dealloc];
}
@end
