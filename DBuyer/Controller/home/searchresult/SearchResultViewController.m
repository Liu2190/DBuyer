//
//  SearchResultViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SearchResultViewController.h"
#import "LeveyTabBarController.h"
#import "SouSuo.h"
#import "BtnDelegate.h"
#import "HttpDownload.h"
#import "SearchNilViewController.h"
// 使用收藏视图的cell
#import "CollectCell.h"
#import "Product.h"
#import "SearchBarView.h"

#import "TProductServer.h"
#import "TServerFactory.h"
#import "TUtilities.h"

@interface SearchResultViewController () <SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,retain)SearchBarView *searchBarView;
@property (nonatomic,retain)UITableView *tableView;
@end

@implementation SearchResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.searchArray = [[NSMutableArray alloc]init];;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=BACKCOLOR;
    // navigationBar
    self.searchBarView = [SearchBarView searchBarView];
    self.searchBarView.delegate = self;
    self.searchBarView.placeHolderLabel.text = [NSString stringWithFormat:@"%@", self.searchString];
    [self.view addSubview:self.searchBarView];

    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, [self.searchBarView bottom], 320, WindowHeight - [self.searchBarView bottom] ) style:UITableViewStylePlain] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=BACKCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - navigationBarView 代理方法
- (void)searchBarDidClickButton:(NSInteger)buttonIndex
{
    // 点击左键或搜索键
    if (buttonIndex == 0 || buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CollectCell heightOfCell];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"CollectCell";
    CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[CollectCell collectCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell showWithProduct:(Product *)[self.searchArray objectAtIndex:[indexPath row]]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *pro = [self.searchArray objectAtIndex:indexPath.row];
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetProductDetailById:pro.productID andCallback:^(NSDictionary *productDict){
        [[TUtilities getInstance]dismiss];
        ProductdetailsViewController *so=[[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
        so.detailDict = productDict;
        so.type = 0;
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

- (void)dealloc {
    self.searchArray = nil;
    [_tableView release];
    [super dealloc];
}
@end
