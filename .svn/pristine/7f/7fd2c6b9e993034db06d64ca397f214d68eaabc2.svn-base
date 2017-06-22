//
//  TConfirmPaymentController.m
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TConfirmPaymentController.h"
#import "TBill99PayController.h"
#import "TServerFactory.h"
#import "TUMServer.h"
#import "TMasCnpServer.h"
#import "TAllScoServer.h"
#import "TOrderServer.h"
#import "SettlementViewController.h"
#import "TAllScoListController.h"

#import "CheckSuccessView.h"
#import "CheckFieldView.h"

#import "DfhddViewController.h"
#import "DfkddViewController.h"

#import "UPOMPXMLParser.h"
#import "TUtilities.h"
#import "TDbuyerUser.h"
#import "TAllScoCard.h"
#import "kQPayOrder.h"
#import "KQPayPlugin.h"
#import "TAllScoBindingController.h"


#import <openssl/ssl.h>
#import <openssl/bio.h>
#import <openssl/err.h>
#import <openssl/sha.h>
#import <openssl/rsa.h>
#import <openssl/evp.h>

#import "TAllscoPayViewController.h"


#define left_margin_length  10
#define top_margin_length   15

#define orderAndpayway_margit_height    30

#define toolbar_hight       50


@implementation TConfirmPaymentController

- (id)initWithNavigationTitle:(NSString *)title andConfirPay:(TConfirmPay*)confirmPay {
    self = [super initWithNavigationTitle:title];
    self.confirmPay = confirmPay;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _mainScrollView = [[[UIScrollView alloc]initWithFrame:rect]autorelease];
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, _mainScrollView.frame.size.height+.5)];
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    _mainScrollView.delegate = self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    // 底部工具栏
    NSString *paidAmount = _confirmPay.paidAmount;
    rect = CGRectMake(0, self.contentView.frame.size.height-toolbar_hight, self.contentView.frame.size.width, toolbar_hight);
    _toolBarView = [[TConfirmPayToolBar alloc]initWithFrame:rect andPayAmount:paidAmount];
    [_toolBarView setActionForTarget:self];
    [self.contentView addSubview:_toolBarView];
    
    // 订单详情
    rect = CGRectMake(left_margin_length, top_margin_length, self.contentView.frame.size.width-2*left_margin_length, 200);
    _orderView = [[TConfirmPayOrderView alloc]initWithFrame:rect andConfirmPay:_confirmPay];
    [_mainScrollView addSubview:_orderView];
    
    // 支付方式列表
    float h = [_orderView heightForView] + orderAndpayway_margit_height;
    rect = CGRectMake(left_margin_length, h, self.contentView.frame.size.width-2*left_margin_length, 0);
    // _wayView = [[TConfirmPayWayView alloc]initWithFrame:rect andPayways:[self getCurrentOrderSupportPayWay]];
    _wayView = [[TConfirmPayWayView alloc]initWithFrame:rect andPayways:_confirmPay.payWays];
    [_mainScrollView addSubview:_wayView];
    
    h += [_wayView heightForView] + 55;
    if (h<self.contentView.frame.size.height) h = self.contentView.frame.size.height+1;
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, h)];
    
    
    // 成功提示
    CheckSuccessView * successView =[[[NSBundle mainBundle]loadNibNamed:@"CheckSuccessView" owner:self options:nil]lastObject];
    successView.center = CGPointMake(160, 290);
    successView.delegate = self;
    successView.backgroundColor = [UIColor clearColor];
    successBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    successBaseView.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:0.8];
    successBaseView.hidden = YES;
    [successBaseView addSubview:successView];
    [self.view addSubview:successBaseView];
    
    CheckFieldView * fieldView =[[[NSBundle mainBundle]loadNibNamed:@"CheckFieldView" owner:self options:nil]lastObject];
    fieldView.center = CGPointMake(160, 290);
    fieldView.delegate = self;
    fieldView.backgroundColor = [UIColor clearColor];
    
    // 失败提示
    fieldBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    fieldBaseView.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:0.8];
    fieldBaseView.hidden = YES;
    [fieldBaseView addSubview:fieldView];
    [self.view addSubview:fieldBaseView];
}

/**
 * 获取当前订单支付方式
 */
