//
//  SettlementViewController.m
//  DBuyer
//
//  Created by simman on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementViewController.h"
#import "OrderDetailCellViewCell.h"
#import "OrderDetailTableViewHeader.h"
#import "AddressItem.h"
#import "Product.h"
#import "TimeStamp.h"
#import "HttpDownload.h"
#import "ConfirmPaymenViewController.h"
#import "SettlementFooterView.h"
#import "SettlementTopView.h"           // 最上面的View
#import "SettlementExtractCell.h"       // 自提cell
#import "SettlementLogisticsCell.h"     // 物流Cell
#import "DefaultAddressViewController.h"    // 添加地址
#import "SelectSuperMarketViewController.h" // 选择自提超市
#import "keyBoardView.h"                // 键盘的view
#import "SqliteMarketObject.h"          // 超市
#import "SettlementPayMentFooterView.h"
#import "MD5.h"
#import "StartPoint.h"
#import "SettlementModel.h"
#import "DatePickerOfSettlement.h"
#import "GuideOperationView.h"

#import "TConfirmPay.h"
#import "TConfirmPaymentController.h"

#define ViewBackgroundColor [UIColor colorWithRed:0.333 green:0.333 blue:0.333 alpha:1]

#define GetAddressType           1//获取用户收获地址
#define GetYunfeiAndZitiTimeType 2//获取运费和自提时间
#define GetZitiSuperMarketType   3//获取用户自提超市
#define GetUserIntegral          4//获取用户积分
#define GetDeliveryWay           5//获取用户收货方式
@interface SettlementViewController () {
    
    UITableView *_tableView;        // 当前的TableView
    LoadView *thisLoad;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    OrderDetailTableViewHeader *_tableHeaderView;
    SettlementSectionHeader *_sectionHeaderview;
    SettlementPayMentFooterView *_footerView;                // 去支付视图
    SettlementFooterView *_detailFooterView; // 积分视图
    NSInteger _giftId;          // 礼包ID
    
    UIPickerView * _integralPickerView;  // 积分的PickerView
}
@property (nonatomic, assign) SettlementType SettType;  // 结算类型
@property (nonatomic, retain) NSIndexPath *exIndexPath; // 自提时间的indexpath
@property (nonatomic, retain)SettlementModel *settlementItem;
@property (nonatomic,retain)DatePickerOfSettlement *datePick;
@property (nonatomic,assign)GuideOperationView *guideView;
/**
 *  提交礼包订单
 */
- (void)pushGiftOrderAction;

@end

@implementation SettlementViewController
@synthesize gid,giftPrice,isVIP;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _giftId = 0;
        giftPrice = 0.00;
        self.settlementItem = [[SettlementModel alloc]init];
        [self.settlementItem.productlistArray removeAllObjects];
        isVIP = NO;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.settlementItem.freight = 0.0f;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSRange range=NSMakeRange(0,[self.settlementItem.takeBySelfTime length]);
//    [self.settlementItem.takeBySelfTime deleteCharactersInRange:range];
//    self.settlementItem.isHaveAddress = NO;
}

