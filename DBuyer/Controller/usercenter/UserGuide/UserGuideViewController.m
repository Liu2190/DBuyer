//
//  UserGuideViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "UserGuideViewController.h"
#import "LeveyTabBarController.h"
#import "PlanViewController.h"
#import "ThirdViewController.h"
#import "ShoppingCartViewController.h"
#import "LeveyTabBar.h"
#import "HomeViewController.h"
#import "TUserCenterController.h"
@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor clearColor];
    [self initGuide];
}
-(void)initGuide{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    scrollView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1];
    [scrollView setContentSize:CGSizeMake(320*3, WindowHeight)];
    scrollView.alwaysBounceVertical=NO;
    [scrollView setPagingEnabled:YES];  //视图整页显示
    [self.view addSubview:scrollView];
    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    if(WindowHeight==568){
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, WindowHeight)];
    imageview.image=[UIImage imageNamed:@"界面引导-09.jpg"];
    [scrollView addSubview:imageview];
    
     UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, WindowHeight)];
    [imageview1 setImage:[UIImage imageNamed:@"界面引导-07.jpg"]];
    [scrollView addSubview:imageview1];

    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, WindowHeight)];
    [imageview2 setImage:[UIImage imageNamed:@"界面引导-08.jpg"]];
    [scrollView addSubview:imageview2];
    
   
    imageview2.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:nil forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview2 addSubview:button];
       }
    else{
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, WindowHeight)];
        imageview.image=[UIImage imageNamed:@"iphone4s-1.jpg"];
        [scrollView addSubview:imageview];
        
        UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, WindowHeight)];
        [imageview1 setImage:[UIImage imageNamed:@"iphone4s-2.jpg"]];
        [scrollView addSubview:imageview1];
      
        UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, WindowHeight)];
        [imageview2 setImage:[UIImage imageNamed:@"iphone4s-3.jpg"]];
        [scrollView addSubview:imageview2];
        
        
        imageview2.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
        [button setTitle:nil forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
        [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
        [imageview2 addSubview:button];
        
    }
}

- (void)firstpressed
{
    HomeViewController *one=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    PlanViewController *sec=[[PlanViewController alloc]init];
    ThirdViewController *thi=[[ThirdViewController alloc]init];
    //    FourthViewController *four=[[FourthViewController alloc]initWithNibName:@"FourthViewController" bundle:nil];
    ShoppingCartViewController * shoppintCartVC = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
    TUserCenterController *fif = [[TUserCenterController alloc]initWithImageUrls:nil andNavigationTitle:@"个人中心"];
    UINavigationController *nc1=[[UINavigationController alloc]initWithRootViewController:one];
    UINavigationController *nc2=[[UINavigationController alloc]initWithRootViewController:sec];
    UINavigationController *nc3=[[UINavigationController alloc]initWithRootViewController:thi];
    UINavigationController *nc4=[[UINavigationController alloc]initWithRootViewController:shoppintCartVC];
    UINavigationController *nc5=[[UINavigationController alloc]initWithRootViewController:fif];
    NSArray *array=[NSArray arrayWithObjects:nc1,nc2,nc3,nc4,nc5,nil];
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"tab1.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"tab1s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"tab2.png"] forKey:@"Default"];;
	[imgDic2 setObject:[UIImage imageNamed:@"tab2s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"tab3"] forKey:@"Default"];;
	[imgDic3 setObject:[UIImage imageNamed:@"tab3s"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"tab4.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"tab4s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"tab5.png"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"tab5s.png"] forKey:@"Seleted"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
    LeveyTabBarController * leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:array imageArray:imgArr];
	//[leveyTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarbg.png"]];
	[leveyTabBarController setTabBarTransparent:YES];
  //  [self addLoadView];
   // [self updateInterfaceWithReachability: hostReach];

    [self presentViewController:leveyTabBarController  animated:NO completion:nil];  //点击button跳转到根视图
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
