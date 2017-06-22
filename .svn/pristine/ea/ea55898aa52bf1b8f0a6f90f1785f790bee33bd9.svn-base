//
//  OrderDetailViewController.m
//  DBuyer
//  各种订单详情页面
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCellViewCell.h"
#import "OrderDetailSectionHeader.h"
#import "OrderFooterView.h"
#import "OrderDetailTableViewHeader.h"
#import "AddressItem.h"
#import "Product.h"
#import "OrderDetailFooterView.h"
#import "ConfirmPaymenViewController.h"
#import "OrderTraceViewController.h"
#import "StartPoint.h"


@interface OrderDetailViewController () {
    NSDictionary *_headerViewDic;
    NSInteger goodsCount;
    
    LoadView *thisLoad;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    CGFloat _payable;                   // 总价格
    OrderDetailSectionHeader *_sectionHeaderview;
    
    NSInteger _zhGetTime_Start;     // 订单开始时间
    NSInteger _zhGetTime_End;       // 自提结束时间
    
    /**
     * 付款按钮的回调事件
     */
    id _target;
    
    /**
     * 要执行的方法
     */
    SEL _action;
}

@end



@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        goodsCount = 20;
        _goodsList = [[NSMutableArray alloc] init];
        _addressItem = [[AddressItem alloc] init];
        self.getOrderTime = [[NSString alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_goodsList removeAllObjects];
    self.getOrderTime = @"";
    _networkStatus = 0;
    [self getCheckoutInfo];
    [self addLoadView];

    mainDelegate = [self mainDelegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewHandle];
}

#pragma mark - loadViewHandel
- (void)loadViewHandle {
    [self setNavigationBarWithContent:@"订单详情" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    self.view.backgroundColor = [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight - 60 - [StartPoint startPoint])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailTableViewHeader" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView = _tableHeaderView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    // Footer
    _footerView = [[OrderFooterView alloc] initWithTotalPrice:@"" payButtonTitle:@"" CheckBoxHidden:YES];
    _footerView.frame = CGRectMake(0, WindowHeight - _footerView.frame.size.height, 320, _footerView.frame.size.height);
    [self.view addSubview:_footerView];
    
    // _detailFooterView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailFooterView" owner:nil options:nil] lastObject];
    // _tableView.tableFooterView = _detailFooterView;
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0f;
}

#pragma mark section Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _sectionHeaderview = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailSectionHeader" owner:nil options:nil] lastObject];
    
    if (_logisticsType == 0) { // 如果是物流
        NSString *transportationPrice = [NSString stringWithFormat:@"运费： %0.2f 元", _transportation];
        [_sectionHeaderview setHeaderViewDataWithTitle:@"物流" content:transportationPrice];
        
    } else { // 如果是自提
        NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.getOrderTime integerValue]];
        [formatter setDateFormat:@"yyyy-MM-dd HH"];
        NSMutableString *strr = [NSMutableString stringWithString:[formatter stringFromDate:date]];
        [strr appendString:@" 点"];
        [_sectionHeaderview setHeaderViewDataWithTitle:@"自提时间" content:strr];
    }
    
    [_sectionHeaderview.backGroundView setImage:[UIImage imageNamed:@"order_top_gray1"]];
    return _sectionHeaderview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_goodsList count];
}

#pragma mark cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *Identifier = @"OrderDetailCell";
    OrderDetailCellViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCellViewCell" owner:nil options:nil] lastObject];
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }

    Product *product = [_goodsList objectAtIndex:indexPath.row];
    [cell setCellWithProduct:product];
    
    if (indexPath.row == 0) {
        cell.line.hidden = YES;
    }
    
    if (indexPath.row != _goodsList.count - 1) {
        cell.buttomBackGroundView.backgroundColor = [UIColor whiteColor];
    } else { // 如果是最后一行，那么设置圆角
        CGRect cellButtomFrame = cell.buttomBackGroundView.frame;
        cell.buttomBackGroundView.frame = CGRectMake(cellButtomFrame.origin.x, cellButtomFrame.origin.y, cellButtomFrame.size.width, cellButtomFrame.size.height-5);
        [cell.buttomBackGroundView setImage:[UIImage imageNamed:@"buttom_raduis"]];
    }
    
    return cell;
}