#pragma mark 添加到结算中心
- (void)setSettlementWithProducts:(NSMutableArray *)productArr SeettType:(SettlementType)SettType
{
    [self setSettlementWithProducts:productArr SeettType:SettType GiftID:0];
}
- (void)setSettlementWithProducts:(NSMutableArray *)productArr SeettType:(SettlementType)SettType GiftID:(NSInteger)giftId
{
    [self.settlementItem.productlistArray removeAllObjects];
    [self.settlementItem.productlistArray addObjectsFromArray:productArr];
    self.SettType = SettType;
    _giftId = giftId;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"SettlementViewController"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"SettlementViewController"];
        [self firstOpenSetView];
    }
    else
    {
        [self loadViewHandle];
    }
}
#pragma mark - 首次打开此页面 出现用户引导视图
-(void)firstOpenSetView
{
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"settlementIntroduct.png", nil];
    self.guideView = [[GuideOperationView alloc]initGuideOperationViewWith:array];
    self.guideView.delegate = self;
    [[self mainDelegate].window addSubview:self.guideView];
}
-(void)guideOperationDidClick
{
    [self loadViewHandle];
}
#pragma mark 提交礼包类型订单
- (void)pushGiftOrderAction
{
    /*
     序号	参数描述	参数名称	约束	参数类型及长度	参数值说明	备注
     1	礼包id        lid	必填	string
     2	综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
     3	精超ID        jingAreaId	可选	string	有就填
     4	使用积分        useJF	可选	int
     5	地址ID        areaId	可选	string	有就填	物流时必填
     6	综自提时间	zhongZiTime	可选	string	有就填	自提必填
     7	精自提时间	jingZiTime	可选	string	同上	同上
     8	修改的地址	areaAdd	可选	string	有就填	物流必填
     9	综合物流费	zfreight	可选	int	同上
     10	精物流费        jfreight	可选	int	同上
     11	商品数量        count	必填	int
     12	礼包商品列	ids	必填	Jsonarray	同礼包结算一样
     
     #define insertBoxOrder     // 新礼包详情结算接口 2014.01.15 Liwei
     
     */
    
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:[NSString stringWithFormat:@"%d", [self.settlementItem.productlistArray count]] forKey:@"count"];    // 商品数量
    NSMutableString *str=[[NSMutableString alloc]init];
    for(int i =0;i<[self.settlementItem.productlistArray count];i++){
        Product *pro=[self.settlementItem.productlistArray objectAtIndex:i];
        [str appendFormat:@"\"%@\":\"%d\",",pro.productID,1];
        
    }
    NSMutableString *str2=[[NSMutableString alloc]init];
    str2=(NSMutableString *) [str substringToIndex:[str length]-1];
    NSString * str3 = [NSString stringWithFormat:@"{%@}",str2];
    [dict setObject:str3 forKey:@"ids"];                       // 商品ID
    [dict setObject:gid forKey:@"lid"];                 // 礼包ID
    if([self.settlementItem.zitiAreaItem.marketId length]!=0 && [self IsEmptyOfString:self.settlementItem.zitiAreaItem.marketId]!=YES)
    {
        [dict setObject:self.settlementItem.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
    }
    NSString *areaAdd=[NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",self.settlementItem.addressItem.name,self.settlementItem.addressItem.phoneNumber,self.settlementItem.addressItem.address];
    [dict setObject:areaAdd forKey:@"areaAdd"];    // 修改的地址
    [dict setObject:[NSString stringWithFormat:@"%d", self.settlementItem.useIntegral] forKey:@"useJF"];  // 使用积分
    [dict setObject:self.settlementItem.addressItem.addressId forKey:@"areaId"];   // 地址ID
    
    // 如果是物流则有自提时间
    if (!self.settlementItem.logisticsStatus) {
        NSString *strZiti=[self.settlementItem.takeBySelfTime substringToIndex:([self.settlementItem.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [dict setObject:zitiTime forKey:@"zhongZiTime"];
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    } else {
        [dict setObject:[NSString stringWithFormat:@"%f", self.settlementItem.freight] forKey:@"zfreight"];          // 物流费
    }
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:insertBoxOrder,serviceHost]];
    hd.type = 95272;
    hd.method=@selector(downloadComplete:);
    hd.failMethod=@selector(downloadFail);
    [[self mainDelegate] beginLoad];
    
}

#pragma mark 提交商品详情类型订单
- (void)pushGoodsDetailAction
{
    /*
     序号	参数描述	参数名称           约束	参数类型及长度     参数值说明	备注
     1	商品id        id              必填	string
     2	综合超市ID	 zongAreaId      可选	string          有就填无限制	自提时必填
     3	精超ID        jingAreaId      可选	string          有就填
     4	使用积分       useJF           可选	int
     5	地址ID        areaId          可选	string          有就填	物流时必填
     6	综自提时间	  zhongZiTime     可选	string          有就填	自提必填
     7	精自提时间	  jingZiTime	  可选	string          同上	同上
     8	修改的地址	  areaAdd         可选	string          有就填	物流必填
     9	综合物流费	  zfreight        可选	int             同上
     10	精物流费       jfreight        可选	int             同上
     11	商品数量       count            必填	int
     12	商品类型       type             必填	int
     13	商品分类       categoryID       可选	string	Type=1  必填
     
     #define insertGoodsOrder   // 新商品详情结算接口 2014.01.15 liwei
     */
    
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    // 添加提交的数据
    // NSString *proIds = [[self getAllProductId] valueForKey:@"proIdsDic"];
    Product *pro = [self.settlementItem.productlistArray objectAtIndex:0];
    [dict setObject:pro.productID forKey:@"id"];                       // 商品ID
    
    [dict setObject:[NSString stringWithFormat:@"%d", pro.count] forKey:@"count"];                 // 商品数量
    if(pro.type==1){
        [dict setObject:[NSString stringWithFormat:@"%d", pro.type] forKey:@"type"];        // 商品类型
        [dict setObject:pro.catID forKey:@"categoryID"];            // 商品分类ID
    }
    
    if([self.settlementItem.zitiAreaItem.marketId length]!=0 && [self IsEmptyOfString:self.settlementItem.zitiAreaItem.marketId]!=YES)
    {
        [dict setObject:self.settlementItem.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
    }
    NSString *areaAdd=[NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",self.settlementItem.addressItem.name,self.settlementItem.addressItem.phoneNumber,self.settlementItem.addressItem.address];
    [dict setObject:areaAdd forKey:@"areaAdd"];    // 修改的地址
    [dict setObject:[NSString stringWithFormat:@"%d", self.settlementItem.useIntegral] forKey:@"useJF"];                      // 使用积分
    [dict setObject:self.settlementItem.addressItem.addressId forKey:@"areaId"];   // 地址ID
    
    // 如果是物流则有自提时间
    if (!self.settlementItem.logisticsStatus) {
        NSString *strZiti=[self.settlementItem.takeBySelfTime substringToIndex:([self.settlementItem.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [dict setObject:zitiTime forKey:@"zhongZiTime"];
        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    } else {
        [dict setObject:[NSString stringWithFormat:@"%f", self.settlementItem.freight] forKey:@"zfreight"];          // 物流费
    }
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:insertGoodsOrder,serviceHost]];
    hd.type = 95271;
    hd.method=@selector(downloadComplete:);
    hd.failMethod=@selector(downloadFail);
    [[self mainDelegate] beginLoad];
}

#pragma mark 提交购物车类型订单
- (void)pushCartOrderAction
{
    
    /*
     1	商品id列表	ids  	必填	Jsonarray	{“1”:”2”}
     2	综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
     3	精超ID	jingAreaId	可选	string	有就填
     4	使用积分	useJF	可选	int
     5	地址ID	areaId	可选	string	有就填	物流时必填
     6	综自提时间	zhongZiTime	可选	string	有就填	自提必填
     7	精自提时间	jingZiTime	可选	string	同上	同上
     8	修改的地址	areaAdd	可选	string	有就填	物流必填
     9	综合物流费	zfreight	可选	int	同上
     10	精物流费	jfreight	可选	int	同上
     */
    
    [mainDelegate beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
  
    
    NSString *proIds = [[self getAllProductId] valueForKey:@"proIdsDic"];
    [dict setObject:proIds forKey:@"ids"];// 商品ID
    if([self.settlementItem.zitiAreaItem.marketId length]!=0 && [self IsEmptyOfString:self.settlementItem.zitiAreaItem.marketId]!=YES)
    {
        [dict setObject:self.settlementItem.zitiAreaItem.marketId forKey:@"zongAreaId"]; // 综合超市ID
    }
    [dict setObject:[NSString stringWithFormat:@"%d", self.settlementItem.useIntegral] forKey:@"useJF"];                     // 使用积分
       // 地址ID
    if([self.settlementItem.addressItem.addressId length]!=0)
    {
       [dict setObject:self.settlementItem.addressItem.addressId forKey:@"areaId"];
    }
    else
    {
        [dict setObject:@"4ec175cd9e0e48b7b7e6dd3660c62f21" forKey:@"areaId"];
    }
    // 如果是自提则有自提时间
    if (!self.settlementItem.logisticsStatus) {
        NSString *strZiti=[self.settlementItem.takeBySelfTime substringToIndex:([self.settlementItem.takeBySelfTime length]-6)];
        NSString *zitiTime=[NSString stringWithFormat:@"%@:00",strZiti];
        [dict setObject:zitiTime forKey:@"zhongZiTime"]; // todo 设置自提时间  传到服务器上

        [dict setObject:[NSString stringWithFormat:@"%d", 0] forKey:@"zfreight"];          // 物流费
    } else {
        [dict setObject:[NSString stringWithFormat:@"%f", self.settlementItem.freight] forKey:@"zfreight"];          // 物流费
    }
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:PushOrder,serviceHost]];
    hd.type = 95270;
    hd.method=@selector(downloadComplete:);
    hd.failMethod=@selector(downloadFail);
    [[self mainDelegate] beginLoad];
}


- (NSMutableArray*)generatePayWayList {
    NSMutableArray *paywayList = [[NSMutableArray alloc]init];
    NSDictionary *umpay = @{@"cardType":@"0",@"cardName":@"(银联支付)"};
    NSDictionary *mascnpay = @{@"cardType":@"1",@"cardName":@"(快钱支付)"};
    NSDictionary *allsco = @{@"cardType":@"2",@"cardName":@"(预付卡支付,专享特价优惠)"};
    
    if (!isVIP) {
        [paywayList addObject:umpay];
        [paywayList addObject:mascnpay];
    }
    
    [paywayList addObject:allsco];
    return paywayList;
}

#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd1
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *paywayList = [dict objectForKey:@"wayList"];
    if (paywayList == nil && paywayList.count == 0) {
        paywayList = [self generatePayWayList];
    }
    if(dict){

        //获取用户收货方式
        if(hd1.type == GetDeliveryWay)
        {
            [[self mainDelegate]endLoad];
            [self.settlementItem getDeliveryWay:dict];
            [self setTotalPrice];
            [_tableView reloadData];
        }

        // 获取默认超市
        if (hd1.type == GetZitiSuperMarketType) {
            [[self mainDelegate] endLoad];
            [self.settlementItem getDefaultSuperMarketArea:dict];
            [_tableView reloadData];
        }
        
        if(hd1.type == 95272){
            //todo 2014年1月17日礼包支付的BUG
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            [[self mainDelegate] endLoad];
            if(states==0){
                [mainDelegate endLoad];
                NSString *orderIdList = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"ID"];;
                NSString *paidAmount = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"amountPayable"];
                
                TConfirmPay *confirmPay = [[TConfirmPay alloc]init];
                confirmPay.orderIdList = orderIdList;
                confirmPay.paidAmount = [NSString stringWithFormat:@"%@",paidAmount];
                confirmPay.payWays = paywayList;
                confirmPay.integral = [[[dict objectForKey:@"result"] objectAtIndex:0]objectForKey:@"integral"];
                TConfirmPaymentController *conVC = [[TConfirmPaymentController alloc]initWithNavigationTitle:@"支付方式" andConfirPay:confirmPay];
                [self.navigationController pushViewController:conVC animated:YES];
                [conVC release];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:nil userInfo:dict];
            }
        }
        if(hd1.type == 95271){ // vip
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            [[self mainDelegate] endLoad];
            if(states==0){
                [mainDelegate endLoad];
                
                NSString *orderIdList = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"ID"];;
                NSString *paidAmount = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"amountPayable"];
                
                TConfirmPay *confirmPay = [[TConfirmPay alloc]init];
                confirmPay.orderIdList = orderIdList;
                confirmPay.payWays = paywayList;
                confirmPay.paidAmount = [NSString stringWithFormat:@"%@",paidAmount];
                confirmPay.integral = [[[dict objectForKey:@"result"] objectAtIndex:0]objectForKey:@"integral"];
                TConfirmPaymentController *conVC = [[TConfirmPaymentController alloc]initWithNavigationTitle:@"支付方式" andConfirPay:confirmPay];
                [self.navigationController pushViewController:conVC animated:YES];
                [conVC release];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:nil userInfo:dict];
            }
        }
        // 用户的地址列表
        if(hd1.type==GetAddressType){
            [[self mainDelegate] endLoad];
            [self.settlementItem getDefaultAddress:dict];
            [_tableView reloadData];
        }
        
        // 提交订单
        if(hd1.type==95270){
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            [[self mainDelegate] endLoad];
            if(states==0){
                //订单发送成功，跳转到支付前确认页
                [mainDelegate endLoad];
                
                NSString *orderIdList = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"ID"];;
                NSString *paidAmount = [[[dict objectForKey:@"result"] objectAtIndex:0] objectForKey:@"amountPayable"];
                
                TConfirmPay *confirmPay = [[TConfirmPay alloc]init];
                confirmPay.orderIdList = orderIdList;
                confirmPay.payWays = paywayList;//[dict objectForKey:@"wayList"];
                confirmPay.paidAmount = [NSString stringWithFormat:@"%@",paidAmount];
                confirmPay.integral = [[[dict objectForKey:@"result"] objectAtIndex:0]objectForKey:@"integral"];
                TConfirmPaymentController *conVC = [[TConfirmPaymentController alloc]initWithNavigationTitle:@"支付方式" andConfirPay:confirmPay];
                [self.navigationController pushViewController:conVC animated:YES];
                [conVC release];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:nil userInfo:dict];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[dict objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        // 获取运费
#pragma mark - 获取运费及自提时间
        if(hd1.type==GetYunfeiAndZitiTimeType){
            [[self mainDelegate] endLoad];
            [self.settlementItem getFreightAndZitiTime:dict];
            [self.datePick.datePicker reloadAllComponents];
            [self setTotalPrice];
            [_tableView reloadData];
            
        }
        // 获取用户积分
        if(hd1.type==GetUserIntegral){
            [[self mainDelegate] endLoad];
            [self.settlementItem getIntegral:dict];
            [_integralPickerView reloadAllComponents];
            [_tableView reloadData];
        }
    }
}
-(void)setTotalPrice
{
    if(self.settlementItem.logisticsStatus)
    {
        float totalPrice = [self getAllProductPrice]+self.settlementItem.freight;
        NSString *total = [NSString stringWithFormat:@"%0.2f", totalPrice];
        _footerView.totalPriceLable.text = total;
    }
    else
    {
        _footerView.totalPriceLable.text = [NSString stringWithFormat:@"%0.2f", [self getAllProductPrice]];
    }
}
-(void)cancelPickTime
{
    [self.settlementItem.takeBySelfTime setString: self.settlementItem.timeOnTheButton];
    self.datePick.hidden=YES;
    _tableView.scrollEnabled = YES;
}
-(void)finishPickTime
{
    if([self IsEmptyOfString:self.settlementItem.takeBySelfTime]==NO)
    {
        [self.settlementItem.timeOnTheButton setString:self.settlementItem.takeBySelfTime];
        NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:1];
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    self.datePick.hidden=YES;
    _tableView.scrollEnabled = YES;
}
#pragma mark - loadViewHandel
- (void)loadViewHandle
{
    self.navigationController.navigationBarHidden =YES;             // 隐藏系统的NavigationBar
    [self.leveyTabBarController hidesTabBar:YES animated:YES];      // 隐藏TabBar
    [self setNavigationBarWithContent:@"结算中心" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    self.view.backgroundColor = ViewBackgroundColor;
    // 设置最上面的View
    SettlementTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"SettlementTopView" owner:nil options:nil] lastObject];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight - 60 - [StartPoint startPoint])];
    _tableView.tableHeaderView = topView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    // 时间选择器
    self.datePick = [[[NSBundle mainBundle]loadNibNamed:@"DatePickerOfSettlemment" owner:self options:nil]lastObject];
    self.datePick.datePicker.delegate = self;
    self.datePick.datePicker.dataSource = self;
    self.datePick.frame = CGRectMake(0, WindowHeight -192-60 , 320, 192);
    self.datePick.hidden = YES;
    _tableView.scrollEnabled = YES;
    [self.datePick addTarget:self withCancelAction:@selector(cancelPickTime) AndFinishAction:@selector(finishPickTime)];
    [self.view addSubview:self.datePick];
    // 使用积分
    _integralPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 500)];
    _integralPickerView.showsSelectionIndicator=YES;
    _integralPickerView.tag = 1;
    _integralPickerView.delegate = self;
    _integralPickerView.dataSource = self;
    // 积分视图
    _detailFooterView = [[SettlementFooterView alloc] initWithNib];
    [_detailFooterView addTarget:self Action:@selector(selectIntegral:) KeyBoardFinshAction:@selector(keyBorardFinishAction) KeyBoardCancelAction:@selector(keyBoardCancelAction)];
    _detailFooterView.useIntegralTextField.inputView = _integralPickerView;
    // 去付款视图
    [self initToBuyView];
    
    [self getDefaultAddress];   // 获取地址
    [self getDelivery];
    [self getTransportationPrice]; // 获取运费
    [self getQueryUserAttrType];    // 获取默认自提地址
}
-(void)initToBuyView
{
    _footerView = [[[NSBundle mainBundle] loadNibNamed:@"SettlementPayMentFooterView" owner:nil options:nil] lastObject];
    [_footerView addTarget:self payAction:@selector(pushOrderButtonAction)];
    _footerView.frame = CGRectMake(0, 0, WindowWidth, _footerView.bounds.size.height);
    CGRect frame = _footerView.frame;
    frame.origin.y = WindowHeight - _footerView.frame.size.height;
    _footerView.frame = frame;
    [self.view addSubview:_footerView];
}
#pragma mark - TableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 如果是第一个或者Section则显示收货方式和自提
    if (section == 0 || section == 1) {
        return 1;
    }
    return [self.settlementItem.productlistArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 65.0f;
    }
    if (indexPath.section == 0) {
        if(self.settlementItem.logisticsStatus)
        {
            return 110.f;
        }
    } else if (indexPath.section == 1) {
        if(!self.settlementItem.logisticsStatus)
        {
            return 110.0f;
        }
    }
    return 0;
}
#pragma mark 设置Section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // 只有商品cell才显示
    if (section == 2) {
        return 35.0f;
    }
    return 0;
}

