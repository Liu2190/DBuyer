//
//  BargainViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BargainViewController.h"
#import "HomeSever.h"
#import "TProductServer.h"
#import "TUtilities.h"
#import "DemoTableFooterView.h"
#import "ProductdetailsViewController.h"
#import "StartPoint.h"
#import "ProductCell.h"
#import "TServerFactory.h"
#define tab_height  0
@interface BargainViewController ()
{
    int _pageNum;
}
@end

@implementation BargainViewController

- (id)initWithNavigationTitle:(NSString *)title {
    self = [super initWithNavigationTitle:title];
    _pageNum = 0;
    self.pullToRefreshEnabled = NO;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    _pageNum = 1;
    [self getDataSourceBy:1];

}

/**
 * 数据源获取方法
 */
- (void)getDataSourceBy:(int)pageNum
{
    if(self.type == TejiaGoods)
    {
        [self getTejiaGoodsWithPage:pageNum];
    }
    if(self.type == TeseGoods)
    {
        [self getTeseGoodsWithPage:pageNum];
    }
    if(self.type == PaihangGoods)
    {
        [self getPaihangGoodsWithPage:pageNum];
    }
    if(self.type == YingjiGoods)
    {
        [self getYingjiGoodsWithPage:pageNum];
    }
    if(self.type == MeiyueXinpinGoods)
    {
        [self getMeiyuexinpinGoodsWithPage:pageNum];
    }
}


/**
 * 重写tableview的创建方法
 */
- (void)addTableView {
    float w = self.contentView.frame.size.width;
    float h = self.contentView.frame.size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.contentView addSubview:self.tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"CollectCell";
    ProductCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Product *product = [self.datas objectAtIndex:indexPath.row];
    [(ProductCell*)cell showWithProduct:product];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count>0?self.datas.count:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Product *thisProduct = [self.datas objectAtIndex:indexPath.row];
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetPromotionalProductByID:thisProduct.productID AndCategoryID:thisProduct.catID andCallback:^(NSDictionary *dict){
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

/**
 * 上拉刷新回调
 */
- (void) addItemsOnBottom {
    _pageNum += 1;
    if (_pageNum > self.maxPage) {
        self.canLoadMore = NO;
        [self loadMoreCompleted];
        return;
    }
    [self getDataSourceBy:_pageNum];
}


- (void) loadMoreCompleted {
    [super loadMoreCompleted];
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    if (self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }
}

-(void)getTejiaGoodsWithPage:(int)currentPage
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetBargainGoodsByAndPageNum:currentPage andCallback:^(NSMutableArray *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        self.maxPage = page_count;
        [self.datas addObjectsFromArray:datas];
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
}
-(void)getTeseGoodsWithPage:(int)currentPage
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetCharacteristicListByID:self.parentId AndPageNum:currentPage callback:^(NSMutableArray *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        self.maxPage = page_count;
        [self.datas addObjectsFromArray:datas];
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
}
-(void)getPaihangGoodsWithPage:(int)currentPage
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetSalesRankingListByID:self.parentId AndPageNum:currentPage callback:^(NSMutableArray *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        self.maxPage = page_count;
        [self.datas addObjectsFromArray:datas];
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
}
-(void)getYingjiGoodsWithPage:(int)currentPage
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetSeasonalGoodsListByID:self.parentId AndPageNum:currentPage callback:^(NSMutableArray *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        self.maxPage = page_count;
        [self.datas addObjectsFromArray:datas];
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
}
-(void)getMeiyuexinpinGoodsWithPage:(int)currentPage
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetMonthlyListByID:self.parentId AndPageNum:currentPage callback:^(NSMutableArray *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        self.maxPage = page_count;
        [self.datas addObjectsFromArray:datas];
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
}
@end
