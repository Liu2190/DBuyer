//
//  HomeViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HomeViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "GiftCell.h"
#import "EasyWebViewViewController.h"
#import "TLoginHandlerDelegate.h"
#import "PackagelistViewController.h"
#import "SearchHistoryViewController.h"
#import "DropdownRefreshView.h"
#import "NavigationBarView.h"
#import "BannerView.h"
#import "GiftLeftView.h"
#import "GiftRightView.h"
#import "CategoryViewController.h"
#import "CollectViewController.h"
#import "GiftdetailsViewController.h"
#import "TLoginController.h"
#import "HomeModel.h"
#import "HomeBannerModel.h"
#import "HomeQuickEnterModel.h"
#import "SearchBarView.h"
#import "StartPoint.h"
#import "CardsViewController.h"
#import "UIButton+WebCache.h"
#import "TMapViewController.h"
#import "BargainViewController.h"

#import "HomeSever.h"
#import "TProductServer.h"
#import "TServerFactory.h"
#import "TUtilities.h"

#define Home_meyuexinpin        5           //每月新品
#define Home_tejia              6           //特价商品
#define Home_xiaoshoupaihang    7           //销售排行
#define Home_yingji             8           //应季商品
#define Home_tese               9           //特色商品
#define CategoryFlag            10          //商品分类
#define BannerToProList         11          //banner图跳转到商品列表


