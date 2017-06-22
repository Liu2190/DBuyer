//
//  ProductListViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProductListViewController.h"
#import "CollectCell.h"
#import "Product.h"
#import "SearchHistoryViewController.h"
#import "SearchBarView.h"
@interface ProductListViewController () <UITableViewDataSource, UITableViewDelegate, SearchBarViewDelegate> {
    CGFloat startPoint;
    NSInteger sortType;
    NSInteger pageNum;
    NSInteger totalPage;
    BOOL isMore;
    BOOL priceAscending;
    UIImageView * xinpinImage;
    UIImageView * xiaoliangImage;
    UIImageView * jiageImage;
}

@property (nonatomic, assign) UIButton * leftButton;
@property (nonatomic, assign) UIButton * rightButton;
@property (nonatomic, assign) UITableView * tableView;
//@property (nonatomic, retain) ProductSortSelectView * sortView;

@property (nonatomic, retain) HttpDownload * thisDownload;

@property (nonatomic, retain) UILabel * footLabel;

@property (nonatomic, retain) SearchBarView * searchBarView;

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.productList = [NSMutableArray array];
        self.listID = [NSString string];
        self.isCuxiao = NO;
        sortType = 0;
        priceAscending = YES;
        pageNum = 1;
    }
    return self;
}
- (void)dealloc
{
    self.searchBarView = nil;
    self.spID = nil;
    self.listID = nil;
    self.thisDownload = nil;
    self.productList = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigationBar视图
    self.navigationController.navigationBarHidden = YES;
    self.searchBarView = [SearchBarView searchBarView];
    self.searchBarView.delegate = self;
    self.searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"大家都在搜：%@",[[NSUserDefaults standardUserDefaults] objectForKey:dDefaultSearch]];
    [self.view addSubview:self.searchBarView];
    [self addLoadView];
    [self setStartPoint];
    
    // 设置tableView视图
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40+startPoint, WindowWidth, WindowHeight - TabbarHeight-40-startPoint) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:self.tableView];
    // 设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataFromNetWith:1];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.productList removeAllObjects];
}

#pragma mark - searchBarView 代理方法
- (void)searchBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) {
        //搜索
        SearchHistoryViewController *se=[[SearchHistoryViewController alloc]initWithNibName:@"SearchHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:se animated:NO];
    }
}

#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    [[self mainDelegate] endLoad];
    [self.thisDownload ConnectionCanceled];
}
-(void)loadFail{
    [[self mainDelegate] endLoad];
}
-(void)setStartPoint{
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending){
        startPoint = 0.0f;
        //当前系统小于IOS7.0
    }
    else
    {
        startPoint = 20.0f;
        //当前系统大于ios7.0
    }
}
#pragma mark 选择排序类型响应事件
- (void)sortTypeSelect:(NSNumber *)type
{
    sortType = [type integerValue];
    // 加载数据
    [self getDataFromNetWith:1];
}
#pragma mark - tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CollectCell";
    CollectCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [CollectCell collectCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    Product * product = [self.productList objectAtIndex:indexPath.row];
    [cell showWithProduct:product];
    if (indexPath.row == self.productList.count-1) {
        if (!self.footLabel && pageNum < totalPage) {
            self.tableView.contentSize  = CGSizeMake(320, self.tableView.contentSize.height+45);
            self.footLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.tableView.contentSize.height - 40, 320, 30)] autorelease];
            self.footLabel.text = @"上拉加载更多";
            self.footLabel.font = [UIFont systemFontOfSize:13];
            self.footLabel.textColor = [UIColor darkGrayColor];
            self.footLabel.textAlignment = NSTextAlignmentCenter;
            [self.tableView addSubview:self.footLabel];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str=[[NSString alloc]init];
    self.spID = [[NSString alloc]initWithFormat:@"%@",[[self.productList objectAtIndex:[indexPath row]] valueForKey:@"productID"]];
    str=[NSString stringWithFormat:PRODETAIL_URL,serviceHost, self.spID];
    HttpDownload *hd=[[HttpDownload alloc]init];
    self.thisDownload = hd;
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(loadFail);
    [hd downloadFromUrl:str];
    hd.type=1200;
    [[self mainDelegate] beginLoad];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CollectCell heightOfCell];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}
