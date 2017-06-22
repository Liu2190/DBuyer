//
//  TProductListController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProductListController.h"
#import "TServerFactory.h"
#import "TProductServer.h"
#import "TUtilities.h"
#import "DemoTableFooterView.h"
#import "SearchHistoryViewController.h"
#import "Product.h"
#import "ProductdetailsViewController.h"
#import "StartPoint.h"
#import "ProductCell.h"

#define tab_height  41

@implementation TProductListController

- (id)initWithNavigationTitle:(NSString *)title {
    self = [super initWithNavigationTitle:title];
    _sortType = newType; // 默认新品排序
    _pageNum = 1;        // 默认第一页
    isAscending = YES;   // 价格排序时默认是价格升序查看商品
    self.pullToRefreshEnabled = NO;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    toolbarView = [[TProductSortBar alloc]initWithFrame:
                                    CGRectMake(0, 0, self.contentView.frame.size.width, tab_height)];
    [toolbarView addTargetForAction:self];
    toolbarView.userInteractionEnabled=YES;
    [self.contentView addSubview:toolbarView];
    
    topView = [[[NSBundle mainBundle]loadNibNamed:@"ProductListTopView" owner:self options:nil]lastObject];
    topView.delegate = self;
    topView.userInteractionEnabled = YES;
    topView.frame = CGRectMake(0, [StartPoint startPoint], 320, 41);
    [self.view addSubview:topView];
    
    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    [self getDataSourceBy:1];
    [toolbarView updateImageDis:_sortType];
    
}
-(void)productListTopViewDidClick:(int)num
{
    if (num == _sortType && num != PriceType) return;
    _sortType = num;
    [self resetPageInfo];
    
    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    [self getDataSourceBy:_pageNum];
}
- (void)setNavigationBar {
    float navi_h = 44; IsIOS7?navi_h+=20:20;
    CGRect navigationRect = CGRectMake(0, 0, self.view.frame.size.width, navi_h);
    
    self.navigationBar=[[UIView alloc]initWithFrame:navigationRect];
    self.navigationBar.backgroundColor=[UIColor colorWithRed:58.0/255 green:106.0/255.0 blue:91.0/255.0 alpha:1.f];
    self.navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:self.navigationBar];
    
    SearchBarView *searchBarView = [SearchBarView searchBarView];
    [searchBarView showLeftButton:NO];
    searchBarView.delegate = self;
    searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"大家都在搜：%@",[[NSUserDefaults standardUserDefaults] objectForKey:dDefaultSearch]];
    [self.navigationBar addSubview:searchBarView];
}

/**
 * 数据源获取方法
 */
- (void)getDataSourceBy:(int)pageNum {
    [[TServerFactory getServerInstance:@"TProductServer"]doGetProductList:_parentId andPageNum:pageNum
                                                              andSortType:_sortType andIsSale:_isSale andPriceAsc:isAscending
                                                              andCallback:^(NSArray *datas,int pageTotal) {
                                                                  [[TUtilities getInstance]dismiss];
                                                                  self.maxPage = pageTotal;

                                                                  if (datas.count>0) {
                                                                      for (Product *product in datas)
                                                                          [self.datas addObject:product];
                                                                      
                                                                      [self.tableView reloadData];
                                                                  }
                                                                  
                                                                  [self loadMoreCompleted];
                                                            } failureCallback:^(NSString *resp) {
                                                                [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
                                                                [self loadMoreCompleted];
                                                            }];
}


/**
 * 重写tableview的创建方法
 */
- (void)addTableView {
    float w = self.contentView.frame.size.width;
    float h = self.contentView.frame.size.height-tab_height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tab_height, w, h)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.contentView addSubview:self.tableView];
}


//
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
    Product *pro = (Product*)[self.datas objectAtIndex:indexPath.row];
    
    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetProductDetailById:pro.productID andCallback:^(NSDictionary *datas) {
        [[TUtilities getInstance]dismiss];
        ProductdetailsViewController *so = [[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil] autorelease];
        so.detailDict = datas;
        [self.navigationController pushViewController:so animated:YES];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
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

/**
 * 重新排序
 */
- (void)clickSortBtn:(id)sender {
    UIButton *btn = ((UIButton*)sender);
    if (btn.tag == _sortType && btn.tag != PriceType) return;
    _sortType = btn.tag;
    [self resetPageInfo];

    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    [self getDataSourceBy:_pageNum];
    
}

/**
 * 重置界面信息
 */
- (void)resetPageInfo {
    [self.datas removeAllObjects];
    _pageNum = 1;
    
    self.canLoadMore = YES;
    [self loadMoreCompleted];
    
    [toolbarView updateImageDis:_sortType];
    
    isAscending = !isAscending;
    if (_sortType == PriceType) {
        [toolbarView setPriceBlockImage:isAscending];
    }
    [topView setButtonImageWith:_sortType And:isAscending];
    
    [self.tableView reloadData];
}

- (void) loadMoreCompleted {
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }
}

#pragma mark - searchBarView 代理方法
- (void)searchBarDidClickButton:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else if (buttonIndex == 1) {
        SearchHistoryViewController *se=[[SearchHistoryViewController alloc]
                                         initWithNibName:@"SearchHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:se animated:NO];
    }
}

@end
