//
//  LoadView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "LoadView.h"


@interface LoadView ()

@property (nonatomic, assign) UIImageView * car;

@end
@implementation LoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)dealloc
{
    self.car = nil;
    [super dealloc];
}
+ (id)loadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToStop)];
    [self.xImageView addGestureRecognizer:tap];
    self.xImageView.userInteractionEnabled = YES;
    
    self.car = [[UIImageView alloc] initWithFrame:CGRectMake(142, 264, 40, 30)];
    self.car.image = [UIImage imageNamed:@"Image_load_02"];
    [self addSubview:self.car];
    
    LXD *tishi=[[LXD alloc]initWithText:@"努力加载中.....请稍等" font:14 textAlight:NSTextAlignmentLeft frame:CGRectMake(100, 314, 140, 30) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
    [self addSubview:tishi];
   // tishi.center=self.center;
    self.car.center = self.center;
}

-(void)tapToStop
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pleaseCancelLoad" object:nil];
}

-(void)setBeStop:(BOOL)isStop
{
    if (isStop) {
        [UIView beginAnimations:@"loadView" context:nil];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.car.center = self.center;
        [UIView commitAnimations];
        self.hidden = YES;
    } else {
        CGPoint center = self.car.center;
        center.x -= 10;
        self.car.center = center;
        center.x += 20;
        [UIView beginAnimations:@"loadView" context:nil];
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:100000];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.car.center = center;
        [UIView commitAnimations];
        self.hidden = NO;
    }
}


@end
