//
//  CardsViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CardsViewController.h"
#import "NavigationBarView.h"
#import "ActiveView.h"
#import "StartPoint.h"
#import "EasyWebViewViewController.h"
#import "BargainModel.h"
#import "BargainHeaderView.h"
#import "ShareView.h"
#import "ProductdetailsViewController.h"
#import "HomeSever.h"
#import "TProductServer.h"
#import "TUtilities.h"
#import "TServerFactory.h"

#define ImageHeight 180
@interface CardsViewController ()<UIScrollViewDelegate,NavigationBarViewDelegate>{
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    int current_page;
    int page_count;
    int thisCount;
    NSString *thisCateID;
}
@property (nonatomic,assign)UIScrollView *scrolView;
@property (nonatomic,assign)float leftPoint;
@property (nonatomic,assign)float rightPoint;
@property (nonatomic,assign)UILabel *footLabel;
@property (nonatomic,retain)BargainModel *activeModel;
@property (nonatomic,assign)BargainHeaderView *bargainHeaderView;
@property (nonatomic,assign)ShareView *shareView;
@end

@implementation CardsViewController
@synthesize titleName,urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.activeModel = [[BargainModel alloc]init];
        current_page = 0;
        thisCateID = [[NSString alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = BACKCOLOR;
    NavigationBarView * navigationView = [NavigationBarView navigationBarView];
    
    if([titleName length]==0)
    {
        [navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"]
                          rightImage:[UIImage imageNamed:@"pro_share_image"]
                          titleImage:nil
                               title:@"VIP专区"];
    }
    else
    {
        [navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"]
                          rightImage:[UIImage imageNamed:@"pro_share_image"]
                          titleImage:nil
                               title:titleName];
    }
    navigationView.delegate = self;
    [self.view addSubview:navigationView];
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint])];
    self.scrolView.delegate = self;
    self.scrolView.userInteractionEnabled = YES;
    self.scrolView.backgroundColor = BACKCOLOR;
    self.scrolView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrolView];
    [self loadMore];
}
-(void)setScrolViewWithModel
{
    if(self.bargainHeaderView != nil)
    {
    }
    else{
        if(self.activeModel.bHModel.isActivHasData == YES)
        {
            //如果有顶部广告视图
            self.bargainHeaderView = [[BargainHeaderView alloc] initHeaderViewWith:self.activeModel.bHModel];
            self.bargainHeaderView.deleagate = self;
            self.bargainHeaderView.userInteractionEnabled = YES;
            self.leftPoint = 180;
            self.rightPoint = 180;
            [self.scrolView addSubview:self.bargainHeaderView];
        }
        else
        {
            self.leftPoint = 0;
            self.rightPoint = 0;
        }
  
    }
    for(int i = thisCount;i<[self.activeModel.productListArray count];i++)
    {
        if(i%2==0)
        {
            //左侧视图
            ActiveView *leftView = [[[NSBundle mainBundle]loadNibNamed:@"ActiveView" owner:self options:nil]lastObject];
            leftView.userInteractionEnabled = YES;
            [leftView setActiveViewValueWith:[self.activeModel.productListArray objectAtIndex:i] AndIndex:i];
            leftView.frame = CGRectMake(10, self.leftPoint, 148, ImageHeight);
            leftView.delegate = self;
            [self.scrolView addSubview:leftView];
            self.leftPoint = self.leftPoint +ImageHeight;
            self.scrolView.contentSize = CGSizeMake(WindowWidth, self.leftPoint);
        }
        else
        {
            //右侧视图
            ActiveView *leftView = [[[NSBundle mainBundle]loadNibNamed:@"ActiveView" owner:self options:nil]lastObject];
            leftView.userInteractionEnabled = YES;
            [leftView setActiveViewValueWith:[self.activeModel.productListArray objectAtIndex:i] AndIndex:i];
            leftView.frame = CGRectMake(162, self.rightPoint, 148, ImageHeight);
            leftView.delegate = self;
            [self.scrolView addSubview:leftView];
            self.rightPoint = self.rightPoint+ImageHeight;
        }
    }
    thisCount = [self.activeModel.productListArray count];
    if(!self.footLabel && current_page < page_count)
    {
        self.scrolView.contentSize  = CGSizeMake(WindowWidth, self.scrolView.contentSize.height+45);
        self.footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrolView.contentSize.height - 40, 320, 30)];
        self.footLabel.text = @"上拉加载更多";
        self.footLabel.font = [UIFont systemFontOfSize:13];
        self.footLabel.textColor = [UIColor darkGrayColor];
        self.footLabel.textAlignment = NSTextAlignmentCenter;
        [self.scrolView addSubview:self.footLabel];
    }
}
#pragma mark 列表活动图片的代理方法
-(void)bargainHeaderViewDidClick:(NSUInteger)index
{
    if (index == 0) {
        //跳转到webView
        if(self.activeModel.bHModel.isActivHasData == YES && self.activeModel.bHModel.activFlag == YES)
        {
            EasyWebViewViewController *myWeb = [[EasyWebViewViewController alloc]initWithNibName:@"EasyWebViewViewController" bundle:nil];
            myWeb.buyUrl = self.activeModel.bHModel.activInterfaceUrl;
            myWeb.shareString = self.activeModel.bHModel.activShareText;
            [self.navigationController pushViewController:myWeb animated:YES];
        }
    }
    else
    {
        if(self.activeModel.bHModel.isAoskHasData == YES&& self.activeModel.bHModel.aoskFlag == YES)
        {
            //跳转到购买奥斯卡列表
        }
    }
}

