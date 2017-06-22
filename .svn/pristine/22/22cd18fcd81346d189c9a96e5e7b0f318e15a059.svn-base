//
//  DfhddViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-26.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "DfhddViewController.h"
#import "EditReceivingViewController.h"
#import "UIImageView+WebCache.h"
#import "Product.h"
#import "WCAlertView.h"
#import "Order.h"
#import "LeveyTabBarController.h"
#import "Login.h"
#import "HttpDownload.h"
#import "FinishOrderCell.h"
#import "OrderDetailViewController.h"
#import "OrderTraceViewController.h"
#import "StartPoint.h"
#define ORDERTABLEVIEW_FRAME CGRectMake(0, 64, 320, CGRectGetHeight([UIScreen mainScreen].bounds)-54)
#define ViewBackGroundColor [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1]


@interface DfhddViewController ()

@end

@implementation DfhddViewController
{
    NSMutableArray * orderList;
    UITableView * orderTableView;
    Login *lView;
    UIScrollView *scro;
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self mainDelegate]endLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self mainDelegate] beginLoad];
    //向网络请求待发货订单List
    orderList=[[NSMutableArray alloc]init];
    lView=[[[NSBundle mainBundle]loadNibNamed:@"Login" owner:self options:nil]lastObject];
    lView.backgroundColor=ViewBackGroundColor;
    lView.denglu.text=@"待收货订单";
    lView.denglu.textColor=TITLECOLOR;
    lView.delegate=self;
    [lView.btn1 setImage:[UIImage imageNamed:@"切片绿_向左"] forState:UIControlStateNormal];
    [lView.btn1 setImage:[UIImage imageNamed:@"切片绿_向左1"] forState:UIControlStateHighlighted];
    [self.view addSubview:lView];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:kOrderType_dsh forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryOrderInfo,serviceHost]];
    hd.type =10094;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    [self setNavigationBarWithContent:@"待收货订单" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    self.view.backgroundColor=ViewBackGroundColor;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return orderList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"FinishOrderCell";
    FinishOrderCell * cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell = [FinishOrderCell initWithNib];
        [cell setFinishOrderCellType:ORDERCONSIGNEE];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Order * order = [orderList objectAtIndex:indexPath.row];
    if([[order productList] count]!=0){
        if([self IsEmptyOfString:[[[order productList] objectAtIndex:0] attrValue]]==NO){
            NSString * imgePath = [[[order productList] objectAtIndex:0] attrValue];
            [cell.goodsImage setImageWithURL:[NSURL URLWithString: imgePath]];
        }
    }
    NSMutableString * orderName =[[NSMutableString alloc]init];
    NSInteger goodsCount=0;
    CGFloat totalPrice=0.0f;
    BOOL isGift=NO;
    for (Product * item  in order.productList) {
        if (![orderName hasSuffix:item.commodityName]) {
            [orderName appendFormat:@"%@ ",item.commodityName];
        }
        goodsCount+=item.count;
        totalPrice+=item.count*item.sellPrice;
        if(item.buyType==8){
            cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f",item.amountPayable];
            isGift=YES;
        }
    }
    [cell addTarget:self Action:@selector(logisticsTrace:)];
    cell.goodsTitle.text = orderName;
    cell.goodsCount.text = [NSString stringWithFormat:@"%d",goodsCount];
    cell.indexPath = indexPath;
    cell.orderNumber.text = order.orderId;
    if(isGift==NO){
        cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f",order.paidAmount];
    }
    cell.contentView.backgroundColor=ViewBackGroundColor;
    cell.backgroundColor = ViewBackGroundColor;
    return cell;
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self pleaseCancelLoad];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 物流追踪事件
- (void)logisticsTrace:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    Order *order=[orderList objectAtIndex:indexPath.row];
    OrderTraceViewController *TraceVC = [[OrderTraceViewController alloc] initWithNibName:@"OrderTraceViewController" bundle:nil];
    [TraceVC setOrder:order];
    [self.navigationController pushViewController:TraceVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    Order *order = [orderList objectAtIndex:indexPath.row];
    orderVC.orderId = order.orderId;
    orderVC.orderDetailType = WaitConsigneeDetail;
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark - private methods

-(NSMutableDictionary *)httpDic{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}
#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if( [alertView.message isEqualToString:@"没有待收货订单"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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


#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd1{
 
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        if(hd1.type==10094){
            
            if([[dict objectForKey:@"status"] intValue]==0){
                
                NSArray * orderInfoList = [dict objectForKey:@"orderInfoList"];
                
                if (orderInfoList.count==0) {
                    [mainDelegate endLoad];
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有待收货订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                for (NSDictionary * item in orderInfoList) {
                    if([[item objectForKey:@"goodsList"] count]==0){
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有待收货订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        return;
                    }else
                    {
                        Order * order = [[Order alloc]initOrderWithOrderDic:item];
                        [orderList addObject:order];
                    }
                }
                [mainDelegate endLoad];
                orderTableView = [[UITableView alloc]initWithFrame:/*ORDERTABLEVIEW_FRAME*/CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
                orderTableView.dataSource = self;
                orderTableView.delegate = self;
                orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                orderTableView.backgroundColor=ViewBackGroundColor;
                [self.view addSubview:orderTableView];
                [orderTableView reloadData];
            }
            [[self mainDelegate] endLoad];
        }
    }
}


@end
