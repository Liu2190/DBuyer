//
//  ActivePageViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ActivePageViewController.h"
#import "DemoTableFooterView.h"
#import "ProductdetailsViewController.h"
#import "StartPoint.h"
#import "ProductCell.h"
#import "HomeSever.h"
#import "TProductServer.h"
#import "TUtilities.h"
#import "TServerFactory.h"
#import "ActiveView.h"
#import "BargainHeaderView.h"
#import "BargainModel.h"
#import "BargainHeaderView.h"
#import "ShareView.h"
#import "EasyWebViewViewController.h"

@interface ActivePageViewController ()
{
    int _pageNum;
}
@property (nonatomic,retain)BargainModel *activeModel;
@property (nonatomic,retain)ShareView *shareView;
@property (nonatomic,retain)BargainHeaderView *bargainHeaderView;
@end
@implementation ActivePageViewController
-(id)initWithNavigationTitle:(NSString *)title andRightAttached:(NSString *)rightAttached
{
    self = [super initWithNavigationTitle:title andRightAttached:rightAttached];
    self.pullToRefreshEnabled = NO;
    self.activeModel = [[BargainModel alloc]init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    [[TUtilities getInstance]popTarget:self.contentView status:@"加载中..."];
    _pageNum = 1;
    [self getDataSourceBy:_pageNum];
}
-(void)rightButtonAction
{
    //分享
    //分享
    if([self.activeModel.bHModel.activInterfaceUrl length]!=0){
        NSString *shareContent=self.activeModel.bHModel.activInterfaceUrl;//分享的url需要确定
        NSString *titleString = self.activeModel.bHModel.activShareText;//分享的内容
        self.shareView = [[ShareView alloc]initShareViewWith:titleString AndContent:shareContent AndImage:@"Icon.png"];
        [self.view addSubview:self.shareView];
    }
}
/**
 * 数据源获取方法
 */
- (void)getDataSourceBy:(int)pageNum
{
    [[TServerFactory getServerInstance:@"HomeSever"]doGetActivityListByID:nil AndPageNum:pageNum callback:^(NSDictionary *datas,int page_count) {
        [[TUtilities getInstance]dismiss];
        [self.activeModel getDataWith:(NSMutableDictionary *)datas];
        self.maxPage = page_count;
        self.bargainHeaderView = [[BargainHeaderView alloc] initHeaderViewWith:self.activeModel.bHModel];
        self.bargainHeaderView.deleagate = self;
        self.tableView.tableHeaderView = self.bargainHeaderView ;
        [self.tableView reloadData];
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [self loadMoreCompleted];
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.5];
    }];
 
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    ActiveView *leftView = [[[NSBundle mainBundle]loadNibNamed:@"ActiveView" owner:self options:nil]lastObject];
    leftView.userInteractionEnabled = YES;
    [leftView setActiveViewValueWith:[self.activeModel.productListArray objectAtIndex:indexPath.row*2] AndIndex:indexPath.row*2];
    leftView.frame = CGRectMake(5, 0, 148, 180);
    leftView.delegate = self;
    [cell.contentView addSubview:leftView];
    if([self.activeModel.productListArray count]>(indexPath.row * 2 +1))
    {
        ActiveView *rightView = [[[NSBundle mainBundle]loadNibNamed:@"ActiveView" owner:self options:nil]lastObject];
        rightView.userInteractionEnabled = YES;
        rightView.delegate = self;
        [rightView setActiveViewValueWith:[self.activeModel.productListArray objectAtIndex:(indexPath.row*2+1)] AndIndex:(indexPath.row*2+1)];
        rightView.frame = CGRectMake(150, 0, 148, 180);
        [cell.contentView addSubview:rightView];
    }
    return cell;
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

-(void)activeDidClick:(int)index
{
    Product *thisProduct = [self.activeModel.productListArray objectAtIndex:index];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activeModel.productListArray.count>0?(self.activeModel.productListArray.count+1)/2:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

@end
