//
//  OrderTraceViewController.m
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//
// 原谅我吧，最近喜欢用TableView

#import "OrderTraceViewController.h"
#import "OrderTraceHeaderView.h"
#import "OrderTraceGoodsCell.h"
#import "OrderTraceCell.h"
#import "Order.h"
#import "Product.h"
#import "Trace.h"
#import "AppDelegate.h"
#import "WCAlertView.h"
#import "StartPoint.h"
#define TableViewFrame  CGRectMake(0, 64, 320, self.view.bounds.size.height - 64) // tableView的Frame
#define BackgroundColor [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1]

@interface OrderTraceViewController () {
    UITableView *_tableView;    // 当前的TableView
    NSMutableArray *_goodsArray;    // 商品对象数组
    NSMutableArray *_traceArray;    // 订单跟踪数组
    BOOL _isShowAllProduct;         // 是否显示全部商品
    OrderTraceHeaderView *_traceHeaderView; // 承运人信息
    HttpDownload *thisDownLoad;
}
@property (nonatomic, copy) Order *order;   // 当前的订单对象
@end

@implementation OrderTraceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _goodsArray = [[NSMutableArray alloc] initWithCapacity:1];
        _traceArray = [[NSMutableArray alloc] initWithCapacity:1];
        _isShowAllProduct = NO;
    }
    return self;
}
- (void)setOrder:(Order *)order
{
    _order = order;
    for (Product *product in order.productList) {
        [_goodsArray addObject:product];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getTraceInfo];
    [self addLoadView];
    
    self.navigationController.navigationBarHidden = YES;
    [self setNavigationBarWithContent:@"物流跟踪" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    // 设置背景颜色
    self.view.backgroundColor = BackgroundColor;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [StartPoint startPoint],WindowWidth ,WindowHeight-[StartPoint startPoint] )]; //frame
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BackgroundColor;
    [self.view addSubview:_tableView];
}

#pragma mark - 按钮回调
#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 点击箭头事件
- (void)showAllProduct:(id)sender
{
    _isShowAllProduct = !_isShowAllProduct;
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_tableView reloadData];
}

#pragma mark - TableView 代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        _traceHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"OrderTraceHeaderView" owner:nil options:nil] lastObject];
        if (_order) {
            [_traceHeaderView setOrderTraceHeaderViewDataWithOrder:_order isShowAllProduct:_isShowAllProduct];
            [_traceHeaderView addTarget:self Action:@selector(showAllProduct:)];
        }
    } else if(section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        return view;
    }
    return _traceHeaderView;
}
#pragma mark 设置Row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 80.00;
    }
    return 40.00;
}
#pragma mark 设置Section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // 只有承运人信息才显示
    if (section == 0) {
        return 120.0f;
    }
    else if (section == 2) {
        return 20.0f;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 承运人信息
    if (section == 0) {
        return 0;
    // 如果是商品
    } else if (section == 1) {
        // 如果显示全部
        if (_isShowAllProduct) {
            return [_goodsArray count];
        }
        // 否则显示一个
        return 0;
    // 如果是物流信息
    } else if (section == 2) {
        return [_traceArray count];
//        return 4;       //　只有四条数据。。。
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    // 如果是商品
    if (indexPath.section == 1) {
        OrderTraceGoodsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTraceGoodsCell" owner:nil options:nil] lastObject];
        if (_order) {
            Product *product = [_order.productList objectAtIndex:indexPath.row];
            [cell setOrderTraceGoodsCellWithProduct:product];
        }
        
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    // 如果物流信息
    } else if (indexPath.section == 2) {
        OrderTraceCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTraceCell" owner:nil options:nil] lastObject];
        if ([_traceArray count] > 0) {
            Trace *trace = [_traceArray objectAtIndex:indexPath.row];
            [cell setOrderTraceCellWithTrace:trace isFirst:indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return cell;
}
#pragma mark - 网络处理
#pragma mark
- (void)getTraceInfo
{
    [[self mainDelegate] beginLoad];
    //从服务器上获取订单详情
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate = self;
    thisDownLoad = hd;
    NSMutableDictionary *dict= [self httpDic];
    [dict setObject:_order.orderId forKey:@"ID"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:orderFollow,serviceHost]];
    hd.type = 11189;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    
}
#pragma mark 校验参数
-(NSMutableDictionary *)httpDic{
    //网络请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
}
-(void)downloadComplete:(HttpDownload *)hd1
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        // 获取物流信息
        if(hd1.type==11189){
            NSInteger status = [[dict objectForKey:@"status"] integerValue];
            NSArray *zinfoArr = [NSArray arrayWithObject:[dict objectForKey:@"zinfo"]];
            if (status == 0 && [zinfoArr count] > 0) {
                for (NSDictionary *dic in [zinfoArr objectAtIndex:0]) {
                    NSMutableDictionary *traceDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [traceDic setObject:[dict objectForKey:@"logss"] forKey:@"traceType"];
                    Trace *trace = [[Trace alloc] initWithDic:traceDic];
                    [_traceArray addObject:trace];
                }
                
                // 翻转
                 NSArray * sortArr = [[_traceArray reverseObjectEnumerator] allObjects];
                [_traceArray removeAllObjects];
                [_traceArray addObjectsFromArray:sortArr];
                
                [_tableView reloadData];
            } else {
                [WCAlertView showAlertWithTitle:@"提示信息" message:@"订单获取失败，请重试！" customizationBlock:^(WCAlertView * alertView1) {
                    alertView1.style=WCAlertViewStyleBlack;
                }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                    if(buttonIndex==0){
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            }
        [self.mainDelegate endLoad];
        }
    }
}

#pragma mark 网络请求失败
-(void)downloadFail
{
    [self.mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [self.mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
