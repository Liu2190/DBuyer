//
//  BannerView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

@synthesize delegate;

- (void)dealloc {
	[scrollView release];
    [noteTitle release];
    self.timer = nil;
	delegate=nil;
    if (pageControl) {
        [pageControl release];
    }
    if (imageArray) {
        [imageArray release];
        imageArray=nil;
    }
    if (titleArray) {
        [titleArray release];
        titleArray=nil;
    }
    [super dealloc];
}

- (void)setChangeTime:(CGFloat)time
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}

- (id)initWithImageArray:(NSArray *)imgArray TitleArray:(NSArray *)titlArray
{
    return [self initWithFrameRect:CGRectMake(0, 0, 320, 180) ImageArray:imgArray TitleArray:titlArray];
}
- (id)initWithImageArray:(NSArray *)imgArray
{
    return [self initWithImageArray:imgArray TitleArray:nil];
}
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
    currentPageIndex = 1;
    self.time = 10;//设置轮播图速度
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
	if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        titleArray=[titArr retain];
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
        if([tempArray count]>0)
        {
            [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
            [tempArray addObject:[imgArr objectAtIndex:0]];
            imageArray=[[NSArray arrayWithArray:tempArray] retain];
            viewSize=rect;
            NSUInteger pageCount=[imageArray count];
            scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
            scrollView.pagingEnabled = YES;
            scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.scrollsToTop = NO;
            scrollView.delegate = self;
            for (int i=0; i<pageCount; i++) {
                NSString *imgURL=[imageArray objectAtIndex:i];
                UIImageView *imgView=[[[UIImageView alloc] init] autorelease];
                if ([imgURL hasPrefix:@"http://"]) {
                    //网络图片 请使用ego异步图片库
                    [imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"placeHolerImageBanner"]];
                }
                else
                {
                    UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                    [imgView setImage:img];
                }
                
                [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
                imgView.tag=i;
                UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
                [Tap setNumberOfTapsRequired:1];
                [Tap setNumberOfTouchesRequired:1];
                imgView.userInteractionEnabled=YES;
                [imgView addGestureRecognizer:Tap];
                [scrollView addSubview:imgView];
            }
            [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
            [self addSubview:scrollView];
            
            //说明文字层
            UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
            [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.0]];
            
            float pageControlWidth=(pageCount-2)*10.0f+40.f;
            float pagecontrolHeight=20.0f;
            pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth) * 0.5, 6,  pageControlWidth, pagecontrolHeight)];
            pageControl.currentPage=0;
            pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:97/255.0 blue:76/255.0 alpha:1];
            pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            pageControl.numberOfPages=(pageCount-2);
            [noteView addSubview:pageControl];
            noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
            [noteTitle setText:[titleArray objectAtIndex:0]];
            [noteTitle setBackgroundColor:[UIColor clearColor]];
            [noteTitle setFont:[UIFont systemFontOfSize:13]];
            [noteView addSubview:noteTitle];
            [self addSubview:noteView];
            [noteView release];
            pageControl.hidden = imgArr.count==1?YES:NO;
            scrollView.scrollEnabled = !pageControl.hidden;
            if(imgArr.count == 1)
            {
                [self.timer invalidate];
            }
        }
        else
        {
            UIImageView *imagaView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"placeHolerImageBanner"]];
            imagaView.frame = CGRectMake(0, 0, WindowWidth, 180);
            self.userInteractionEnabled = NO;
            [self addSubview:imagaView];
            [self.timer invalidate];
        }
    }
    	return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    int titleIndex=page-1;
    if (titleIndex==[titleArray count]) {
        titleIndex=0;
    }
    if (titleIndex<0) {
        titleIndex=[titleArray count]-1;
    }
    [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    pageControl.currentPage=currentPageIndex - 1;
    if (currentPageIndex==0) {
        pageControl.currentPage = [imageArray count] - 2;
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        pageControl.currentPage = 0;
    }
    [self.timer invalidate];
    self.time = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)_scrollView
{
    pageControl.currentPage=currentPageIndex - 1;
    if (currentPageIndex==0) {
        pageControl.currentPage = [imageArray count] - 2;
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        pageControl.currentPage = 0;
    }
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(bannerViewDidClicked:)]) {
        [delegate bannerViewDidClicked:sender.view.tag - 1];
    }
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = currentPageIndex; // 获取当前的page
    page++;
    [scrollView scrollRectToVisible:CGRectMake(320*page,0,320,180) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
    if (currentPageIndex==([imageArray count]-1)) {
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        pageControl.currentPage = 0;
    }
}
@end