#pragma mark 选择物流自提
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        _sectionHeaderview = [[[NSBundle mainBundle] loadNibNamed:@"SettlementSectionHeader" owner:nil options:nil] lastObject];
        [_sectionHeaderview addTarget:self logisticsAction:@selector(logisticsAction:) extractAction:@selector(extractAction:)];
        [_sectionHeaderview setDeliveryMethod:self.settlementItem];
        [_sectionHeaderview setButtonCanClickWith:self.settlementItem.logisticsStatus AndZitiHidden:isVIP AndlogisticsPrice:self.settlementItem.freight];
    }
    return _sectionHeaderview;
}

#pragma mark 设置Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 加载商品cell、物流Cell、自提cell
    OrderDetailCellViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailCell"];
    SettlementLogisticsCell *LogisticsCell = [tableView dequeueReusableCellWithIdentifier:@"SettlementLogisticsCell"];
    SettlementExtractCell *ExtractCell = [tableView dequeueReusableCellWithIdentifier:@"SettlementExtractCell"];//自提cell设置
    
    // 如果是物流地址Cell
    if (indexPath.section == 0) {
        LogisticsCell = [[[NSBundle mainBundle] loadNibNamed:@"SettlementLogisticsCell" owner:nil options:nil] lastObject];
        LogisticsCell.contentView.frame = CGRectMake(0, 0, 320, [self tableView:tableView heightForRowAtIndexPath:indexPath]);
        // 添加物流地址编辑按钮事件
        [LogisticsCell addTarget:self Action:@selector(logisticsEditAction:)];
        LogisticsCell.backgroundColor = [UIColor clearColor];
        LogisticsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        LogisticsCell.hidden = !self.settlementItem.logisticsStatus || self.settlementItem.isWuliuHidden;
        // 如果是自提地址Cell
    } else if (indexPath.section == 1) {
        ExtractCell = [[[NSBundle mainBundle] loadNibNamed:@"SettlementExtractCell" owner:nil options:nil] lastObject];
        ExtractCell.contentView.frame = CGRectMake(0, 0, 320, 100);
        ExtractCell.backgroundColor = [UIColor clearColor];
        ExtractCell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 添加自提地址选择超市和自提时间的按钮事件
        [ExtractCell addTarget:self SuperMaketAction:@selector(SuperMaketAction:) ExtractDateAction:@selector(ExtractDateAction:)];
        [ExtractCell.ExtractDateButton setTitle:self.settlementItem.timeOnTheButton forState:UIControlStateNormal];
        ExtractCell.hidden =self.settlementItem.logisticsStatus|| self.settlementItem.isZitiHidden;
        // 如果是普通商品Cell
    } else {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCellViewCell" owner:nil options:nil] lastObject];
        cell.contentView.frame = CGRectMake(0, 0, 320, [self tableView:tableView heightForRowAtIndexPath:indexPath]);
    }
    
    // 如果是选择收货方式
    if (indexPath.section == 0) {
        // 如果有默认地址的话则显示网络加载的默认地址
        if (self.settlementItem.addressItem) {
            [LogisticsCell setCellWithAddressItem:self.settlementItem.addressItem];
            // 否则显示新增地址
        } else {
            
        }
        return LogisticsCell;
        
        // 如果是自提收货方式
    } else if (indexPath.section == 1) {
        // 暂时没有获取默认的超市ID。。。。
        
        [ExtractCell setSettlementExtractCellWithMarket:self.settlementItem.zitiAreaItem];   // 设置超市
        return ExtractCell;
        
        // 如果是商品Cell
    } else {
        // 赋值
        [cell setCellWithProduct:[self.settlementItem.productlistArray objectAtIndex:indexPath.row]];
        // 设置下圆角和选中样式
        cell.backGroundView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        if (indexPath.row == 0) {
            cell.line.hidden = YES; // 隐藏绿线
        }
        // 如果是最后一行，那么设置圆角
        if (indexPath.row != self.settlementItem.productlistArray.count - 1) {
            cell.buttomBackGroundView.backgroundColor = [UIColor whiteColor];
        } else {
            CGRect cellButtomFrame = cell.buttomBackGroundView.frame;
            cell.buttomBackGroundView.frame =CGRectMake(cellButtomFrame.origin.x, cellButtomFrame.origin.y-4,cellButtomFrame.size.width, cellButtomFrame.size.height);
            [cell.buttomBackGroundView setImage:[UIImage imageNamed:@"buttom_raduis"]];
        }
    }
    return cell;
}


