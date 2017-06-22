//
//  GuideOperationView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "GuideOperationView.h"
@interface GuideOperationView()<UIScrollViewDelegate>
@property (nonatomic,retain)UIScrollView *scrolView;
@property (nonatomic,retain)NSMutableArray *imageArray;
@end
@implementation GuideOperationView

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
-(id)initGuideOperationViewWith:(NSMutableArray *)imageArray
{
    if ((self=[super initWithFrame:[[UIScreen mainScreen] bounds]]))
    {
        float Lheight = [[UIScreen mainScreen] bounds].size.height;
        self.imageArray = [[NSMutableArray alloc]initWithArray:imageArray];
        self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, Lheight)];
        self.scrolView.delegate = self;
        self.scrolView.userInteractionEnabled = YES;
        self.scrolView.multipleTouchEnabled = YES;
        [self.scrolView setContentSize:CGSizeMake(WindowWidth*[imageArray count], Lheight)];
        self.scrolView.alwaysBounceVertical=NO;
        self.scrolView.alwaysBounceHorizontal=NO;
        [self.scrolView setPagingEnabled:YES];  //视图整页显示
        [self.scrolView setBounces:NO];
        [self addSubview:self.scrolView];
        for(int i = 0 ; i <[imageArray count]; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake(WindowWidth*i, 0, WindowWidth, Lheight);
            imageView.tag = i+1;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
            [self.scrolView addSubview:imageView];
        }
 
    }
    return self;
}
-(void)tap:(UITapGestureRecognizer *)sender
{
    UIImageView *imageView = (UIImageView *)sender.view;
    if(imageView.tag < self.imageArray.count)
    {
        [self.scrolView setContentOffset:CGPointMake(WindowWidth*imageView.tag, 0)];
    }
    else
    {
        self.hidden = YES;
        [self.delegate guideOperationDidClick];
    }
}
@end
