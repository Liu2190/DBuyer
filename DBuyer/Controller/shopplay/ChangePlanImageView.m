//
//  ChangePlanImageView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ChangePlanImageView.h"
@interface ChangePlanImageView ()<UIScrollViewDelegate>

@property (nonatomic, assign) UIScrollView * thisScrol;

@end
@implementation ChangePlanImageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithBackImageView:(CGRect)frame{
    [self initWithFrame:frame];
    self.thisScrol=[[UIScrollView alloc]initWithFrame:CGRectMake(45,10,230,380)];
    [self addSubview:self.thisScrol];
    self.thisScrol.delegate = self;
    self.thisScrol.contentSize=CGSizeMake(frame.size.width,400);
    self.thisScrol.alwaysBounceVertical = NO;
    self.thisScrol.alwaysBounceHorizontal = YES;
    self.thisScrol.userInteractionEnabled=YES;
    self.thisScrol.backgroundColor=[UIColor  colorWithRed:178.0/255.0 green:64.0/255.0 blue:63.0/255.0 alpha:1];
    NSArray *array=[NSArray arrayWithObjects:@"冲调1",@"鸡蛋1",@"巧克力1",@"干果1",@"干货1",@"母婴1",@"水果1",@"沐浴1",@"牛奶1",@"生活1",@"白酒1",@"米面1",@"粮油1",@"红酒1",@"纸品1",@"蔬菜1",@"调料1",@"速食1",@"饮料1",@"女性1",nil];
    NSArray *titleArray=[NSArray arrayWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",nil];
    for(int i =0;i<[array count];i++){
        UIImageView *planBackImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[array objectAtIndex:i]]];
        planBackImage.frame=CGRectMake((i%4)*55+10, (i/4)*75+20, 40, 40);
        planBackImage.userInteractionEnabled=YES;
        [self.thisScrol addSubview:planBackImage];
        LXD *titleLabel=[[LXD alloc]initWithText:[titleArray objectAtIndex:i] font:12 textAlight:NSTextAlignmentCenter frame:CGRectMake((i%4)*54, (i/4)*75+55, 70, 40) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
        titleLabel.userInteractionEnabled=YES;
        [self.thisScrol addSubview:titleLabel];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=100+i;
        button.frame=CGRectMake((i%4)*54, (i/4)*75+20, 70, 70);
        button.backgroundColor=[UIColor clearColor];
        [self.thisScrol addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 45, WindowHeight-10)];
    backView1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self addSubview:backView1];
    backView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChange)];
    [backView1 addGestureRecognizer:tapGest];
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, 10)];
    backView2.userInteractionEnabled = YES;
    backView2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self addSubview:backView2];
    UITapGestureRecognizer *tapGest2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChange)];
    [backView2 addGestureRecognizer:tapGest2];
    UIView *backView3 = [[UIView alloc]initWithFrame:CGRectMake(275, 10, 45, WindowHeight-10)];
    backView3.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    backView3.userInteractionEnabled = YES;
    [self addSubview:backView3];
    UITapGestureRecognizer *tapGest3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChange)];
    [backView3 addGestureRecognizer:tapGest3];
    UIView *backView4 = [[UIView alloc]initWithFrame:CGRectMake(45, 10+380, 230, 200)];
    backView4.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    backView4.userInteractionEnabled = YES;
    [self addSubview:backView4];
    UITapGestureRecognizer *tapGest4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChange)];
    [backView4 addGestureRecognizer:tapGest4];
    return self;
}
-(void)cancelChange{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.hidden = YES;
    [UIView commitAnimations];
}
-(void)buttonClick:(id)sender{
    self.hidden = YES;
    [self.CPIdelegate iconButtonDidClick:sender];
}
@end