#pragma mark 物流按钮点击事件
- (void)logisticsAction:(id)sender
{
    [self.settlementItem.takeBySelfTime setString: self.settlementItem.timeOnTheButton];
    self.datePick.hidden=YES;
    _tableView.scrollEnabled = YES;
    self.settlementItem.logisticsStatus = !self.settlementItem.logisticsStatus;
    [self setTotalPrice];
//    float totalPrice = [self getAllProductPrice]+self.settlementItem.freight;
//    NSString *total = [NSString stringWithFormat:@"%0.2f", totalPrice];
 //   _footerView.totalPriceLable.text = total;
    [_tableView reloadData];
}
#pragma mark 自提按钮点击事件
- (void)extractAction:(id)sender
{
    self.settlementItem.logisticsStatus = !self.settlementItem.logisticsStatus;
    [self setTotalPrice];
//    _footerView.totalPriceLable.text = [NSString stringWithFormat:@"%0.2f", [self getAllProductPrice]];
    [_tableView reloadData];
}
#pragma mark 物流地址编辑按钮事件
- (void)logisticsEditAction:(id)sender
{
    DefaultAddressViewController *defaultAddressVC = [[DefaultAddressViewController alloc] initWithNibName:@"DefaultAddressViewController" bundle:nil];
    [defaultAddressVC addTarget:self action:@selector(editAddressAction:)];
    [self.navigationController pushViewController:defaultAddressVC animated:YES];
}
#pragma mark 地址编辑完回来的事件
- (void)editAddressAction:(AddressItem *)sender
{
    if (![sender.addressId isEqualToString:@""]) {
        self.settlementItem.addressItem = sender;
        [_tableView reloadData];
    }
}

