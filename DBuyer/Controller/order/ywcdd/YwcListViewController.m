//
//  YwcListViewController.m
//  DBuyer
//  
//  Created by lixinda on 13-11-18.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "YwcListViewController.h"
#import "UIImageView+WebCache.h"
#import "Product.h"
#import "Order.h"
#import "BtnDelegate.h"
#import "LeveyTabBarController.h"
#import "WCAlertView.h"
#import "FinishOrderCell.h"
#import "OrderDetailViewController.h"
#import "StartPoint.h"
#define ORDERTABLEVIEW_FRAME CGRectMake(0, 64, 320, CGRectGetHeight([UIScreen mainScreen].bounds)-64)
#define ViewBackGroundColor [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1]

@interface YwcListViewController ()


@property (nonatomic, retain) UITableView * orderTableView;
@end

@implementation YwcListViewController
{
    NSMutableArray *orderList;
    NSInteger delateIndex;
    NSInteger refreshTimes;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    int countForCart;
    int countOfOrder;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        orderList = [[NSMutableArray alloc]init];
        countForCart = 0;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [orderList removeAllObjects];
    [self getDataFromNet];
}
-(void)getDataFromNet
{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.failMethod = @selector(downloadFail);
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:kOrderType_ywc forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryOrderInfo,serviceHost]];
    hd.type =10093;
    hd.method=@selector(downloadComplete:);
    [mainDelegate beginLoad];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    mainDelegate=[self mainDelegate];
	// Do any additional setup after loading the view.
    [self addLoadView];
    [self setNavigationBarWithContent:@"已完成订单" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint],WindowWidth,WindowHeight-[StartPoint startPoint] ) style:UITableViewStylePlain];
    _orderTableView.dataSource = self;
    _orderTableView.delegate = self;
    _orderTableView.backgroundColor=ViewBackGroundColor;
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_orderTableView];
    self.view.backgroundColor = ViewBackGroundColor;
}

#pragma mark 网络请求失败
-(void)downloadFail
{
    [mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (orderList.count==0 && refreshTimes >0)
    {
        UIAlertView * al = [[ UIAlertView alloc ]initWithTitle:@"提示" message:@"没有已完成订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
        [ al show ];
    }
    return 1;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title = @"删除";
    return title;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self orderCancel:[_orderTableView cellForRowAtIndexPath:indexPath]];
    }
    
}
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
    FinishOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell = [FinishOrderCell initWithNib];
        [cell setFinishOrderCellType:FINISHORDERCELL];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Order * order = [orderList objectAtIndex:indexPath.row];
    if([[order productList] count]!=0)
    {
        if([self IsEmptyOfString:[[[order productList] objectAtIndex:0] attrValue]]==NO)
        {
            NSString * imgePath = [[[order productList] objectAtIndex:0] attrValue];
            [cell.goodsImage setImageWithURL:[NSURL URLWithString: imgePath]];
        }
    }
    NSMutableString *orderName =[[NSMutableString alloc]init];
    NSInteger goodsCount=0;
    CGFloat totalPrice=0.0f;
    BOOL isGift=NO;
    for (Product * item  in order.productList)
    {
        if (![orderName hasSuffix:item.commodityName]){
            [orderName appendFormat:@"%@ ",item.commodityName];
        }
        goodsCount+=item.count;
        totalPrice+=item.count*item.sellPrice;
        if(item.buyType==8) {
            cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f",item.amountPayable];
            isGift=YES;
        }
    }
    cell.orderNumber.text = order.orderId;
    cell.goodsTitle.text = orderName;
    cell.goodsCount.text = [NSString stringWithFormat:@"%d",goodsCount];
    if(isGift==NO)
    {
        cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f",order.paidAmount];
    }
    cell.planButton.userInteractionEnabled=YES;
    [cell.planButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.planButton setBackgroundImage:[UIImage imageNamed:@"order_confirm_but"] forState:UIControlStateNormal];
    [cell addTarget:self Action:@selector(addToPlanAction:)];
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    orderDetailVC.orderId = [[orderList objectAtIndex:indexPath.row] orderId];
    orderDetailVC.orderDetailType = DidFinishOrderDetail;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