#pragma mark - headerView
-(UIView *)headerView{
    UIView * listHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    listHeaderView.backgroundColor=[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1];
    listHeaderView.userInteractionEnabled=YES;
    NSArray * titleArray = [NSArray arrayWithObjects:@"新品",@"销量",@"价格", nil];
    for(int i = 0 ; i < 3 ; i ++){
        LXD * titleLabel = [[LXD alloc]initWithText:[titleArray objectAtIndex:i] font:17 textAlight:NSTextAlignmentCenter frame:CGRectMake(108*i, 0, 86, 40) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
        titleLabel.userInteractionEnabled=YES;
        [listHeaderView addSubview:titleLabel];
        UIButton * button = [ UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1989 + i;
        button.backgroundColor = [UIColor clearColor];
        button.frame=CGRectMake(i * 106, 0, 106, 40);
        [listHeaderView addSubview:button];
        [button addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    xinpinImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Image_ProductList_02"] highlightedImage:[UIImage imageNamed:@"Image_ProductList_01"]];
    xinpinImage.frame = CGRectMake(68, 19, 9, 7);
    xinpinImage.highlighted = YES;
    [listHeaderView addSubview:xinpinImage];
    xinpinImage.userInteractionEnabled = YES;
    
    xiaoliangImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Image_ProductList_02"] highlightedImage:[UIImage imageNamed:@"Image_ProductList_01"]];
    xiaoliangImage.frame = CGRectMake(178, 19, 9, 7);
    [listHeaderView addSubview:xiaoliangImage];
    xiaoliangImage.userInteractionEnabled = YES;
    
    jiageImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Image_ProductList_09"] highlightedImage:[UIImage imageNamed:@"Image_ProductList_03"]];
    jiageImage.frame = CGRectMake(285, 14, 9, 14);
    [listHeaderView addSubview:jiageImage];
    jiageImage.userInteractionEnabled = YES;
    if(sortType == 0)
    {
        xinpinImage.highlighted = YES;
        xiaoliangImage.highlighted = NO;
        jiageImage.highlighted = NO;
        jiageImage.image = [UIImage imageNamed:@"Image_ProductList_09"];
        
    }
    else if (sortType == 1)
    {
        xinpinImage.highlighted = NO;
        xiaoliangImage.highlighted = YES;
        jiageImage.highlighted = NO;
        jiageImage.image = [UIImage imageNamed:@"Image_ProductList_09"];
    }
    else if (sortType == 2)
    {
        xinpinImage.highlighted = NO;
        xiaoliangImage.highlighted = NO;
        jiageImage.image = [UIImage imageNamed:@"Image_ProductList_03"];
    }
    else {
        xinpinImage.highlighted = NO;
        xiaoliangImage.highlighted = NO;
        jiageImage.image = [UIImage imageNamed:@"Image_ProductList_05"];

    }
    return listHeaderView;
}
-(void)loadMore
{
    pageNum++;
    [self getDataFromNetWith:2];
}
-(void)pushDetail:(UIButton *)button{
    
    
    switch (button.tag) {
        case 1989:
        {
            //新品
            
            sortType = 0;
            [self getDataFromNetWith:1];
        }
            break;
        case 1990:
        {
            //销量
            
            sortType = 1;
            [self getDataFromNetWith:1];
        }
            break;
        case 1991:
        {
            
            //价格
            if(priceAscending == YES)
            {
                sortType = 2;
                
                [self getDataFromNetWith:1];
            }
            else
            {
                sortType = 3;

                [self getDataFromNetWith:1];
            }
            priceAscending = !priceAscending;
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y + 500 > scrollView.contentSize.height ){
        if (pageNum < totalPage){
            [self loadMore];
        }
    }
}


-(void)getDataFromNetWith:(int)type {
    [self.footLabel removeFromSuperview];
    self.footLabel = nil;
    if (type == 1) {
        isMore = NO;
        pageNum = 1;
    }
    else if(type==2){
        isMore = YES;
    }
    HttpDownload *hd=[[HttpDownload alloc]init];
    self.thisDownload = hd;
    hd.delegate=self;
    hd.type=16;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(loadFail);
    
    NSString *sortFlaf = @"sales";
    NSString *descFlag = @"desc";
    if (sortType == 0) {
        sortFlaf = @"";
        descFlag = @"";
        
    }else if (sortType == 1) {
        sortFlaf = @"sales";
        descFlag = @"desc";
    }else if (sortType == 2){
        sortFlaf = @"sellPrice";
        descFlag = @"desc";
    }else if (sortType == 3){
        
        sortFlaf = @"sellPrice";
        descFlag = @"asc";
       
    }
    if (_isCuxiao) {
        
        [hd downloadFromUrl:[NSString stringWithFormat:kCuxiaoList,serviceHost,_listID,sortFlaf,descFlag,pageNum]];
    }else{
        
        [hd downloadFromUrl:[NSString stringWithFormat:sanjifenlei,serviceHost,_listID,sortFlaf,descFlag,pageNum]];
    }
  if(sortType==0 || sortType==1)
  {

  }
    else
    {
        [[self mainDelegate] beginLoad];
    
    }
}

#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd{
    
    [[self mainDelegate] endLoad];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        
        if([[dict objectForKey:@"status"] intValue]==0){
            if (hd.type == 16){
                if (_isCuxiao) {
                    
                    if (![[dict objectForKey:@"returnlist"] isEqual:[NSNull null]]) {
                        totalPage = [[dict valueForKey:@"page_count"] integerValue];
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dict objectForKey:@"returnlist"]];
                        if (isMore) {
                            isMore = NO;
                            NSMutableArray * tempArray = [NSMutableArray array];
                            for (NSDictionary * dic  in arr) {
                                [tempArray addObject:[self makeProductModelFrom:dic]];
                            }
                            [self.productList addObjectsFromArray:tempArray];
                            [self showAlertViewWith:self.productList.count];
                            [self.tableView reloadData];
                        }else{
                            [self.productList removeAllObjects];
                            for (NSDictionary * dic  in arr) {
                                [self.productList addObject:[self makeProductModelFrom:dic]];
                            }
                            [self showAlertViewWith:self.productList.count];
                            [self.tableView reloadData];
                        }
                    }
                }else {
                    
                    if (![[dict objectForKey:@"goods_list"] isEqual:[NSNull null]]){
                        totalPage = [[dict valueForKey:@"page_count"] integerValue];
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dict objectForKey:@"goods_list"]];
                        if (isMore) {
                            isMore = NO;
                            NSMutableArray * tempArray = [NSMutableArray array];
                            for (NSDictionary * dic  in arr) {
                                [tempArray addObject:[self makeProductModelFrom:dic]];
                            }
                            [self.productList addObjectsFromArray:tempArray];
                            [self showAlertViewWith:self.productList.count];
                            [self.tableView reloadData];
                        }else{
                            [self.productList removeAllObjects];
                            for (NSDictionary * dic  in arr) {
                                [self.productList addObject:[self makeProductModelFrom:dic]];
                            }
                            [self showAlertViewWith:self.productList.count];
                            [self.tableView reloadData];
                        }
                    }
                }
            }
            else if(hd.type==1200){
                
                if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                    
                    [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                    return;
               }
                ProductdetailsViewController *so = [[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil] autorelease];
                so.detailDict = dict;
                [self.navigationController pushViewController:so animated:YES];
            }
        } else {
            [self showError:[dict objectForKey:@"msg"]];
        }
    }
}
-(Product *)makeProductModelFrom:(NSDictionary *)dic
{
    Product *product = [[[Product alloc]init] autorelease];
    product.attrValue = [dic valueForKey:@"commodityImage"];
    product.sellPrice = [[dic valueForKey:@"sellPrice"] floatValue];
    product.keyWord = [dic valueForKey:@"keyWord"];
    product.commodityName = [dic valueForKey:@"commodityName"];
    product.marketPrice = [[dic valueForKey:@"marketPrice"] floatValue];
    product.productID = [dic valueForKey:@"ID"];
    product.productDescription = [dic valueForKey:@"description"];
    return product;
}
-(void)showAlertViewWith:(int)num
{
    if(num ==0)
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无商品！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