#define TABLEVIEWBACKCOLOR [UIColor colorWithRed:239/255.0 green:237/255.0 blue:216/255.0 alpha:1]
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,EGORefreshTableHeaderDelegate,TLoginHandlerDelegate, BannerViewDelegate,SearchBarViewDelegate>{
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
}
@property (nonatomic, assign) DropdownRefreshView * refreshView;
@property (nonatomic, assign) BannerView * bannerView;
@property (nonatomic, retain) NSString *titleName;//进入下一级时的名称；
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, assign) UITableView *tableView;
@property (nonatomic, retain) HomeModel *homeModel;
@property (nonatomic, assign) SearchBarView *searchBarView;
@property (nonatomic,retain)  HomeBannerModel *thisBanner;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.titleName = [[NSString alloc]init];
        self.homeModel = [[HomeModel alloc]init];
        self.urlString = [[NSString alloc]init];
        self.thisBanner = [[HomeBannerModel alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];//显示tabbar
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return self.homeModel.giftArray.count;
    }
    if (section == 3)
    {
        return self.homeModel.homeADImageUrlArray.count>0?1:0;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 3)
    {
        return 180.0f;
    }
    if(indexPath.section == 1)
    {
        return 204.0f;
    }
    return 120.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndefiter=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiter];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiter];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = TABLEVIEWBACKCOLOR;
    cell.contentView.backgroundColor = TABLEVIEWBACKCOLOR;
    if(indexPath.section == 0)
    {
        for(UIView *v in [cell.contentView subviews])
        {
            [v removeFromSuperview];
        }
        //轮播图
        if(self.homeModel.bannerImageArray.count == 0)
        {
            UIImageView *bannerPlaceholder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, 180)];
            bannerPlaceholder.image = [UIImage imageNamed:@"placeHolerImageBanner"];
            [cell.contentView addSubview:bannerPlaceholder];
        }
        else
        {
            self.bannerView = [[BannerView alloc]initWithImageArray:self.homeModel.bannerImageArray];
            self.bannerView.delegate = self;
            [cell.contentView addSubview:self.bannerView];
        }
    }
    else if(indexPath.section == 1)
    {
        for(UIView *v in [cell.contentView subviews])
        {
            [v removeFromSuperview];
        }
        //快捷入口
        UIView * quickEntryView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 204)] autorelease];
        quickEntryView.userInteractionEnabled = YES;
        for(int i=0;i<[self.homeModel.quickNormalArray count];i++){
            UIButton * button = [[[UIButton alloc] initWithFrame:CGRectMake(10+(i%4)*75, 102*(i/4), 75, 102)] autorelease];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 2000 + i;
            if([[self.homeModel.quickNormalArray objectAtIndex:i]hasPrefix:@"http"])
            {
                [button setImageWithURL:[NSURL URLWithString:[self.homeModel.quickNormalArray objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"quickEnterPlaceHoderImage"]];
            }
            else
            {
                [button setBackgroundImage:[UIImage imageNamed:[self.homeModel.quickNormalArray objectAtIndex:i]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:[self.homeModel.quickHighlightedArray objectAtIndex:i]] forState:UIControlStateHighlighted];
            }
            [quickEntryView addSubview:button];
        }
        [cell.contentView addSubview:quickEntryView];
    }
    else if(indexPath.section == 2)
    {
        for(UIView *v in [cell.contentView subviews])
        {
            [v removeFromSuperview];
        }
        //礼包数据
        GiftCell *gift = (GiftCell *)[self.homeModel.giftArray objectAtIndex:indexPath.row];
        GiftRightView * giftView = nil;
        if (indexPath.row%2 == 0) {
            giftView = [[[NSBundle mainBundle] loadNibNamed:@"GiftRightView" owner:nil options:nil] lastObject];
        } else {
            giftView = [[[NSBundle mainBundle] loadNibNamed:@"GiftLeftView" owner:nil options:nil] lastObject];
        }
        giftView.giftSavePrice.text=[NSString stringWithFormat:@"￥%.2f",gift.savePrice];
        giftView.giftName.text= gift.title;
        [giftView.giftImage setImageWithURL:[NSURL URLWithString:gift.boxPicUrl]];
        giftView.gitfPrice.text = [NSString stringWithFormat:@"%.2f",gift.price];
        [cell.contentView addSubview:giftView];
    }
    else if (indexPath.section == 3)
    {
        //广告视图
        for(UIView *v in [cell.contentView subviews])
        {
            [v removeFromSuperview];
        }
            UIImageView *adView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, 180)];
            [adView setImageWithURL:[NSURL URLWithString:[self.homeModel.homeADImageUrlArray objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"Home_banner_placeholder"]];
            [cell.contentView addSubview:adView];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        NSString *gid = ((GiftCell *)[self.homeModel.giftArray objectAtIndex:indexPath.row]).gid;
        GiftdetailsViewController *gif=[[GiftdetailsViewController alloc]init];
        gif.gid = gid;
        [self.navigationController pushViewController:gif animated:YES];
    }
    if(indexPath.section == 3)
    {
        //首页广告视图点击事件
        HomeBannerModel *adModel = [self.homeModel.homeADArray objectAtIndex:0];
        if ([adModel.pageID integerValue] == 0) {
            
            EasyWebViewViewController *myWeb = [[EasyWebViewViewController alloc]initWithNibName:@"EasyWebViewViewController" bundle:nil];
            myWeb.buyUrl = adModel.pageURL;
            myWeb.shareString = adModel.sharetext;
            [self.navigationController pushViewController:myWeb animated:YES];
            
        }else if([adModel.pageID integerValue] == 1){
            [self toProductDetailViewWithID:adModel.resultID];
            
        }else if([adModel.pageID integerValue] == 3){
            GiftdetailsViewController *gif=[[GiftdetailsViewController alloc]init];
            gif.gid = adModel.resultID;
            [self.navigationController pushViewController:gif animated:YES];
        }else if([adModel.pageID integerValue] == 2)
        {
            //跳转到商品列表
            //需要新的接口 需要定义type值 而且跳转到的商品列表的页面的title由服务器的sharetext返回
            self.urlString = [NSString stringWithFormat:@"%@%@",serviceHost,adModel.pageURL];
            self.titleName = adModel.sharetext;
            [self toRequestDataFromUrl:self.urlString typeTag:BannerToProList params:nil];
        }else if([adModel.pageID integerValue] == 4)
        {
            //跳转到礼包列表
            PackagelistViewController *so=[[PackagelistViewController alloc]init];
            [self.navigationController pushViewController:so animated:YES];
        }

    }
}
//添加刷新view
- (void)addRefreshView
{
    if (_refreshHeaderView == nil)
    {
		EGORefreshTableHeaderView *view = [[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)] autorelease];
        view.tag = 100;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
        // 添加自定义下拉刷新视图
        self.refreshView = [DropdownRefreshView dropdownRefreshView];
        [self.tableView addSubview:self.refreshView];
        CGRect frame = self.refreshView.frame;
        frame.origin.y = -frame.size.height;
        self.refreshView.frame = frame;
	}
    _refreshHeaderView.delegate = self;
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.searchBarView = [SearchBarView searchBarView];
    self.searchBarView.delegate = self;
    self.searchBarView.leftButtonImageView.image = [UIImage imageNamed:@"Image_HomeView_01.png"];
    self.searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"大家都在搜：%@",[[NSUserDefaults standardUserDefaults] objectForKey:dDefaultSearch]];
    [self.view addSubview:self.searchBarView];
    self.view.userInteractionEnabled = YES;
    [self addLoadView];
    [self customSet];
    mainDelegate = [self mainDelegate];
    [self getHomeAllThingsFromNet];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint] - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = TABLEVIEWBACKCOLOR;
    [self addRefreshView];
}


