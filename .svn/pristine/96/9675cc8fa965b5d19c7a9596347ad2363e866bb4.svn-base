//
//  DfkddViewController.m
//  DBuyer
//  待付款订单列表
//  Created by liuxiaodan on 13-9-26.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "DfkddViewController.h"
#import "EditReceivingViewController.h"
#import "EditReceivingViewController.h"
#import "UIImageView+WebCache.h"
#import "Product.h"
#import "Order.h"
#import "BtnDelegate.h"
#import "LeveyTabBarController.h"
#import "WCAlertView.h"
#import "LoadView.h"
#import "WaitBuyerPayOrderCell.h"
#import "OrderFooterView.h"
#import "OrderDetailViewController.h"
#import "ConfirmPaymenViewController.h"
#import "TConfirmPaymentController.h"
#import "StartPoint.h"
#define NAVIGATIONHEIGHT CGRectMake(0, 44, 320, CGRectGetHeight([UIScreen mainScreen].bounds)-104)
#define GoPayButtonTag  9001            // 去付款按钮
#define checkBoxButtonTag   9002        // 复选框按钮

//#import "CheckoutTableViewController.h"

@interface DfkddViewController ()
@property (nonatomic, retain) NSMutableArray *cellArray;

@end

@implementation DfkddViewController
{
    NSMutableArray * orderList;
    UITableView * orderTableView;
    NSInteger delateIndex;
    NSInteger refreshTimes;
    LoadView *thisLoad;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
    NSMutableArray *_orderArray;
    OrderFooterView *_footerView;  //
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        orderList = [[NSMutableArray alloc]init];
        _orderArray = [[NSMutableArray alloc] init];
        _cellArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [orderList removeAllObjects];
    [_orderArray removeAllObjects];
    [[self mainDelegate]endLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    [_footerView clearStatus];
    [_orderArray removeAllObjects];
    [self getDataFromNet];
}
-(void)getDataFromNet
{
    //从网络请求数据
    [mainDelegate beginLoad];;
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:kOrderType_wfk forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryOrderInfo,serviceHost]];
    hd.type =10093;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"待付款订单" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint]-60.0f) style:UITableViewStylePlain];
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:orderTableView];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    self.view.backgroundColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1];
    orderTableView.backgroundColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1];
    _footerView = [OrderFooterView initWithNib];
    [_footerView setTotalPrice:@"0.00" payButtonTitle:@"合并付款" CheckBoxHidden:NO];
    _footerView.frame = CGRectMake(0, WindowHeight - _footerView.frame.size.height, 320, _footerView.frame.size.height);
    [self.view bringSubviewToFront:_footerView];
    [_footerView addTarget:self checkBoxAction:@selector(checkBoxButtonAction:) payAction:@selector(payButtonAction:)];
    [self.view addSubview:_footerView];
}


#pragma mark - FOOTERVIEW 回调方法
#pragma mark 合并付款事件
- (void)payButtonAction:(id)sender
{
    NSString *orderIds = [self getAllOrderId];   // 获取所有的订单ID
    // 判断是否选中复选框
    if (orderIds == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请选择要合并的订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [mainDelegate beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd ;
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:orderIds forKey:@"orderIds"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:MergePayMentOrder,serviceHost]];
    hd.type =100932;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}
#pragma mark checkBox按钮事件
- (void)checkBoxButtonAction:(id)sender
{
    // 判断数量是否相等
    if ([_orderArray count] != [orderList count]) {
        [_orderArray removeAllObjects];
        for (Order *order in orderList) {
            [_orderArray addObject:order];
        }
    } else {
        [_footerView setFooterViewTotalPrice:@"0.00"];
        [_orderArray removeAllObjects];
    }
    // 重新对FooterView的price赋值
    [_footerView setFooterViewTotalPrice:[NSString stringWithFormat:@"%0.2f", [self getAllOrderPrice]]];
    [orderTableView reloadData];
}
#pragma mark 取消订单事件
- (void)orderCancel:(id)sender
{
    WaitBuyerPayOrderCell *cell = (WaitBuyerPayOrderCell*)sender;
    
    //删除
    [WCAlertView showAlertWithTitle:@"确定要删除订单" message:@"删除后无法取回" customizationBlock:^(WCAlertView * alertView1) {
        alertView1.style=WCAlertViewStyleBlack;
    }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
        if(buttonIndex==0){
            [[self mainDelegate] beginLoad];
            thisLoad.beStop=NO;
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.delegate=self;
            hd.method=@selector(downloadComplete:);
            hd.type=10000;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            
            Order * order = [orderList objectAtIndex:cell.indexPath.row];
            delateIndex = cell.indexPath.row;
            [dict setObject:order.orderId forKey:@"ID"];
            [hd getResultData:dict baseUrl:[NSString stringWithFormat:kUpdateOrderStatus,serviceHost]];
            // 删除对应的数据
//            [_orderArray removeObject:cell.order];
//            [orderList removeObjectAtIndex:cell.indexPath.row];
//            [orderTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:cell.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if(buttonIndex==1){
            
        }
    }cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
}

