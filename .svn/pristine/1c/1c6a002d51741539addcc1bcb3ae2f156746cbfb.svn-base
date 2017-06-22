//
//  RecommendViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "RecommendViewController.h"
#import "NavigationBarView.h"
#import "StartPoint.h"
#import "ProductCell.h"
#import "Product.h"
#import "ProductdetailsViewController.h"

#import "ShoppingCartServer.h"
#import "TProductServer.h"
#import "TServerFactory.h"
#import "TUtilities.h"


@interface RecommendViewController ()<NavigationBarViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NavigationBarView *navigationView;
@property (nonatomic,retain)UITableView *table;
@property (nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation RecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.[self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor=BACKCOLOR;
    self.navigationView = [NavigationBarView navigationBarView];
    [self.navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"] rightImage:nil titleImage:nil title:@"BHG推荐"];
    self.navigationView.delegate = self;
    [self.view addSubview:self.navigationView];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight-TabbarHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
    self.table.backgroundColor=BACKCOLOR;
    self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    self.table.delegate=self;
    self.table.dataSource=self;
    [self getDataFromNet];
}
-(void)getDataFromNet
{
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"ShoppingCartServer"]doGetRecommendFromCartBycallback:^(NSArray *arr){
        [[TUtilities getInstance]dismiss];
        [self.dataArray addObjectsFromArray:arr];
        [self.table reloadData];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
    }];
}
#pragma mark navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"CellItem";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductCell" owner:self options:nil]lastObject];
    }
    [cell showWithProduct:[self.dataArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *pro = [self.dataArray objectAtIndex:indexPath.row];
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TProductServer"]doGetProductDetailById:pro.productID andCallback:^(NSDictionary *dict){
        [[TUtilities getInstance]dismiss];
        ProductdetailsViewController *proVC = [[ProductdetailsViewController alloc]initWithNibName:@"ProductdetailsViewController" bundle:nil];
        proVC.detailDict = dict;
        proVC.type = 0;
        [self.navigationController pushViewController:proVC animated:YES];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