#pragma mark 设置点击超市按钮回调
- (void)SuperMaketAction:(id)sender
{
    SelectSuperMarketViewController *selectVC = [[SelectSuperMarketViewController alloc] init];
    [selectVC addTarget:self Action:@selector(returnSelectedMarket:)];
    [self.navigationController pushViewController:selectVC animated:YES];
    
}
#pragma mark 选择超市的代理方法
- (void)returnSelectedMarket:(SqliteMarketObject *)market
{
    self.settlementItem.zitiAreaItem = market;
    [_tableView reloadData];
}

#pragma mark 设置自提时间按钮回调
- (void)ExtractDateAction:(id)sender
{
    self.datePick.hidden=NO;
    _tableView.scrollEnabled = NO;
    
}
#pragma mark 用户选择积分
- (void)selectIntegral:(UITextField *)textField
{
    textField.inputView = _integralPickerView;
}

#pragma mark - pickerView 代理
#pragma mark pickerView代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.datePick.datePicker) {
        return 2;
    }
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.datePick.datePicker) {
        if (component == 0) { // 第0列
            return 3;
        } else {
            if([pickerView selectedRowInComponent:0] == 0)
            {
                return self.settlementItem.countOfFirst;
            }
            return 5;
        }
    }
    return self.settlementItem.allIntegral / 125 + 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.datePick.datePicker) {
        if (component == 0) { // 第0列
            if([self.settlementItem.exDateDayArray count]!=0){
                return [self.settlementItem.exDateDayArray objectAtIndex:row];
                }
            else
                return 0;
        } else {
            if ([pickerView selectedRowInComponent:0] == 0) {
                return [self.settlementItem.exDateHourArray objectAtIndex:(row + 5 - self.settlementItem.countOfFirst)];//第一栏时时间选择
            } else {
                return [self.settlementItem.exDateHourArray objectAtIndex:row];
            }
        }
    } else {
        return [NSString stringWithFormat:@"%d", 125 * row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.datePick.datePicker) {
        if ([pickerView selectedRowInComponent:0] == 0) {
            [pickerView reloadComponent:1];
            NSRange range=NSMakeRange(0,[self.settlementItem.takeBySelfTime length]);
            [self.settlementItem.takeBySelfTime deleteCharactersInRange:range];
            [self.settlementItem.takeBySelfTime appendString:[self.settlementItem.exDateDayArray objectAtIndex:0]];
            [self.settlementItem.takeBySelfTime appendString:@" "];
            [self.settlementItem.takeBySelfTime appendString:[self.settlementItem.exDateHourArray objectAtIndex:([self.datePick.datePicker selectedRowInComponent:1] + [self.settlementItem.exDateHourArray count] - self.settlementItem.countOfFirst)]];
            
        } else {
            
            [pickerView reloadComponent:1];
            NSRange range=NSMakeRange(0,[self.settlementItem.takeBySelfTime length]);
            [self.settlementItem.takeBySelfTime deleteCharactersInRange:range];
            [self.settlementItem.takeBySelfTime appendString:[self.settlementItem.exDateDayArray objectAtIndex:[self.datePick.datePicker selectedRowInComponent:0]]];
            [self.settlementItem.takeBySelfTime appendString:@" "];
            [self.settlementItem.takeBySelfTime appendString:[self.settlementItem.exDateHourArray objectAtIndex:[self.datePick.datePicker selectedRowInComponent:1]]];
        }
        
    } else {
        self.settlementItem.useIntegral = 125 * row;
        _detailFooterView.useIntegralTextField.text = [NSString stringWithFormat:@"%d", 125 * row];
        _detailFooterView.priceLable.text = [NSString stringWithFormat:@"￥ %d", self.settlementItem.useIntegral / 125];
        _footerView.totalPriceLable.text = [NSString stringWithFormat:@"%0.2f",  ([self getAllProductPrice] - self.settlementItem.useIntegral / 125)];
    }
    
}