#pragma mark - navigationBarView 代理方法
- (void)searchBarDidClickButton:(NSInteger)buttonIndex
{
    // left
    if (buttonIndex == 0) {
        //一级分类入口
        CategoryViewController *so= [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
        [self.navigationController pushViewController:so animated:YES];
    } else {
        //搜索
        SearchHistoryViewController *se=[[SearchHistoryViewController alloc] initWithNibName:@"SearchHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:se animated:NO];
    }
}

- (void)toRequestDataFromUrl:(NSString *)url typeTag:(int)tag params:(NSMutableDictionary *)dic{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.type=tag;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    if (dic) {
        [hd getResultData:dic baseUrl:url];
    }else{
        [hd downloadFromUrl:url];
    }
    thisDownLoad = hd;
    [mainDelegate beginLoad];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    // 自定义加载视图开始动画
    [self.refreshView startAnimation:YES];
    [self getHomeAllThingsFromNet];
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	// 设置自定义加载视图时间
    [self.refreshView setRefreshTime:[NSDate date]];
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	_reloading = YES;
}
- (void)doneLoadingTableViewData{
    // 结束自定义加载视图动画
	[self.refreshView startAnimation:NO];
	_reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [self doneLoadingTableViewData];
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
#pragma mark - 下载数据
-(void)downloadFail
{
    [self doneLoadingTableViewData];
    [mainDelegate endLoad];
}

-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        [mainDelegate endLoad];
        if([[dict objectForKey:@"status"] intValue]==0){
            if (hd.type == BannerToProList)
            {
               
                if([self isActiveValue:dict]==YES)
                {
                    //跳转到活动列表
                    CardsViewController *cateVC = [[CardsViewController alloc]initWithNibName:@"CardsViewController" bundle:nil];
                    cateVC.urlString = self.urlString;
                    cateVC.titleName = self.thisBanner.sharetext;
                    [self.navigationController pushViewController:cateVC animated:YES];
                }
                else
                {
                    //banner图跳转到商品列表
                    BargainGoodsViewController *barVC= [[BargainGoodsViewController alloc]initWithNibName:@"BargainGoodsViewController" bundle:nil];
                    barVC.listDic = dict;
                    barVC.typeID = @"0";
                    barVC.source = BannerProList;
                    barVC.listUrlString = self.urlString;
                    barVC.catName = self.titleName;//banner图跳转到商品列表时，列表名称由服务器返回；
                    barVC.page_count = [[dict objectForKey:@"page_count"] intValue];
                    barVC.current_page = [[dict objectForKey:@"current_page"] intValue];
                    [self.navigationController pushViewController:barVC animated:YES];
                }
                
            }
            
            else if (hd.type == Home_tese){
                
                
            }
            
            else if (hd.type == Home_meyuexinpin){
                
                CharacteristicViewController *cha=[[CharacteristicViewController alloc]initWithNibName:@"CharacteristicViewController" bundle:nil];
                cha.typeID = @"2";
                if([self.titleName length]!=0)
                {
                    cha.catName = self.titleName;
                }
                else
                {
                    cha.catName = @"每月新品";
                }
                cha.userArray = [dict objectForKey:@"class_list"];
                [self.navigationController pushViewController:cha animated:YES];
                
            }else if (hd.type == Home_tejia){
                
                
            }else if (hd.type == Home_xiaoshoupaihang){
                
                CharacteristicViewController *cha=[[CharacteristicViewController alloc]initWithNibName:@"CharacteristicViewController" bundle:nil];
                cha.typeID = @"4";
                if([self.titleName length]!=0)
                {
                    cha.catName = self.titleName;
                }
                else {
                    cha.catName = @"销售排行";
                }
                cha.userArray = [dict objectForKey:@"class_list"];
                [self.navigationController pushViewController:cha animated:YES];
            }else if (hd.type == Home_yingji){
                
                BargainGoodsViewController *so=[[BargainGoodsViewController alloc]initWithNibName:@"BargainGoodsViewController" bundle:nil];
                so.typeID = @"5";
                so.listDic = dict;
                so.source =  SeasonalGoods;
                if([self.titleName length]!=0)
                {
                    so.catName = self.titleName;
                }
                else
                {
                    so.catName = @"BHG应季商品";
                }
                so.page_count = [[dict objectForKey:@"page_count"] intValue];
                so.current_page = [[dict objectForKey:@"current_page"] intValue];
                [self.navigationController pushViewController:so animated:YES];
            }
        }
        else{
            [mainDelegate endLoad];
            [self showError:[dict objectForKey:@"msg"]];
        }
    }
}
#pragma mark - 轮播图代理方法
-(void)bannerViewDidClicked:(NSUInteger)index
{
    self.thisBanner = [self.homeModel.bannerArray objectAtIndex:index];
    if ([self.thisBanner.pageID integerValue] == 0) {
        
        EasyWebViewViewController *myWeb = [[EasyWebViewViewController alloc]initWithNibName:@"EasyWebViewViewController" bundle:nil];
        myWeb.buyUrl = self.thisBanner.pageURL;
        myWeb.shareString = self.thisBanner.sharetext;
        [self.navigationController pushViewController:myWeb animated:YES];
        
    }else if([self.thisBanner.pageID integerValue] == 1){
        
        [self toProductDetailViewWithID:self.thisBanner.resultID];
        
    }else if([self.thisBanner.pageID integerValue] == 3){
        
        GiftdetailsViewController *gif=[[GiftdetailsViewController alloc]init];
        gif.gid = self.thisBanner.resultID;
        [self.navigationController pushViewController:gif animated:YES];
    }else if([self.thisBanner.pageID integerValue] == 2)
    {
        //跳转到商品列表
        //跳转到的商品列表的页面的title由服务器的sharetext返回,当resultID有返回数据时，返回活动专区，当resultID没有返回数据时，返回正常商品列表专区
        self.urlString = [NSString stringWithFormat:@"%@%@",serviceHost,self.thisBanner.pageURL];
        self.titleName = self.thisBanner.sharetext;
        [self toRequestDataFromUrl:self.urlString typeTag:BannerToProList params:nil];
    }else if([self.thisBanner.pageID integerValue] == 4)
    {
        PackagelistViewController *so=[[PackagelistViewController alloc]init];
        [self.navigationController pushViewController:so animated:YES];
    }
}
-(void)buttonClick:(UIButton *)button
{
    switch (button.tag)
    {
        case 2000:
        {
            
            if(self.homeModel.quickHasData)
            {
                //快捷入口有数据
                HomeQuickEnterModel *quickM = [self.homeModel.quickEnterArray objectAtIndex:0];
                self.titleName = quickM.name;
                if(![self IsEmptyOfString:quickM.type])
                {
                    [self baseTypeToList:[quickM.type intValue]];
                }
            }
            else
            {
                [self baseTypeToList:0];
            }
            break;
        }
        case 2001:
        {
            if(self.homeModel.quickHasData)
            {
                HomeQuickEnterModel *quickM = [self.homeModel.quickEnterArray objectAtIndex:1];
                self.titleName = quickM.name;
                if(![self IsEmptyOfString:quickM.type])
                {
                    [self baseTypeToList:[quickM.type intValue]];
                }
            }
            else
            {
                [self baseTypeToList:2];
            }
            break;
        }
        case 2002:
        {
            if(self.homeModel.quickHasData)
            {
                HomeQuickEnterModel *quickM = [self.homeModel.quickEnterArray objectAtIndex:2];
                self.titleName = quickM.name;
                if(![self IsEmptyOfString:quickM.type])
                {
                    [self baseTypeToList:[quickM.type intValue]];
                }
            }
            else
            {
                [self baseTypeToList:3];
            }
            
            break;
        }
        case 2003: {
          /*  if(self.homeModel.quickHasData)
            {
                HomeQuickEnterModel *quickM = [self.homeModel.quickEnterArray objectAtIndex:3];
                self.titleName = quickM.name;
                if(![self IsEmptyOfString:quickM.type])
                {
                    [self baseTypeToList:[quickM.type intValue]];
                }
            }
            else
            {
                [self baseTypeToList:5];
            }
            */
            CardsViewController *acVC = [[CardsViewController alloc]initWithNibName:@"CardsViewController" bundle:nil];
            [self.navigationController pushViewController:acVC animated:YES];
            break;
            
        }
        case 2004: {
            /*MapViewController *MapVC=[[MapViewController alloc]init];
            [self.navigationController pushViewController:MapVC animated:YES];
            break;*/
            
            TMapViewController *mapController = [[[TMapViewController alloc]initWithNavigationTitle:@"身边的华联"]autorelease];
            [self.navigationController pushViewController:mapController animated:YES];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            break;
        }
        case 2005:
        {
            PackagelistViewController *so=[[PackagelistViewController alloc]init];
            [self.navigationController pushViewController:so animated:YES];
            break;
        }
        case 2006:
        {
#pragma mark - 收藏 （需要用户名）
            
            if (self.isAlreadyLogined) {
                CollectViewController *sclbVC = [[CollectViewController alloc] init];
                [self.navigationController pushViewController:sclbVC animated:YES];
            } else {
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                TLoginController *loginController = [[TLoginController alloc]initWithNavigationTitle:@"登录"];
                loginController.delegate = self;
                UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:loginController]autorelease];
                [self.navigationController presentViewController:navi animated:YES completion:nil];
            }
            
            break;
        }
        case 2007:
        {
            if (self.isAlreadyLogined) {
                MyOrderViewController *so=[[MyOrderViewController alloc]initWithNibName:@"MyOrderViewController" bundle:nil];
                [self.navigationController pushViewController:so animated:YES];
            } else {
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                TLoginController *loginController = [[TLoginController alloc]initWithNavigationTitle:@"登录"];
                loginController.delegate = self;
                UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:loginController]autorelease];
                [self.navigationController presentViewController:navi animated:YES completion:nil];
            }
            break;
        }
        default:
            break;
    }
}