-(void)orderCancel:(id)sender
{
    FinishOrderCell * cell = (FinishOrderCell *)sender;
    //删除
    [WCAlertView showAlertWithTitle:@"确定要删除订单" message:@"删除后无法取回" customizationBlock:^(WCAlertView * alertView1) {
        alertView1.style=WCAlertViewStyleBlack;
    }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView)
    {
        if(buttonIndex==0)
        {
            [mainDelegate beginLoad];
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.delegate=self;
            thisDownLoad = hd ;
            hd.method=@selector(downloadComplete:);
            hd.type=10000;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            Order * order = [orderList objectAtIndex:cell.indexPath.row];
            delateIndex = cell.indexPath.row;
            [dict setObject:order.orderId forKey:@"ID"];
            [hd getResultData:dict baseUrl:[NSString stringWithFormat:kDeletShop,serviceHost]];
        }
        if(buttonIndex==1)
        {
            
        }
    }cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];

}
#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton*)button
{
    [mainDelegate endLoad];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods

-(NSMutableDictionary *)httpDic
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( [alertView.message isEqualToString:@"没有已完成订单"]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if(alertView.tag == 1)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            [self.leveyTabBarController setSelectedIndex:3];
        }
    }
}

#pragma mark - 下载数据

-(void)downloadComplete:(HttpDownload *)hd1
{
    [mainDelegate endLoad];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        if(hd1.type==10000)
        {
            if([[dict objectForKey:@"status"] intValue]==0)
            {

                [orderList removeObjectAtIndex:delateIndex];
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:delateIndex inSection:0];
                if (delateIndex != 0)
                {
                    [_orderTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
                [_orderTableView reloadData];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[dict objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return;
            }
        }
        if(hd1.type == 1989)
        {
            if([[dict objectForKey:@"status"]intValue]==0)
            {
                [self.leveyTabBarController addNumToCarList:[[dict objectForKey:@"count"] stringValue]];
            }
        }
        if (hd1.type == 10089)
        {
            countForCart ++;
            if(countForCart == countOfOrder)
            {
                countForCart = 0;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您订单内的商品已成功加入购物车" delegate:self cancelButtonTitle:@"继续逛" otherButtonTitles:@"去购物车", nil];
                alertView.tag = 1;
                [alertView show];
            }
            [self getShoppingCarNumFromNet];
            
        }
        if(hd1.type==10093){
            if([[dict objectForKey:@"status"] intValue]==0){
                NSArray * orderInfoList = [dict objectForKey:@"orderInfoList"];
                for (NSDictionary * item in orderInfoList) {
                    if([[item objectForKey:@"goodsList"] count]==0){
                        
                    }else
                    {
                        Order * order = [[Order alloc]initOrderWithOrderDic:item];
                        [orderList addObject:order];
                    }
                }
                refreshTimes++;
                [_orderTableView reloadData];
            }
        }
    }
}

#pragma mark 按钮事件
- (void)addToPlanAction:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    Order *order = [orderList objectAtIndex:indexPath.row];
    [self addToPlan:order];
}

#pragma mark - private methods
-(NSMutableDictionary *)dictForInsertToCartWithType:(NSString *)type AndCategory :(NSString *)categoryID AndId:(NSString *)ID AndCount:(NSString *)count
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",type,@"type",ID,@"id",count,@"count",nil];
    if(categoryID!=nil && [categoryID length]>0)
    {
       [dict setValue:categoryID forKey:@"categoryID"];
    }
    return dict;
}
#pragma mark 再次购买
-(void) addToPlan:(Order *)order
{
    countOfOrder = [order.productList count];
    // 需求变更  再次购买
    for(int i = 0 ; i < [order.productList count] ; i++)
    {
        Product * proFromOrder = [ order.productList objectAtIndex:i ];
        HttpDownload * hd = [[HttpDownload alloc]init];
        thisDownLoad = hd ;
        hd.delegate = self;
        NSString * type = [NSString stringWithFormat:@"%d",proFromOrder.type];
        NSString * categoryID = proFromOrder.catID;
        NSString * proID = proFromOrder.productID;
        NSString * proCount = [NSString stringWithFormat:@"%d",proFromOrder.count];
        NSMutableDictionary * dict = [self dictForInsertToCartWithType:type AndCategory:categoryID AndId:proID AndCount:proCount];
        NSString * url = [NSString stringWithFormat:insertToGoods,serviceHost];
        [hd getResultData:dict baseUrl:url];
        hd.type = 10089;
        hd.method = @selector(downloadComplete:);
        hd.failMethod = @selector(downloadFail);
        [mainDelegate beginLoad];
    }
}

@end
