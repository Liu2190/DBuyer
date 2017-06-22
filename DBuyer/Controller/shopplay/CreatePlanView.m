//
//  CreatePlanView.m
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CreatePlanView.h"
#import "BtnDelegate.h"
@interface CreatePlanView()<UIScrollViewDelegate>
{
    id _target;
    SEL _action;
}
@property(nonatomic,retain)NSArray *iconArray;
@property(nonatomic,retain)NSArray *titleArray;
@property(nonatomic,retain)NSArray *whiteImageArray;

@end
@implementation CreatePlanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//}

//-(id)initWithCoder:(NSCoder *) coder{
//    
//
//return self;
//
//}
-(void)awakeFromNib
{
    _iconArray=[[NSArray alloc] initWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",@"sec_box_image.png", nil];;
    _titleArray=[[NSArray alloc] initWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",nil];
    _whiteImageArray=[[NSArray alloc]initWithObjects:@"冲调1",@"鸡蛋1",@"巧克力1",@"干果1",@"干货1",@"母婴1",@"水果1",@"沐浴1",@"牛奶1",@"生活1",@"白酒1",@"米面1",@"粮油1",@"红酒1",@"纸品1",@"蔬菜1",@"调料1",@"速食1",@"饮料1",@"女性1",nil];
}
- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
-(void)setCreatePlanViewWithIcon
{
     UIScrollView *createScrol=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, 230, 200-10)];
     createScrol.contentSize=CGSizeMake(230, 400);
     createScrol.userInteractionEnabled=YES;
     createScrol.backgroundColor=[UIColor clearColor];
    createScrol.alwaysBounceVertical = NO;
    createScrol.alwaysBounceHorizontal = YES;
    
     for(int i=0;i<[_whiteImageArray count];i++)
     {
         UIImageView *planBackImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[_whiteImageArray objectAtIndex:i]]];
         planBackImage.frame=CGRectMake((i%4)*55+10, (i/4)*75+20, 40, 40);
         [createScrol addSubview:planBackImage];
         LXD *titleLabel=[[LXD alloc]initWithText:[_titleArray objectAtIndex:i] font:12 textAlight:NSTextAlignmentCenter frame:CGRectMake((i%4)*54, (i/4)*75+55, 70, 40) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
         [createScrol addSubview:titleLabel];
         UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
         button.frame=CGRectMake((i%4)*55+10, (i/4)*75+20, 40, 70);
         button.tag=i;
         [button addTarget:self action:@selector(btnClickOfCreatePlan:) forControlEvents:UIControlEventTouchUpInside];
         [createScrol addSubview:button];
     }
     [self.createBackImage addSubview:createScrol];
     self.createBackImage.userInteractionEnabled=YES;
     for(UIView * view in [[self.createBackImage superview] subviews])
     {
         view.userInteractionEnabled=YES;
     }
}
-(void)btnClickOfCreatePlan:(UIButton *)button
{
    self.planImage.image=[UIImage imageNamed:[_iconArray objectAtIndex:button.tag]];
    self.createTf.text=[_titleArray objectAtIndex:button.tag];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.createBackImage.hidden=YES;
    [UIView commitAnimations];
}
-(void)setCreatePlanViewVisible
{
    self.hidden=NO;
    self.createBackImage.hidden=YES;
    self.planImage.image=[UIImage imageNamed:@"sec_box_image.png"];
    self.createTf.text=@"";
}

- (IBAction)makeScrolVisible:(id)sender
{
    if(self.createBackImage.hidden==NO )
    {
        return;
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        self.createBackImage.hidden=NO;
        [UIView commitAnimations];
    }
    [_target performSelector:_action];
}
-(void)backViewVisibleAction:(id)sender AndAction:(SEL)visibleAction
{
    _target = sender;
    _action = visibleAction;
}
@end