#pragma mark - 网络请求
-(NSMutableDictionary *)httpDic{
    //网络请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}

-(void)downloadComplete:(HttpDownload *)hd1{
    NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    if(dict){
        [mainDelegate endLoad];
        if(hd1.type==1989) {
            if([[dict objectForKey:@"status"] intValue]==0){
                [self.leveyTabBarController addNumToCarList:[[dict objectForKey:@"count"] stringValue]];
            }
        }
        
        if(hd1.type==1200){ //接收商品详细的信息，并进行跳转
            if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                return;
            }
        }
        
        #pragma mark 订单信息
        if(hd1.type==10097){ //接收订单信息
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            
            if(states==0){
                _paidAmount = [[dict objectForKey:@"paidAmount"] floatValue];
                NSString * max = [dict objectForKey:@"maxPoints"];
                _maxPoints = max.integerValue;  // 可以用积分
                NSString * temp = [dict objectForKey:@"usejf"];//您本次使用的积分
                _integral = temp.integerValue;  // 总积分
                
                NSString *intergera = [NSString stringWithFormat:@"%ld", (long)_integral];
                NSString *price = [NSString stringWithFormat:@"%@ 元", temp];
                [_detailFooterView setOrderDetailFooterViewWithIntegra:intergera price:price];
                
                [dict setObject:[dict valueForKey:@"orderId"] forKey:@"ID"]; // 订单ID做成订单编号 ？？？？
                
                _order = [[Order alloc] initOrderWithOrderDic:dict];
                NSArray * orderList = [dict objectForKey:@"goodsList"];
                for (NSDictionary * item in orderList) {
                    _logisticsType = [[item objectForKey:@"logisticsType"] integerValue]; // 运输类型
                    _transportation=[[item objectForKey:@"transportation"] floatValue];  // 邮费
                    _buyType=[[item objectForKey:@"buyType"] stringValue];           // 购买类型
                    
                    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",[item objectForKey:@"getDate"]];
                    if([str1 length]>10){
                        NSString *str = [str1 substringWithRange:NSMakeRange(0, 10)];
                        self.getOrderTime = str;
                    }
                    
                    #define TypeOfPackage 8 //订单为礼包类型
                    if([_buyType intValue]==TypeOfPackage){
                        _amountPayable=[item objectForKey:@"amountPayable"];
                    }
                    //当订单为礼包时，总价不用计算。
                    Product * product = [[Product alloc]initProductWithDic:item];
                    [_goodsList addObject:product];
                }
                
                // 设置SectionHeadView
                if (_orderDetailType == DidFinishOrderDetail) { // 完成
                    [_footerView setDidFinishOrderDetailView];
                } else if (_orderDetailType == WaitBuyerPayOrderDetail) {  // 等待支付
                    [_footerView setFooterviewPayTitle:WaitBuyerPayOrderDetailFooterTitle];
                    [_footerView addTarget:self checkBoxAction:nil payAction:@selector(GoPayAction:)];
                } else if (_orderDetailType == WaitConsigneeDetail) {   // 等待收货
                    [_footerView setFooterviewPayTitle:WaitConsigneeDetailFooterTitle];
                    [_footerView addTarget:self checkBoxAction:nil payAction:@selector(logisticsTrace:)];
                    [_footerView setWaitConsigneeDetailView];
                }
                
                _addressItem.orderNumber = [dict objectForKey:@"ID"];
                if (_logisticsType == 1) { // 如果是_logisticsType 自提
                    NSDictionary *addressItem = [[dict objectForKey:@"shopName"] lastObject];
                    _addressItem.name = [addressItem objectForKey:@"name"];
                    _addressItem.storesAdd = [addressItem objectForKey:@"address"];
                
                } else { // 是物流
                    NSArray *goodsListArr = [dict objectForKey:@"goodsList"];
                    NSString *addressItem = [[goodsListArr objectAtIndex:0] objectForKey:@"areaAdd"];
                    NSArray *addArr = [addressItem componentsSeparatedByString:@"dbuyer@"];
                    if([addArr count]!=0){
                        _addressItem.name = [addArr objectAtIndex:0];
                        if([addArr count]>1){
                            _addressItem.phoneNumber = [addArr objectAtIndex:1];
                        }
                        
                        if ([addArr count] == 4) {
                            _addressItem.storesAdd = [NSString stringWithFormat:@"%@%@", [addArr objectAtIndex:3], [addArr objectAtIndex:2]];
                        } else {
                            if(addArr.count > 2){
                                _addressItem.storesAdd = [NSString stringWithFormat:@"%@", [addArr objectAtIndex:2]];
                            }
                        }
                    }
                }
                [_tableHeaderView setHeaderViewDataWithAddressItem:_addressItem logisticPattern:_logisticsType];
                _networkStatus++;
                [self countTotalPariceWithPoint:0];
                [mainDelegate endLoad];
                [_tableView reloadData];
            }
        }
    }
}

