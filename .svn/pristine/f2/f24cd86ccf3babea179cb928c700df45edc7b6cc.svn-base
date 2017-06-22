//
//  CollectViewController.m
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectEmptyView.h"
#import "CollectCell.h"
#import "Product.h"
#import "HttpDownload.h"
#import "CollectEditViewController.h"
#import "RecommendScrollView.h"
#import "NavigationBarView.h"

@interface CollectViewController () <UITableViewDataSource, UITableViewDelegate, RecommendScrollViewDelegate, NavigationBarViewDelegate> {
}
@property (nonatomic, assign) int productType;
@property (nonatomic, retain) NSString * productCategoryID;

@property (nonatomic, assign) UITableView * tableView;
@property (nonatomic, assign) CollectEmptyView * emptyView;
@property (nonatomic, retain) NSMutableArray * productList;
@property (nonatomic, retain) NSMutableArray * recommendProductList;
@property (nonatomic, retain) HttpDownload * thisDownload;
@property (nonatomic, retain) UIButton * leftButton;
@property (nonatomic, retain) UIButton * rightButton;
@property (nonatomic, retain) RecommendScrollView * recommendView;
@property (nonatomic, retain) NavigationBarView * navigationBarView;
@end

@implementation CollectViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.productList = [NSMutableArray array];
        self.recommendProductList = [NSMutableArray array];
    }
    return self;
}
- (void)dealloc
{
    self.navigationBarView = nil;
    self.leftButton = nil;
    self.rightButton = nil;
    self.thisDownload = nil;
    self.productList = nil;
    self.recommendProductList = nil;
    self.productCategoryID = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置navigationBar视图
    self.navigationController.navigationBarHidden = YES;
    NavigationBarView * navigationBar = [NavigationBarView navigationBarView];
    [navigationBar setLeftImage:[UIImage imageNamed:@"Image_Collect_05"]
                     rightImage:[UIImage imageNamed:@"Image_Collect_08"]
                     titleImage:nil
                          title:@"收藏夹"];
    navigationBar.delegate = self;
    self.navigationBarView = navigationBar;
    [self.view addSubview:navigationBar];
    
    // 设置tableView视图
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, [navigationBar bottom], self.view.frame.size.width, WindowHeight - [navigationBar bottom] -TabbarHeight)] autorelease];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:self.tableView];
    // 设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 收藏为空视图
    self.emptyView = [CollectEmptyView collectEmptyView];
    // 设置回调方法
    [self.emptyView addTarget:self selectAction:@selector(emptyViewDidSelect:)];
    [self.view addSubview:self.emptyView];
    self.emptyView.hidden = YES;

    [self.view bringSubviewToFront:navigationBar];
}
#pragma mark - navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        CollectEditViewController * editVC = [[CollectEditViewController alloc] init];
        editVC.productList = [NSMutableArray arrayWithArray:self.productList];
        [self.navigationController pushViewController:editVC animated:YES];
        [editVC release];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];

    HttpDownload *hd=[[HttpDownload alloc]init];
    self.thisDownload = hd;
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:Shoucang,serviceHost]];
    hd.type = 11188;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(loadFail);
    [[self mainDelegate] beginLoad];
    
    // 请求推荐商品
    [self askAdjustProductmethod];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.productList removeAllObjects];
    [self.recommendProductList removeAllObjects];
    [self.tableView reloadData];
}
#pragma mark - private methods
- (void)askAdjustProductmethod
{
    HttpDownload *hd=[[HttpDownload alloc]init];
    self.thisDownload = hd;
    hd.delegate = self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:askAdjustProduct,serviceHost]];
    hd.type = 11189;
    hd.method=@selector(downloadComplete:);
    [[self mainDelegate] beginLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    [[self mainDelegate] endLoad];
    [self.thisDownload ConnectionCanceled];
}
-(void)loadFail{
    [[self mainDelegate] endLoad];
}

