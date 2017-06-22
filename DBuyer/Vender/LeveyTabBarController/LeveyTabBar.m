//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by liuxiaodan on 13/9/17.
//  Copyright liuxiaodan. All rights reserved.
//

#import "LeveyTabBar.h"
#import "AppDelegate.h"
#import "WCAlertView.h"

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
        
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			//btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
        /*    if(i==2)
            {*/
                btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
          /*  }
            else
            {
                btn.frame=CGRectMake(width * i, 23, width, frame.size.height-23);
            }*/
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
			//[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}
- (void)setCarNum:(NSString *)numFromNet{
    if ([numFromNet intValue]==0)
    {
        UIButton *button=[self.buttons objectAtIndex:3];
        for(UIView *view in [button subviews]){
            if (view.tag== 123||view.tag==124){
                [view removeFromSuperview];
            }
        }
    }
    else
    {
        UIButton *button=[self.buttons objectAtIndex:3];
        UIImageView *backImg=[[UIImageView alloc]init];
        backImg.image=[UIImage imageNamed:@"SHOPPINGCAR_NUM_PNG.png"];
        backImg.frame=CGRectMake(38, 3, 18, 17.5);
        backImg.tag=123;
        if([numFromNet intValue]>99)
        {
            numFromNet = @"99+";
        }
        LXD *label=[[LXD alloc]initWithText:numFromNet font:10 textAlight:NSTextAlignmentCenter frame:CGRectMake(1, 0, 15, 15) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
        label.tag=124;
        [backImg addSubview:label];
        [button addSubview:backImg];
    }
}
- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];
}
- (void)selectTabAtIndex:(NSInteger)index
{
  
	for (int i = 0; i < [self.buttons count]; i++)
	{
		UIButton *b = [self.buttons objectAtIndex:i];
		b.selected = NO;
	}
	UIButton *btn = [self.buttons objectAtIndex:index];
	btn.selected = YES;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
    
}
- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons)
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