#pragma mark 通过Order获取订单的总价格(用于checkbox)
- (CGFloat)getAllOrderPrice
{
    CGFloat priceCount = 0.00;
    if ([_orderArray count]) {
        for (Order *order in _orderArray) {
//            for (Product *product in [order valueForKey:@"productList"]) {
//                priceCount += [[product valueForKey:@"sellPrice"] floatValue] * [[product valueForKey:@"count"] integerValue];
//            }
            priceCount += order.paidAmount;
        }
    }
    return priceCount;
}
#pragma mark 获取所有订单的ID
- (NSString *)getAllOrderId {
    if ([_orderArray count] == 0) {
        return nil;
    }
    NSMutableArray *orderIdArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (Order *order in _orderArray) {
        [orderIdArray addObject:order.orderId];
    }
    
    NSString * orderIds = [orderIdArray componentsJoinedByString:@","]; // 使用逗号分割数组封装为订单ID字符串
    return orderIds;
}

/**
 * 循环遍历支付的订单，其下商品是否存在vip商品(_card=66)
 * 如果有vip商品，那么跳出遍历程序
 */
- (BOOL)isVipPay {
    BOOL boolean = NO;

    for (Order *order in _orderArray) {
        for (Product *product in order.productList) {
            if([product.catID isEqualToString:@"66"]) return YES;
        }
    }
    
    return boolean;
}

- (NSMutableArray*)generatePayWayList {
    NSMutableArray *paywayList = [[NSMutableArray alloc]init];
    NSDictionary *umpay = @{@"cardType":@"0",@"cardName":@"(银联支付)"};
    NSDictionary *mascnpay = @{@"cardType":@"1",@"cardName":@"(快钱支付)"};
    NSDictionary *allsco = @{@"cardType":@"2",@"cardName":@"(预付卡支付,专享特价优惠)"};
    
    if (![self isVipPay]) {
        [paywayList addObject:umpay];
        [paywayList addObject:mascnpay];
    }
    
    [paywayList addObject:allsco];
    return paywayList;
}

#pragma mark - CELL checkBox 回调
- (void)cellCheckBoxAction:(id)sender
{
    WaitBuyerPayOrderCell *cell = (WaitBuyerPayOrderCell *)sender;
    // 如果数组里有
    if ([_orderArray containsObject:cell.order]) {
        [_orderArray removeObject:cell.order];
        if (_orderArray.count != orderList.count) {
            [_footerView setCheckBoxButtonStatus:NO];
        }
    } else {
        [_orderArray addObject:cell.order];
        if (orderList.count == _orderArray.count) {
            [_footerView setCheckBoxButtonStatus:YES];
        }
    }
//    [orderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:cell.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    // 重新对FooterView的price赋值
    [_footerView setFooterViewTotalPrice:[NSString stringWithFormat:@"%0.2f", [self getAllOrderPrice]]];
}
#pragma mark CELL GoPayAction 回调
- (void)cellGoPayAction:(id)sender {
    NSIndexPath *indexP = (NSIndexPath *)sender;
    Order * order = [orderList objectAtIndex:indexP.row];
    // 因为要多获取一次积分，故使用合并付款接口
    [_orderArray removeAllObjects];     // 删除所有数据
    [_orderArray addObject:order];      // 添加此条数据
    [self payButtonAction:nil];     // 调用合并付款进行相关操作
}