#pragma mark - Notification-pleaseCancelLoad
#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    [[self mainDelegate] endLoad];
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    if(hd.type==1200) { // 选中一行, 跳转到显示商品详情视图
        if(dict || [[dict allKeys]count]!=0)
        {
            if([[dict objectForKey:@"status"] intValue]==0){
                if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                    [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                    return;
                }
                ProductdetailsViewController *so=[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil];
                so.type = self.productType;
                so.catID = self.productCategoryID;
                so.detailDict = dict;
                [self.navigationController pushViewController:so animated:YES];
                [so release];
            }
        }
        else
        {
            
        }
    }
    if (11188 == hd.type) { // 加载所有收藏商品
        if(dict){
            if([[dict objectForKey:@"status"] intValue]== 0){
                NSArray *array1=[dict objectForKey:@"commodityList"];
                [self.productList removeAllObjects];
                for(int i=0;i<[array1 count];i++){
                    NSDictionary *dict1=[array1 objectAtIndex:i];
                    Product *product = [[Product alloc] init];
                    product.catID = [dict1 valueForKey:@"categoryID"];
                    product.keyWord = [dict1 valueForKey:@"keyWord"];
                    product.commodityName =[dict1 objectForKey:@"commodityName"];
                    product.attrValue =[dict1 objectForKey:@"commodityImage"];
                    product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];//销售价
                    product.sellPrice =[[dict1 objectForKey:@"sellPrice"] floatValue];//市场价
                    product.goodsID = [dict1 objectForKey:@"goodId"];
                    product.keyWord =[dict1 objectForKey:@"keyWord"];
                    product.productID = [dict1 objectForKey:@"ID"] ;
                    product.type = [[dict1 objectForKey:@"type"] intValue];
                    product.productDescription = [dict1 objectForKey:@"description"];//添加商品描述
                    [self.productList addObject:product];
                    [product release];
                }
                // 重新加载数据
                [self.tableView reloadData];
            } else {
              //  [self showError:[NSString stringWithFormat:@"%@",[dict objectForKey:@"msg"]]];
            }
            // 没有收藏商品，不能编辑
            if (self.productList.count < 1) {
                self.navigationBarView.rightButton.hidden = YES;
                self.navigationBarView.rightButtonImageView.hidden = YES;
            } else {
                self.navigationBarView.rightButton.hidden = NO;
                self.navigationBarView.rightButtonImageView.hidden = NO;
            }
        }
    }
    //当收藏中为空时自动推荐商品
    if (11189 == hd.type)
    {
        NSArray *array1=[dict objectForKey:@"recommendCommodity"];
        for(int i=0;i<array1.count;i++){
            //商品
            Product * product = [[[Product alloc] init] autorelease];
            
            product.goodsID = [array1[i] objectForKey:@"id"];
            product.attrValue = [array1[i] objectForKey:@"pic_url"];
            product.commodityName = [array1[i] objectForKey:@"title"];
            product.sellPrice = [[array1[i] objectForKey:@"price"] floatValue];
            product.marketPrice = [[array1[i] objectForKey:@"marketPrice"] floatValue];
            product.keyWord = [array1[i] objectForKey:@"keyWord"];
            [self.recommendProductList addObject:product];
        }
        // 给收藏为空视图传值
        self.emptyView.recommendProductList = self.recommendProductList;
    }
}
#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CollectCell heightOfCell];
}

#pragma mark - UITableView DateSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 商品列表为空
    if (self.productList.count == 0) {
        self.emptyView.hidden = NO;
        self.rightButton.hidden = YES;
    } else {
        self.rightButton.hidden = NO;
        self.emptyView.hidden = YES;
    }
    return self.productList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取缓存
    static NSString *cellName=@"CellItem";
    CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    // 判断
    if (cell == nil) {
        cell = [CollectCell collectCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // 显示商品
    Product * product = [self.productList objectAtIndex:indexPath.row];
    [cell showWithProduct:product];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹出响应的商品信息
    Product * product = [self.productList objectAtIndex:[indexPath row]];
    [self showProductDetail:product];
}
#pragma mark - 显示商品详情方法
- (void)showProductDetail:(Product *)product
{
    //弹出响应的商品信息
    NSString * spID = [[[NSString alloc] initWithFormat:@"%@", product.goodsID] autorelease];
    self.productType = product.type;
    self.productCategoryID = product.catID;
    HttpDownload *hd=[[HttpDownload alloc] init];
    self.thisDownload = hd;
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(loadFail);
    if(self.productType !=0)
    {
       NSString *url=[NSString stringWithFormat:@"%@interface/commidty/allGoogsDisInfo?categoryID=%@&commodityId=%@&type=1",serviceHost,self.productCategoryID,spID];
        [hd downloadFromUrl:url];
        hd.type=1200;
        [[self mainDelegate] beginLoad];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:PRODETAIL_URL, serviceHost, spID];
        [hd downloadFromUrl:str];
        hd.type=1200;
        [[self mainDelegate] beginLoad];
    }
    
}
#pragma mark - 收藏为空视图中推荐商品列表回调方法
- (void)emptyViewDidSelect:(NSNumber *)number
{
    NSInteger index = [number integerValue];
    [self showProductDetail:[self.recommendProductList objectAtIndex:index]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