-(void)activeDidClick:(int )index
{
    Product *thisProduct = [self.activeModel.productListArray objectAtIndex:index];
    thisCateID = thisProduct.catID;
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetPromotionalProductByID:thisProduct.goodsID AndCategoryID:thisProduct.catID andCallback:^(NSDictionary *dict){
        [[TUtilities getInstance]dismiss];
        ProductdetailsViewController *proVC = [[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
        proVC.detailDict = dict;
        proVC.type = 1;
        proVC.catID = thisProduct.catID;
        [self.navigationController pushViewController:proVC animated:YES];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
    }];

}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        [mainDelegate endLoad];
        if(hd.type == 16)
        {
            current_page = [[dict objectForKey:@"current_page"] intValue];
            page_count = [[dict objectForKey:@"page_count"] intValue];
            [self.activeModel getDataWith:(NSMutableDictionary *)dict];
            [self setScrolViewWithModel];
        }
        if (hd.type == 1200)
        {
            if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0)
            {
                [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                return;
            }
            ProductdetailsViewController *proVC=[[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
            proVC.type = 1;
            proVC.catID = thisCateID;
            proVC.detailDict = dict;
            [self.navigationController pushViewController:proVC animated:YES];
            [mainDelegate endLoad];
        }
    }
}
-(void)downloadFail
{
    [mainDelegate endLoad];
}
#pragma mark navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (buttonIndex == 1)
    {
        //分享
        if([self.activeModel.bHModel.activInterfaceUrl length]!=0){
            NSString *shareContent=self.activeModel.bHModel.activInterfaceUrl;//分享的url需要确定
            NSString *titleString = self.activeModel.bHModel.activShareText;//分享的内容
            self.shareView = [[ShareView alloc]initShareViewWith:titleString AndContent:shareContent AndImage:@"Icon.png"];
            [self.view addSubview:self.shareView];
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y + 500 > scrollView.contentSize.height ){
        if (current_page < page_count){
            [self loadMore];
        }
    }
}
- (void)loadMore
{
    current_page ++;
    [self.footLabel removeFromSuperview];
    self.footLabel = nil;
    if([urlString length]!=0)
    {
        HttpDownload *hd=[[HttpDownload alloc]init];
        thisDownLoad = hd;
        hd.delegate=self;
        hd.type=16;
        hd.method=@selector(downloadComplete:);
        hd.failMethod = @selector(downloadFail);
        [mainDelegate beginLoad];
        [hd downloadFromUrl:urlString];
    }
    else
    {
        [[TServerFactory getServerInstance:@"HomeSever"]doGetActivityListByID:nil AndPageNum:current_page callback:^(NSDictionary *datas,int page_count1) {
            [[TUtilities getInstance]dismiss];
            [self.activeModel getDataWith:(NSMutableDictionary *)datas];
            page_count = page_count1;
            [self.activeModel getDataWith:(NSMutableDictionary *)datas];
            [self setScrolViewWithModel];
        } failureCallback:^(NSString *resp) {
            [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.5];
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
