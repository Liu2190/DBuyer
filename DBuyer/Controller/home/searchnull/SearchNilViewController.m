//
//  SearchNilViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SearchNilViewController.h"
#import "HttpDownload.h"
#import "BtnDelegate.h"
#import "SearchResultViewController.h"
#import "LeveyTabBarController.h"
#import "SearchHistoryViewController.h"
#import "RecommendScrollView.h"
#import "Product.h"
#import "SearchBarView.h"
#import "ShortageViewController.h"

#import "SearchSever.h"
#import "TServerFactory.h"
#import "TUtilities.h"
#import "GiftdetailsViewController.h"
#import "GiftCell.h"

@interface SearchNilViewController () <RecommendScrollViewDelegate, SearchBarViewDelegate>
@property (nonatomic, assign) RecommendScrollView * recommendView;
@property (nonatomic, assign) SearchBarView * searchBarView;
@property (nonatomic, retain) NSMutableArray * recommendProductList;
@end

@implementation SearchNilViewController
@synthesize searchNo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.recommendProductList removeAllObjects];
}
#pragma mark - private methods
- (void)askAdjustProductmethod
{
    [[TServerFactory getServerInstance:@"SearchSever"]doGetRecommendedGoodsBycallback:^(NSArray *productArray){
        [self.recommendView showWithProducts:productArray];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=BACKCOLOR;
    // navigationBar
    self.searchBarView = [SearchBarView searchBarView];
    self.searchBarView.delegate = self;
    self.searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"%@", self.searchNo];
    [self.view addSubview:self.searchBarView];
    
    self.recommendProductList = [[[NSMutableArray alloc] init] autorelease];
    self.searchResultLabel.text = [NSString stringWithFormat:@"没有搜索到“%@”",self.searchNo];
    [self.feedBackButton addTarget:self action:@selector(feedBackAction) forControlEvents:UIControlEventTouchUpInside];
    // 添加水平拖动浏览视图
    self.recommendView = [[[RecommendScrollView alloc] initWithArray:self.recommendProductList title:@"更多推荐" startPoint:CGPointMake(0, [self.searchBarView bottom] + 190)] autorelease];
    self.recommendView.RSdelegate = self;
    [self.view addSubview:self.recommendView];
    [self askAdjustProductmethod];
}
-(void)feedBackAction
{
    //缺货反馈
    ShortageViewController *stVC = [[ShortageViewController alloc]initWithNibName:@"ShortageViewController" bundle:nil];
    [self.navigationController pushViewController:stVC animated:YES];
}
#pragma mark - navigationBarView 代理方法
- (void)searchBarDidClickButton:(NSInteger)buttonIndex
{
    // 点击左键或搜索键
    if (buttonIndex == 0 || buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark - 水平拖动视图代理方法
- (void)RecommendViewDidClicked:(NSUInteger)index
{
    [self pushProductDetails:index];
}

-(void)pushProductDetails:(NSInteger)index
{
    //进入礼包详情页面
    GiftdetailsViewController *gif=[[GiftdetailsViewController alloc]init];
    GiftCell *cellDic = (GiftCell *)[self.recommendProductList objectAtIndex:index];
    gif.gid = cellDic.gid;
    [self.navigationController pushViewController:gif animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    self.recommendProductList = nil;
    self.searchBarView = nil;
    [_searchResultLabel release];
    [_feedBackButton release];
    [super dealloc];
}

@end
