//
//  ScanSearchViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-11-26.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ScanSearchViewController.h"
#import "SouSuo.h"
#import "ProductdetailsViewController.h"
#import "CollectCell.h"
#import "StartPoint.h"
#import "Product.h"

@interface ScanSearchViewController ()

@end

@implementation ScanSearchViewController
@synthesize searchArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [mainDelegate endLoad];
    [super viewWillAppear: animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    [mainDelegate beginLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self setNavigationBarWithContent:@"扫描列表" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    userTable=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, self.view.frame.size.height-[StartPoint startPoint]-TabbarHeight) style:UITableViewStylePlain];
    userTable.delegate=self;
    userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    userTable.backgroundColor=[UIColor clearColor];
    userTable.dataSource=self;
    [self.view addSubview:userTable];
}
#pragma mark 网络请求失败
-(void)downloadFail{
    
    [mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CollectCell heightOfCell];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [searchArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"CellItem";
    NSDictionary *dic = [searchArray objectAtIndex:[indexPath row]];
    CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell = [CollectCell collectCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Product * product = [[Product alloc] init];
    product.commodityName = [dic objectForKey:@"commodityName"];
    product.attrValue = [dic objectForKey:@"commodityImage"];
    product.sellPrice = [[dic objectForKey:@"sellPrice"] floatValue];
    product.marketPrice = [[dic objectForKey:@"marketPrice"] floatValue];
    product.productDescription = [dic objectForKey:@"description"];
    [cell showWithProduct:product];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str=[[NSString alloc]init];
    str=[NSString stringWithFormat:PRODETAIL_URL,serviceHost,[[searchArray objectAtIndex:indexPath.row]objectForKey:@"ID"]];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    [hd downloadFromUrl:str];
    hd.type=1200;
    thisDownLoad = hd;
    [mainDelegate beginLoad];
}
-(void)leftButtonClick:(UIButton *)button{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        [mainDelegate endLoad];
        if(hd.type==1200){
            if ([[[dict objectForKey:@"mapinfo"]objectForKey:@"status"] integerValue] == 1) {
                NSString *str = [[dict objectForKey:@"mapinfo"]objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = 2;
                [alert show];
                return;
            }
            if([[dict objectForKey:@"status"] intValue]==0){

                if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                    
                    [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                    return;
                }
                
                ProductdetailsViewController *so=[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil];
                so.detailDict = dict;
                //                so.shangpinID=@"1";
                [self.navigationController pushViewController:so animated:YES];
            }
        }
    }
}
@end
