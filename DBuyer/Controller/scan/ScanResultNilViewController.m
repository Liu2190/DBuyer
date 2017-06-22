//
//  SmkViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-27.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ScanResultNilViewController.h"
#import "ScanWebViewController.h"
@interface ScanResultNilViewController ()

@end

@implementation ScanResultNilViewController
@synthesize searchText;
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
    self.navigationController.navigationBar.hidden = YES;
    [self setNavigationBarWithContent:@"扫描" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    UIImageView * img1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Image_SearchView_04"]];
    img1.frame=CGRectMake(35, (WindowHeight-220)/2, 250, 220);
    [self.view addSubview:img1];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(126, img1.frame.origin.y + 220 + 10, 148, 21)];
    lable1.backgroundColor=[UIColor clearColor];
    lable1.text=@"没有搜索到该商品!";
    lable1.textColor=[UIColor colorWithRed:139.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1];
    
    lable1.font=[UIFont systemFontOfSize:10];
    [self.view addSubview:lable1];
    
//    UIImageView *img2=[[UIImageView alloc]initWithFrame:CGRectMake(100, 214, 18, 18)];
//    img2.image=[UIImage imageNamed:@"表情"];
//    [self.view addSubview:img2];
//    self.view.backgroundColor=BACKCOLOR;
//    [self tuijian];
}
-(void)tuijian{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"切片_绿-on"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"切片_绿"] forState:UIControlStateHighlighted];
    button.frame=CGRectMake((640-612)/4, 535/2, 612/2, 45);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnC1:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 14, 612/2, 15)];
    lable1.backgroundColor=[UIColor clearColor];
    lable1.text=@"搜索该商品";
    lable1.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
    lable1.textAlignment=NSTextAlignmentCenter;
    lable1.font=[UIFont systemFontOfSize:12];
    [button addSubview:lable1];
}
-(void)btnC1:(UIButton *)button{
    ScanWebViewController *sc=[[ScanWebViewController alloc]init];
    sc.searchText=searchText;
    [self.navigationController pushViewController:sc animated:YES];
}
-(void)leftButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];

    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