#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview datasource
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       [self orderCancel:[orderTableView cellForRowAtIndexPath:indexPath]];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (orderList.count==0 && refreshTimes >0)
    {
        UIAlertView * al = [[ UIAlertView alloc ]initWithTitle:@"提示" message:@"没有待收货订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
        [ al show ];
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return orderList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 158.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"WaitBuyerPayOrderCell";
    WaitBuyerPayOrderCell * cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    Order * order = [orderList objectAtIndex:indexPath.row];
    if(!cell){
        cell = [[WaitBuyerPayOrderCell alloc] initWithNib];
    }
        [cell setCellValue:order];
        cell.indexPath = indexPath;
    //}
    
    // 判断是否选中(checkBox)
    if ([_orderArray containsObject:order]) {
        [cell setCheckBoxButtonStatus:YES];
    } else {
        [cell setCheckBoxButtonStatus:NO];
    }
    // 添加回调
    [cell addTarget:self payAction:@selector(cellGoPayAction:) checkBoxAction:@selector(cellCheckBoxAction:) cancelAction:@selector(orderCancel:)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WaitBuyerPayOrderCell *cell = (WaitBuyerPayOrderCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.timeOut) {
        cell.userInteractionEnabled = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"订单失效提示信息" message:@"该订单由于在小时内未支付，已无法支付，请至购物车再次购买" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [orderTableView reloadData];
    } else {
        
        OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
        Order * order = [orderList objectAtIndex:indexPath.row];
        // 此处与上边的Cell goPay一样，因为要使用积分，故此处使用合并付款接口进行操作。
        // 逻辑： 点击Cell 删除所有_orderArray ，然后把取得的order加入_orderArray，如果详情页面使用了goPay按钮，则调用此控制器的合并付款操作。
        [_orderArray removeAllObjects];
        [_orderArray addObject:order];
        //　添加详情页面的付款回调方法。
        [orderDetailVC addTarget:self Action:@selector(orderDetailGoPaymentAction:)];
        orderDetailVC.orderId = order.orderId;
        orderDetailVC.orderDetailType = WaitBuyerPayOrderDetail;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
}

#pragma mark 订单详情页面付款按钮的回调方法
- (void)orderDetailGoPaymentAction:(Order *)order
{
    [_orderArray addObject:order];
    [self payButtonAction:nil];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title = @"删除";
    return title;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
   
}

#pragma mark - private methods

-(NSMutableDictionary *)httpDic{
    //网络请求固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
}
#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if( [alertView.title isEqualToString:@"订单失效提示信息"]){
        //[self.navigationController popViewControllerAnimated:YES];
    } else if([alertView.message isEqualToString:@"没有待收货订单"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [mainDelegate endLoad];
        [orderTableView reloadData];
    }
    
}
#pragma mark - 下载数据

-(void)downloadComplete:(HttpDownload *)hd1
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        if(hd1.type==10000)
        {
            //获取删除订单的结果，并进行页面刷新处理
            if([[dict objectForKey:@"status"] intValue]==0)
            {
                [_orderArray removeObject:[orderList objectAtIndex:delateIndex]];
                [orderList removeObjectAtIndex:delateIndex];
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:delateIndex inSection:0];
                if (delateIndex != 0)
                {
                    [orderTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:self userInfo:nil];
                [orderTableView reloadData];
                [[self mainDelegate] endLoad];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[dict objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                thisLoad.beStop=YES;
                [[self mainDelegate] endLoad];
                return;
            }
        }
        if(hd1.type==10093)
        {
            //接收订单列表信息
            if([[dict objectForKey:@"status"] intValue]==0)
            {
                NSArray * orderInfoList = [dict objectForKey:@"orderInfoList"];
                if (orderInfoList.count==0)
                {
                    [mainDelegate endLoad];
                    [_footerView removeFromSuperview];
                }
                for (NSDictionary * item in orderInfoList)
                {
                    if([[item objectForKey:@"goodsList"] count]==0)
                    {
                        
                    }else
                    {
                        Order * order = [[Order alloc]initOrderWithOrderDic:item];
                        [orderList addObject:order];
                    }
                }
                refreshTimes++;
                [orderTableView reloadData];
                [[self mainDelegate] endLoad];
            }
        }
        if (hd1.type == 100932)
        {   // 合并付款事件
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0) {
                NSArray *paywayList = [dict objectForKey:@"wayList"];
                if (paywayList == nil && paywayList.count == 0) {
                    paywayList = [self generatePayWayList];
                }

                NSString *orderIdList = [self getAllOrderId];
                NSString *paidAmount = [[[dict objectForKey:@"resultList"]objectAtIndex:0]objectForKey:@"amountAll"];
                TConfirmPay *confirmPay = [[TConfirmPay alloc]init];
                confirmPay.orderIdList = orderIdList;
                confirmPay.paidAmount = [NSString stringWithFormat:@"%@",paidAmount];
                confirmPay.payWays = paywayList;
                confirmPay.integral = [[[dict objectForKey:@"resultList"] objectAtIndex:0]objectForKey:@"integralAll"];
                TConfirmPaymentController *conVC = [[TConfirmPaymentController alloc]initWithNavigationTitle:@"支付方式" andConfirPay:confirmPay];
                [self.navigationController pushViewController:conVC animated:YES];
                [conVC release];
                
                
                [[self mainDelegate] endLoad];
            }
        }
    } 
}

#pragma mark - WaitOrderCell代理
- (void)timerInvalidate
{
    [orderTableView reloadData]; // 定时器完成，刷新页面
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