#pragma mark 计算总价
-(void)countTotalPariceWithPoint:(NSInteger) point{
    NSString *totalPriceText = nil;
    CGFloat totalPrice = 0.0f;
    
    if([_buyType intValue]==TypeOfPackage){ // 礼包总价
        totalPrice = [_amountPayable floatValue]+_transportation ;
        totalPriceText = [NSString stringWithFormat:@"%.2f", totalPrice];
        
    } else { //
        for (Product * item in _goodsList) totalPrice += item.sellPrice*item.count;
        totalPriceText = [NSString stringWithFormat:@"%0.2f", totalPrice + _transportation ];
    }
    
    _order.paidAmount = [totalPriceText floatValue];
    [_footerView setFooterViewTotalPrice:totalPriceText];
}

#pragma mark 取得订单信息
-(void)getCheckoutInfo{ //向网络请求待付款订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:self.orderId forKey:@"orderId"];
    if(_orderDetailType==WaitBuyerPayOrderDetail){
        [dict setObject:@"0" forKey:@"type"];// 等待支付
    } else if(_orderDetailType==DidFinishOrderDetail){
        // 已经完成
        [dict setObject:@"3" forKey:@"type"];
    } else if(_orderDetailType==WaitConsigneeDetail){
        //待收货
        [dict setObject:@"2" forKey:@"type"];
    }
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryOrder,serviceHost]];
    hd.type =10097;
    hd.failMethod=@selector(downloadFail);
    hd.method=@selector(downloadComplete:);
    [mainDelegate beginLoad];
}

#pragma mark 取得积分点数
-(void)getUserPoints {
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:self.orderId forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:queryUserInfor,serviceHost]];
    hd.type =10099;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    [mainDelegate beginLoad];
}

#pragma mark 取得地址信息
-(void) requestCheckInfo {
    [mainDelegate beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:self.orderId forKey:@"orderId"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryResultIntegral,serviceHost]];
    hd.type =10098;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    [mainDelegate beginLoad];
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

#pragma mark 物流追踪事件
- (void)logisticsTrace:(id)sender {
    OrderTraceViewController *TraceVC = [[OrderTraceViewController alloc] initWithNibName:@"OrderTraceViewController" bundle:nil];
    [TraceVC setOrder:_order];
    [self.navigationController pushViewController:TraceVC animated:YES];
}

#pragma mark GoPayAction 回调
- (void)GoPayAction:(id)sender {
    if (_action && _target) {
        [_target performSelector:_action withObject:_order];
    }
}

- (void)addTarget:(id)target Action:(SEL)action {
    _target = target;
    _action = action;
}

- (void)dealloc {
    [super dealloc];
    
    [_tableView release];
    _tableView = nil;
}

@end