- (void)loginSuccess:(TDbuyerUser*)dbuyerUser {
    
}
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
-(void)baseTypeToList:(int)typeValue
{
    //根据typeValue值决定跳转到哪个页面
    switch (typeValue) {
        case 0:
        {
            //跳转到分类商品列表
            CategoryViewController *so= [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
            [self.navigationController pushViewController:so animated:YES];
        }
            break;
        case 1:
        {
            //跳转到特色商品列表
            [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
            [[TServerFactory getServerInstance:@"HomeSever"]doGetCharacteristicCategoryBycallback:^(NSDictionary *dict){
                [[TUtilities getInstance]dismiss];
                CharacteristicViewController *cha=[[CharacteristicViewController alloc]initWithNibName:@"CharacteristicViewController" bundle:nil];
                cha.typeID = @"1";
                if([self.titleName length]!=0)
                {
                    cha.catName = self.titleName;
                }
                else
                {
                    cha.catName = @"特色商品";
                }
                cha.userArray = [dict objectForKey:@"class_list"];
                [self.navigationController pushViewController:cha animated:YES];
            } failureCallback:^(NSString *resp){
                [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
            }];
        }
            break;
        case 2:
        {
            //跳转到每月新品列表
            [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
            [[TServerFactory getServerInstance:@"HomeSever"]doGetMonthlyCategoryBycallback:^(NSDictionary *dict){
                [[TUtilities getInstance]dismiss];
                CharacteristicViewController *cha=[[CharacteristicViewController alloc]initWithNibName:@"CharacteristicViewController" bundle:nil];
                cha.typeID = @"2";
                if([self.titleName length]!=0)
                {
                    cha.catName = self.titleName;
                }
                else
                {
                    cha.catName = @"每月新品";
                }
                cha.userArray = [dict objectForKey:@"class_list"];
                [self.navigationController pushViewController:cha animated:YES];
            } failureCallback:^(NSString *resp){
                [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
            }];
        }
            break;
        case 3:
        {
            //跳转到特价商品列表
            BargainViewController *bar = [[BargainViewController alloc]initWithNavigationTitle:@"特价商品"];
            bar.type = TejiaGoods;
            [self.navigationController pushViewController:bar animated:YES];
            [self.leveyTabBarController hidesTabBar:YES animated:NO ];
        }
            break;
        case 4:
        {
            //跳转到销售排行列表
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"4",@"classId",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
            [self toRequestDataFromUrl:[NSString stringWithFormat:Xiaoshoupaihangyiji,serviceHost] typeTag:Home_xiaoshoupaihang params:dict];
        }
            break;
        case 5:
        {
            //跳转到应季商品列表
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"5",@"goodsClass",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
            [self toRequestDataFromUrl:[NSString stringWithFormat:Yingji,serviceHost] typeTag:Home_yingji params:dict];
        }
            break;
        default:
            break;
    }
}
- (BOOL)isActiveValue:(NSDictionary *)dict
{
    id item = [dict objectForKey:@"commodityList"];
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        if([item isKindOfClass:[NSArray class]])
        {
            for(NSDictionary *dic in item)
            {
                id catID = [dic objectForKey:@"categoryID"];
                if(!(catID==nil||catID ==NULL) &&(![catID isKindOfClass:[NSNull class]]))
                {
                    if([catID isEqualToString:@"66"])
                    {
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}
-(void)getHomeAllThingsFromNet
{
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"HomeSever"]doGetHomeAllThingsBycallback:^(NSDictionary *dict){
        [[TUtilities getInstance]dismiss];
        [self doneLoadingTableViewData];
        [self.homeModel getDataFromNet:(NSMutableDictionary *)dict];
        self.searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"大家都在搜：%@",[[NSUserDefaults standardUserDefaults] objectForKey:dDefaultSearch]];
        [self.tableView reloadData];
    } failureCallback:^(NSString *resp){
        [self doneLoadingTableViewData];
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
        [self.tableView reloadData];
    }];
}
-(void)toProductDetailViewWithID:(NSString *)productId
{
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetProductDetailById:productId andCallback:^(NSDictionary *dict){
        [[TUtilities getInstance]dismiss];
        ProductdetailsViewController *so=[[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
        so.detailDict = dict;
        [self.navigationController pushViewController:so animated:YES];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end