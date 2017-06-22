//
//  PlanDiscViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-22.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanDiscViewController.h"
#import "CollectCell.h"
#import "StartPoint.h"
#import "Product.h"
#import "ProductdetailsViewController.h"
#import "PlanToDiscountModel.h"
@interface PlanDiscViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *mainDelegate;
    UITableView *userTable;
    HttpDownload *thisDownLoad;
    NSString *categoryID;
}
@property (nonatomic,retain)PlanToDiscountModel *discModel;
@end

@implementation PlanDiscViewController
@synthesize userArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        categoryID = [[NSString alloc]init];
        self.discModel = [[PlanToDiscountModel alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [mainDelegate endLoad];
    [super viewWillAppear: animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    [mainDelegate beginLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self setNavigationBarWithContent:@"折扣信息列表" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    userTable=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, self.view.frame.size.height-[StartPoint startPoint]-TabbarHeight) style:UITableViewStylePlain];
    userTable.delegate=self;
    userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    userTable.backgroundColor=[UIColor clearColor];
    userTable.dataSource=self;
    [self.discModel setDisArrayWith:userArray];
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
    return [self.discModel.disArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"CellItem";
    CollectCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell = [CollectCell collectCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Product *product = [self.discModel.disArray objectAtIndex:indexPath.row];
    [cell showWithProduct:product];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //折扣列表进入商品详情
    Product *product = [self.discModel.disArray objectAtIndex:indexPath.row];
    categoryID = product.catID;
    NSString *discUrl=[NSString stringWithFormat:quickEntranceToPro,serviceHost];
    NSString *discContentUrl=[NSString stringWithFormat:@"categoryID=%@&commodityId=%@&type=1",categoryID,product.productID];
    NSString *ToDetailUrl=[NSString stringWithFormat:@"%@?%@",discUrl,discContentUrl];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.type=1200;
    thisDownLoad = hd;
    [hd downloadFromUrl:ToDetailUrl];
    [mainDelegate beginLoad];
}
-(void)leftButtonClick:(UIButton *)button{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
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
                so.catID = categoryID;
                so.type = 1;
                so.detailDict = dict;
                [self.navigationController pushViewController:so animated:YES];
            }
        }
    }
}


@end