- (NSArray*)getCurrentOrderSupportPayWay {
    NSNumber *numberUM = [NSNumber numberWithInt:PayWay_UM];
    NSNumber *numberKQ = [NSNumber numberWithInt:PayWay_KQ];
    NSNumber *numberALLSCO = [NSNumber numberWithInt:PAyWay_ALLSCO];
    
    NSArray *payWays = @[numberUM,numberKQ,numberALLSCO];
    
    return payWays;
}

/**
 * 确认支付按钮被点击时触发该事件
 */
- (void)doPayBtnClicked:(id)sender {
    PayWayType payType = [_wayView getPayWay2checkBox];
    [self doEnterPayView:payType];
}

/**
 * 确认支付按钮被点击
 */
- (void)doEnterPayView:(PayWayType)payWayType {
    if(payWayType == PayWay_UM) { // 银联支付
        [[TUtilities getInstance]popTarget:self.contentView status:@"处理中..."];
        [[TServerFactory getServerInstance:@"TUMServer"]getUmPayViewDataByOrderId:_confirmPay.orderIdList
                                                                      andCallback:^(NSString *resp) {
                                                                          [[TUtilities getInstance]dismiss];
                                                                          UPOMP *upomp = [[UPOMP alloc] initUPOMPWithXML:resp ServerType:ServerProduct];
                                                                          upomp.UPOMPDelegate = self;
                                                                          [self presentViewController:upomp animated:YES completion:nil];
                                                                        } failureCallback:^(NSString *resp) {
                                                                            [[TUtilities getInstance]popMessageError:@"加载失败" target:self.contentView delayTime:1.0];
                                                                        }];
    }
    
    if(payWayType == PayWay_KQ) { // 快钱支付
        [[TUtilities getInstance]popTarget:self.contentView status:@"处理中..."];
        [[TServerFactory getServerInstance:@"TMasCnpServer"]requestPaidDataByOrderId:_confirmPay.orderIdList
                                                                      andOrderAmount:_confirmPay.paidAmount
                                                                         andCallback:^(TKQPayInfo *payInfo) {
                                                                             [[TUtilities getInstance]dismiss];
                                                                             _confirmPay.orderId = payInfo.orderId;
                                                                             [self senderPaidParameter:payInfo];
                                                                         } failureCallback:^(NSString *resp) {
                                                                             [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
                                                                         }];
    }
    
    if(payWayType == PAyWay_ALLSCO) { // 奥斯卡支付
        [[TUtilities getInstance]popTarget:self.contentView status:@"处理中..."];
        TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
        [[TServerFactory getServerInstance:@"TAllScoServer"]selectCardsByPhoneNumber:dbuyerUser.name
                                                                         andCallback:^(NSArray *datas,NSString *usageFor) {
                                                                             [[TUtilities getInstance]dismiss];
                                                                             
            if (datas.count == 0) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有绑定过预付卡卡号，确定要绑定预付卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                [alert show];
                return;
            } else {
                [self openAllscoPayController:datas];
            }
        } failureCallback:^(NSString *resp) {
            [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
        }];
    }
}

- (void)openAllscoPayController:(NSArray*)datas {
    TAllscoPayViewController *allscoPayController = [[TAllscoPayViewController alloc]initWithNavigationTitle:@"" andDatas:datas];
    allscoPayController.allscoPayDelegate = self;
    allscoPayController.confirmPay = _confirmPay;
    allscoPayController.hasBackAction = NO;
    [self.navigationController presentViewController:allscoPayController animated:YES completion:nil];
}

/**
 * 发送快钱支付
 */
- (void)senderPaidParameter:(TKQPayInfo*)payInfo {
    [[TUtilities getInstance]setControlAppVar:YES]; // 打开更新开关，让个人中心页做一次刷新
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *configArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userConfig" ofType:@"plist"]];
	NSDictionary *config = (NSDictionary *)[configArray objectAtIndex:0];
    
    kQPayOrder = [[KQPayOrder alloc] init];
    [kQPayOrder setOrderId:payInfo.orderId];
    [kQPayOrder setAmt:[NSString stringWithFormat:@"%@",payInfo.orderAmount]];
    [kQPayOrder setMerchantName:@"尚鳞科技"];
    [kQPayOrder setProductName:payInfo.goodName];
    [kQPayOrder setUnitPrice:@"59"];
    [kQPayOrder setTotal:payInfo.productNum];
    [kQPayOrder setMerchantOrderTime:payInfo.orderTime];
    [[KQPayPlugin Instance] setKqPayorder:kQPayOrder];
    
    /* 如传递卡信息 需调用 */
    [[KQPayPlugin Instance] UserCardInfo:@"" //银行卡号  全卡号或短卡号(已绑定卡前6后4)（非必须）
                                cardType:@"" //银行卡类型（非必须）
                                  bankId:@"" //银行Id（非必须）
     ];

    [[KQPayPlugin Instance] Pay:self
                       PayOrder:kQPayOrder
                      OrderSign:[self generateOrderSign]
                      QuerySign:[self generateQuerySign:payInfo.payerId]
                           MebCode:[config objectForKey:@"mebCode"]
                     MerchantId:[config objectForKey:@"merchantId"]
                  PartnerUserId:payInfo.payerId
                            URL:[config objectForKey:@"billServer"]];

	[pool release];
}

/**
 * 生成QuerySign
 */
- (NSString *)generateQuerySign:(NSString*)userId {
    
	NSArray *configArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userConfig" ofType:@"plist"]];
	NSDictionary *config = (NSDictionary *)[configArray objectAtIndex:0];
    
    unsigned char sigret[512] = {0};
    FILE *fp = fopen([[[NSBundle mainBundle] pathForResource:[config objectForKey:@"billPrivate"] ofType:@"pem"] cStringUsingEncoding:NSUTF8StringEncoding],"r");
    EVP_PKEY *pKey = PEM_read_PrivateKey(fp, NULL, NULL, NULL);
    fclose(fp);
    
    EVP_MD_CTX ctx;
    EVP_MD_CTX_init(&ctx);
    EVP_SignInit_ex(&ctx, EVP_sha1(), NULL);
    
    //订单参数
    NSString *queryInfo  =  [[KQPayPlugin Instance] GenerateCardQuerySign:[config objectForKey:@"mebCode"] MerchantId:[config objectForKey:@"merchantId"] PartnerUserId:userId];
    //
    EVP_SignUpdate(&ctx, [queryInfo UTF8String], strlen([queryInfo UTF8String]));
    
    unsigned int siglen = EVP_PKEY_size(pKey);
    EVP_SignFinal(&ctx, sigret, &siglen, pKey);
    EVP_MD_CTX_cleanup(&ctx);
    EVP_PKEY_free(pKey);
    
    char out[1024] = {0};
    EVP_EncodeBlock((unsigned char*)out, sigret, siglen);
    
    return [NSString stringWithFormat:@"%s",out];
}


/**
 * 生成OrderSign
 */
- (NSString *)generateOrderSign {
	NSArray *configArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userConfig" ofType:@"plist"]];
	NSDictionary *config = (NSDictionary *)[configArray objectAtIndex:0];
    
    unsigned char sigret[512] = {0};
    FILE *fp = fopen([[[NSBundle mainBundle] pathForResource:[config objectForKey:@"billPrivate"] ofType:@"pem"] cStringUsingEncoding:NSUTF8StringEncoding],"r");
    EVP_PKEY *pKey = PEM_read_PrivateKey(fp, NULL, NULL, NULL);
    fclose(fp);
    EVP_MD_CTX ctx;
    EVP_MD_CTX_init(&ctx);
    EVP_SignInit_ex(&ctx, EVP_sha1(), NULL);
    
    //订单参数
    NSString *orderInfo  =  [[KQPayPlugin Instance] GenerateOrderSignSrc];
    //
    EVP_SignUpdate(&ctx, [orderInfo UTF8String], strlen([orderInfo UTF8String]));
    unsigned int siglen = EVP_PKEY_size(pKey);
    EVP_SignFinal(&ctx, sigret, &siglen, pKey);
    EVP_MD_CTX_cleanup(&ctx);
    EVP_PKEY_free(pKey);
    
    char out[1024] = {0};
    EVP_EncodeBlock((unsigned char*)out, sigret, siglen);
    
    return [NSString stringWithFormat:@"%s",out];
}

/**
 * 快钱支付回调
 */
-(void)payResult:(KQ_PayResult)result selfController:(UINavigationController*)controller {
    switch (result) {
        case KQ_PayFaild:
            // [self payFaile];
            break;
        case KQ_PaySucceed:
            [self paySuccess];
            /*支付成功后的回调，向后台发送订单支付成功指令*/
            [[TServerFactory getServerInstance:@"TOrderServer"]doOrderSuccess:_confirmPay.orderId
                                                                     callback:^(NSString *ret) {
                
                                                                        } failureCallback:^(NSString *resp) {
                                                                            
                                                                        }];
            break;
            
        default:
            break;
    }
}

/**
 * 银联支付回调方法
 * 调用XMLParser类进行解析
 */
- (void)closeUPOMPWithXMLString:(NSString *)xmlString {
    UPOMPXMLParser *xmlParser = [[UPOMPXMLParser alloc] init];
    NSData *_xmlStrData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *xmlDictionary = [[NSDictionary alloc]initWithDictionary:[xmlParser parserXML:_xmlStrData]];
    if ([xmlDictionary count] > 0) { // 成功
        NSString * respCode = [xmlDictionary objectForKey:@"respCode"];
        if ([respCode isEqualToString:@"0000"]) [self paySuccess];
        // else [self payFaile];
    }
}

/**
 * 奥斯卡支付回调方法
 */
- (void)allscoPaySuccess:(BOOL)isSuccess {
    if (isSuccess) [self paySuccess];
    // else [self payFaile];
}

/**
 * 银联、奥斯卡、快钱支付返回提示确认框按钮的事件回调处理
 */
- (void)goBackViewControllers {
    NSArray *currentControllers = self.navigationController.viewControllers;
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    [newControllers removeLastObject];
    
    if (successBaseView.hidden) {
        DfkddViewController *dfkVC = [[DfkddViewController alloc] initWithNibName:@"DfkddViewController" bundle:nil];
        [newControllers addObject:dfkVC];
        [self.navigationController setViewControllers:newControllers animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        DfhddViewController *ywcVC = [[DfhddViewController alloc] init];
        [newControllers addObject:ywcVC];
        [self.navigationController setViewControllers:newControllers animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 支付成功
 */
- (void)paySuccess {
    [self dismissViewControllerAnimated:YES completion:nil];
    successBaseView.hidden = NO;
    [self.view bringSubviewToFront:successBaseView];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess"
                                                       object:nil
                                                     userInfo:nil];
}

/**
 * 支付失败
 */
- (void)payFaile {
    [self dismissViewControllerAnimated:YES completion:nil];
    fieldBaseView.hidden = NO;
    [self.view bringSubviewToFront:fieldBaseView];
}

#pragma mark - 弹窗回调方法
-(void)pushDetail:(UIButton*)button{
    switch (button.tag) {
        case 908: { //返回订单
            [self.navigationController popViewControllerAnimated:YES];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            break;
        }
            
        case 9901: { //返回首页
            [self.leveyTabBarController setSelectedIndex:0];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
             break;
        }
           
        case 9902: {
            [self goBackViewControllers];
            break;
        }
            
        case 9903: {  //返回首页
            [self.leveyTabBarController setSelectedIndex:0];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
            
        case 9904: { //直接放回上一页
            [self goBackViewControllers];
            break;
        }
            
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        TAllScoListController *allScoListController = [[TAllScoListController alloc]initWithNavigationTitle:@"我的储值卡"];
        [self.navigationController pushViewController:allScoListController animated:YES];
        [allScoListController release];
    }
}

- (void)leftButtonAction {
    NSArray *controllers = self.navigationController.viewControllers;
    int index = [controllers indexOfObject:self]-1;
    UIViewController *parentlevencon = [controllers objectAtIndex:index];
    if ([parentlevencon isKindOfClass:[SettlementViewController class]]) {
        UIViewController *controller = [controllers objectAtIndex:index-1];
        [self.navigationController popToViewController:controller animated:YES];
        return;
    }
    
    [super leftButtonAction];
}


- (void)dealloc {
    [super dealloc];
    [_confirmPay release];
    _confirmPay = nil;
    
    [_wayView release];
    _wayView = nil;
    
    [_toolBarView release];
    _toolBarView = nil;
    
    [_orderView release];
    _orderView = nil;
}

@end