- (void)keyBorardFinishAction
{
    [_detailFooterView.useIntegralTextField resignFirstResponder];
}
- (void)keyBoardCancelAction
{
    self.settlementItem.useIntegral = 0;
    _detailFooterView.useIntegralTextField.text = [NSString stringWithFormat:@"%d", 0];
    _detailFooterView.priceLable.text = [NSString stringWithFormat:@"￥ %d", 0];
    _footerView.totalPriceLable.text = [NSString stringWithFormat:@"%0.2f",  [self getAllProductPrice]];
    [_detailFooterView.useIntegralTextField resignFirstResponder];
}

- (void)exKeyBorardFinishAction
{
    [_detailFooterView.useIntegralTextField resignFirstResponder];
}
- (void)exKeyBoardCancelAction
{
    self.settlementItem.useIntegral = 0;
    _detailFooterView.useIntegralTextField.text = [NSString stringWithFormat:@"%d", 0];
    _detailFooterView.priceLable.text = [NSString stringWithFormat:@"￥ %d", 0];
    _footerView.totalPriceLable.text = [NSString stringWithFormat:@"%0.2f",  [self getAllProductPrice]];
    [_detailFooterView.useIntegralTextField resignFirstResponder];
}


#pragma mark 去付款按钮
- (void)pushOrderButtonAction
{
    /*
     1	商品id列表	ids  	必填	Jsonarray	{“1”:”2”}
     2	综合超市ID	zongAreaId	可选	string	有就填无限制	自提时必填
     3	精超ID	jingAreaId	可选	string	有就填
     4	使用积分	useJF	可选	int
     5	地址ID	areaId	可选	string	有就填	物流时必填
     6	综自提时间	zhongZiTime	可选	string	有就填	自提必填
     7	精自提时间	jingZiTime	可选	string	同上	同上
     8	修改的地址	areaAdd	可选	string	有就填	物流必填
     9	综合物流费	zfreight	可选	int	同上
     10	精物流费	jfreight	可选	int	同上
     */
    
    
    //首先判断是自提还是物流
    // 物流
    if (self.settlementItem.logisticsStatus) {
        // 开始判断必填条件（物流对象）
        if ([self.settlementItem.addressItem.address length] == 0 ||self.settlementItem.addressItem ==nil || [self.settlementItem.addressItem.name length] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请完善收货地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        // 是否有物流费用
        if (self.settlementItem.freight == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"物流费用获取失败，请重试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }

    // 自提
    if (!self.settlementItem.logisticsStatus) {
        // 开始判断必填条件（超市ID）
        if ([self.settlementItem.zitiAreaItem.marketId isEqualToString:@""] || !self.settlementItem.zitiAreaItem.marketId) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请设置自提超市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        // 自提时间 todu 自提时间设置
    }
    
    
    // 判断结算类型  =========>>>>>>>>>>>>>>
    
    // 礼包结算
    if (self.SettType == ISGift) {
        
        [self pushGiftOrderAction];
        
        // 商品详情结算
    } else if (self.SettType == GoodsDetail) {
        
        [self pushGoodsDetailAction];
        
        // 商品购物车结算
    } else if (self.SettType == ShoopingCar) {
        [self pushCartOrderAction];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 获取相关参数
#pragma mark 获取订单的价格
- (CGFloat)getAllProductPrice
{
    // 如果是礼包
    if (giftPrice) {
        return self.giftPrice;
    }
    CGFloat priceCount = 0.00;
    for (Product *produc in self.settlementItem.productlistArray) {
        priceCount += produc.sellPrice * produc.count;
    }
    return priceCount;
}

#pragma mark 获取所有商品的ID
- (NSMutableDictionary *)getAllProductId
{
    if ([self.settlementItem.productlistArray count] == 0) {
        return [[NSMutableDictionary alloc]init];
    }
    NSMutableDictionary *productIdDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableArray *productIdArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (Product *product in self.settlementItem.productlistArray) {
        [productIdDic setValue:[NSString stringWithFormat:@"%d", product.count] forKey:product.productID];
        [productIdArray addObject:product.productID];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:productIdDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * proIdsArray = [productIdArray componentsJoinedByString:@","]; // 使用逗号分割数组封装为订单ID字符串
    NSString *proIdsDic = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:proIdsArray, proIdsDic, nil] forKeys:[NSArray arrayWithObjects:@"proIdsArray", @"proIdsDic", nil]];
    return result;
}
#pragma mark - 网络相关请求
-(void)pleaseCancelLoad{
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(void)downloadFail{
    [mainDelegate endLoad];
}
#pragma mark - 网络请求
-(NSMutableDictionary *)httpDic{
    //网络请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
}
#pragma mark - 获取收货方式
-(void)getDelivery
{
    NSString *urlString = [NSString stringWithFormat:@"%@interface/order/deliveryMethod",serviceHost];
    NSMutableDictionary *dict = [self httpDic];
    NSString *proIds = [[self getAllProductId] valueForKey:@"proIdsArray"]; // 获取所有的订单ID
    [dict setObject:proIds forKey:@"commodityIds"];
    [self toRequestDataFromUrl:urlString typeTag:GetDeliveryWay params:dict];
}
#pragma mark - 取得用户的地址列表
-(void)getDefaultAddress
{
    NSString *urlString = [NSString stringWithFormat:kQueryAddressList,serviceHost];
    NSMutableDictionary *dict=[self httpDic];
    [self toRequestDataFromUrl:urlString typeTag:GetAddressType params:dict];
}
#pragma mark - 获得运费以及自提时间
- (void)getTransportationPrice
{
    NSMutableDictionary *dict=[self httpDic];
    NSString *proIds = [[self getAllProductId] valueForKey:@"proIdsArray"]; // 获取所有的订单ID
    [dict setObject:proIds forKey:@"ids"];
    NSString *urlString = [NSString stringWithFormat:TransportationPrice,serviceHost];
    [self toRequestDataFromUrl:urlString typeTag:GetYunfeiAndZitiTimeType params:dict];
}
#pragma mark - 获取默认自提超市
- (void)getQueryUserAttrType {
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:@"1" forKey:@"type"];
    NSString *urlString = [NSString stringWithFormat:queryUserAttrType,serviceHost];
    [self toRequestDataFromUrl:urlString typeTag:GetZitiSuperMarketType params:dict];
}
#pragma mark 获取用户积分
-(void)getUserPoints{
    NSMutableDictionary *dict=[self httpDic];
    NSString *urlString = [NSString stringWithFormat:queryUserInfor,serviceHost];
    [self toRequestDataFromUrl:urlString typeTag:GetUserIntegral params:dict];
}
- (void)toRequestDataFromUrl:(NSString *)url typeTag:(int)tag params:(NSMutableDictionary *)dic{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.type=tag;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    if (dic) {
        [hd getResultData:dic baseUrl:url];
    }else{
        [hd downloadFromUrl:url];
    }
    thisDownLoad = hd;
    [[self mainDelegate] beginLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
