//
//  HeaderView.m
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
{
    NSInteger _section;
}
@end;
@implementation HeaderView

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
- (void)dealloc {
    [_timeLabel release];
    [_planNameLabel release];
    [_planDirectionImage release];
    [_planSeparateImage release];
    [_planIconImage release];
    [_planChangeButton release];
    [_planFinishedImage release];
    [_countLabel release];
    [_countRedImage release];
    [_cuxButton release];
    [_planDisc_image release];
    [super dealloc];
}
- (IBAction)cuxButonDidClick:(id)sender {
    [self.delegate cuxButtonClick:_section];
}

- (IBAction)btnClick:(id)sender {
    [self.delegate buttonOnCellDidClick:sender];
}

-(void)setHeaderViewValue:(PlanModal *)plan WithSection:(NSInteger)section
{
    _section = section;
    if(section==0)
    {
        self.planSeparateImage.hidden = YES;
    }
    else
    {
        self.planSeparateImage.hidden = NO;
    }
    NSArray *imageIconArray=[[NSArray alloc] initWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",@"sec_box_image.png", nil];
    NSArray *turnArray = [[NSArray alloc] initWithObjects:@"310",@"501",@"318",@"204",@"701",@"0206",@"323",@"0105",@"905",@"802",@"405",@"703",@"704",@"407",@"806",@"604",@"503",@"601",@"404",@"0103", nil];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    if(!(plan.planname==nil||plan.planname ==NULL) &&(![plan.planname isKindOfClass:[NSNull class]]) && (![[plan.planname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
    {
        self.planNameLabel.text = plan.planname;
    }
    if(!(plan.remindtime==nil||plan.remindtime ==NULL) &&(![plan.remindtime isKindOfClass:[NSNull class]]) && (![[plan.remindtime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
    {
        self.timeLabel.text=plan.remindtime;
    }
    if([plan.type intValue]==1)
    {
        NSString *turnString = [NSString stringWithFormat:@"%@",plan.imageid];
        NSInteger index;
        if([turnArray containsObject:turnString]==YES)
        {
            index = [turnArray indexOfObject:turnString];
        }
        else
        {
            index = 20;
        }
        if(index < imageIconArray.count){
            self.planIconImage.image=[UIImage imageNamed:[imageIconArray objectAtIndex:index]];
            
        }
    }
    if([plan.type intValue]==2)
    {
        if(!(plan.urlimage==nil||plan.urlimage ==NULL) &&(![plan.urlimage isKindOfClass:[NSNull class]]) && (![[plan.urlimage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
        {
            UIImage *ima=[[UIImage alloc]initWithContentsOfFile:plan.urlimage];
            if(ima!=nil)
            {
                self.planIconImage.image=ima;
            }
            else
            {
                [self.planIconImage setImageWithURL:[NSURL URLWithString:plan.urlimage]];
            }
        }
    }
    if([plan.status intValue]==0)
    {//未完成计划
        self.planFinishedImage.hidden=YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(280, 0, 40, 63);
        if (!plan.isOpen)
        {//收起
            self.planNameLabel.enabled=NO;
            self.planChangeButton.userInteractionEnabled=NO;
            self.planDirectionImage.image=[UIImage imageNamed:@"sec_spread_image"];
        }
        else
        {//展开
            self.planNameLabel.enabled=YES;
            self.planChangeButton.userInteractionEnabled=YES;
            self.planDirectionImage.image = nil;
            self.planDirectionImage.image=[UIImage imageNamed:@"sec_retract_image.png"];
        }
        button.tag = section;
        [button addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.userInteractionEnabled=YES;
    }
    else
    {   //已完成计划
        self.planFinishedImage.hidden=NO;
        self.planNameLabel.enabled=NO;
        self.planChangeButton.userInteractionEnabled=NO;
        self.planDirectionImage.image = nil;
        self.planDirectionImage.image = [UIImage imageNamed:@"sec_finishedplan_image"];
        self.planDirectionImage.frame=CGRectMake(290, 26, 18, 18);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(280, 0, 40, 63);
        button.tag = section;
        [button addTarget:self action:@selector(deletePlan:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.userInteractionEnabled=YES;
    }
    if(!(plan.cuxCount==nil||plan.cuxCount ==NULL) &&(![plan.cuxCount isKindOfClass:[NSNull class]]) && (![[plan.cuxCount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
    {
        if([plan.cuxCount intValue]==0)
        {
            self.countLabel.hidden = YES;
            self.countRedImage.hidden = YES;
            self.cuxButton.userInteractionEnabled = NO;
            self.cuxButton.hidden = YES;
            self.planDisc_image.hidden = YES;
        }
        else
        {
            if([plan.cuxCount intValue] <= 99)
            {
                self.countLabel.text = plan.cuxCount;
            }
            else
            {
                self.countLabel.text = @"99+";
            }
            self.countRedImage.hidden = NO;
            self.cuxButton.userInteractionEnabled = YES;
            self.planDisc_image.hidden = NO;
        }
    }
    else
    {
        self.countLabel.hidden = YES;
        self.countRedImage.hidden = YES;
        self.cuxButton.userInteractionEnabled = NO;
        self.cuxButton.hidden = YES;
        self.planDisc_image.hidden = YES;
    }
}

-(void)deletePlan:(UIButton *)button
{
    [self.delegate deletePlanOfFinished:button];
}
-(void)rightButtonPressed:(UIButton *)button
{
    [self.delegate headerPressed:button];
}
@end
