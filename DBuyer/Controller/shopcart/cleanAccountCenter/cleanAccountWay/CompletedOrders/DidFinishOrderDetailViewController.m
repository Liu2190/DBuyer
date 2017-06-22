//
//  DidFinishOrderDetailViewController.m
//  DBuyer
//
//  Created by simman on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "DidFinishOrderDetailViewController.h"

@interface DidFinishOrderDetailViewController ()

@end

@implementation DidFinishOrderDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"已完成订单" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
