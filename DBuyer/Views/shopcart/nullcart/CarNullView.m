//
//  CarNullView.m
//  DBuyer
//
//  Created by lixinda on 13-11-16.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "CarNullView.h"
//#import "ScbjViewController.h"
#import "BargainGoodsViewController.h"

@implementation CarNullView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=BACKCOLOR;
        UIImageView *img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_06"]];
        img1.frame=CGRectMake(0, 0, 320, 54);
        [self addSubview:img1];
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame=CGRectMake(10, 6, 51, 30);
//        [btn setImage:[UIImage imageNamed:@"切片绿_向左"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"切片绿_向左1"] forState:UIControlStateHighlighted];
//        [self addSubview:btn];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        LXD *tlabel=[[LXD alloc]initWithText:@"购物车" font:16 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 12, 320, 21) backColor:[UIColor clearColor]textColor:TITLECOLOR];
        [self addSubview:tlabel];
        UIImageView * img12=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"空购物车"]];
        img12.frame=CGRectMake(165/2, 205/2, 272/2, 182/2);
        [self addSubview:img12];
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(220/2, 432/2, 250/2, 10)];
        lable1.backgroundColor=[UIColor clearColor];
        lable1.text=@"您的购物车还没有商品哦！";
        lable1.textColor=[UIColor colorWithRed:139.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1];
        UIImageView *img2=[[UIImageView alloc]initWithFrame:CGRectMake(178/2, 426/2, 18, 18)];
        img2.image=[UIImage imageNamed:@"表情"];
        [self addSubview:img2];
        lable1.frame=CGRectMake(220/2, 432/2, 250/2, 10);
        lable1.font=[UIFont systemFontOfSize:10];
        [self addSubview:lable1];
        
        self.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:237.0/255.0 blue:236.0/255.0 alpha:1];
        
        
        
        [self tuijian];
        
        [self wodeshoucang];

        
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

-(void) btnClick:(UIButton *)button{
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)tuijian{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(186/2, 520/2, 282/2, 72/2);
    [self addSubview:button];
    button.tag = 20001;
    [button setImage:[UIImage imageNamed:@"切片_89"] forState:UIControlStateNormal] ;
    [button setImage:[UIImage imageNamed:@"切片_94"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"推荐商品"]];
    im.frame=CGRectMake(60/2, 18/2, 16, 16);
    [button addSubview:im];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(110/2, 20/2, 100/2, 24/2)];
    l.text=@"推荐商品";
    l.font=[UIFont systemFontOfSize:12];
    l.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
    [button addSubview:l];
    l.backgroundColor=[UIColor clearColor];
    
    
    
}
-(void)wodeshoucang{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(186/2, 520/2+94/2, 282/2, 72/2);
    [self addSubview:button];
    button.tag = 20002;
    [button setImage:[UIImage imageNamed:@"切片_89"] forState:UIControlStateNormal] ;
    [button setImage:[UIImage imageNamed:@"切片_94"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"喜欢"]];
    im.frame=CGRectMake(60/2, 18/2, 16, 16);
    [button addSubview:im];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(110/2, 20/2, 100/2, 24/2)];
    l.text=@"收藏商品";
    l.font=[UIFont systemFontOfSize:12];
    l.textColor=[UIColor colorWithRed:238.0/255.0 green:163.0/255.0 blue:7.0/255.0 alpha:1];
    [button addSubview:l];
    l.backgroundColor=[UIColor clearColor];
    
    
    
}
-(void)button1Click:(UIButton *)button{
    button.highlighted=YES;
    switch (button.tag) {
        case 20002:
        {
            //跳转到收藏页
            [self.delegate pushToScbjViewController];
        }
            break;
        case 20001:
        {
            //跳转到推荐页
            [self.delegate pushToTejiaViewController];
        }
            break;
        default:
            break;
    }
}


@end
