//
//  ConfirmPaymenViewController.m
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ConfirmPaymenViewController.h"
#import "ConfirmPaymentView.h"
#import "BtnDelegate.h"
#import "CheckFieldView.h"
#import "CheckSuccessView.h"
#import "DfkddViewController.h"
#import "UPOMPXMLParser.h"
#import "YwcListViewController.h"
#import "DfhddViewController.h"
#import "TBill99PayController.h"

#import "TUtilities.h"
#import "TServerFactory.h"
#import "TMasCnpServer.h"

@interface ConfirmPaymenViewController() {
    UPOMP *upomp;
    UIView * successBaseView;
    UIView * fieldBaseView;
}
@property(nonatomic,assign)ConfirmPaymentView *confirmView;
@end

@implementation ConfirmPaymenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViewHandle];
}

#pragma mark - 加载视图处理
- (void)loadViewHandle
{
    // 如果没有数据，则直接调到首页
    if (_order == nil) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    // 加载视图
    self.confirmView = [[ConfirmPaymentView alloc] initWithNib];
    
    // 添加按钮事件
    [self.confirmView addTarget:self selectPayTypeAction:@selector(paymentTypeAction:) paymentAction:@selector(payButtonAction:) quickPayAction:@selector(quickPayAction:)];
    self.confirmView.paymentTypeButton.selected = YES;
    // 初始化视图数据
    
    [self.confirmView SetConfirmPaymenWithOrderId:self.order.orderId amountPayable:[NSString stringWithFormat:@"%0.2f", self.order.paidAmount] presentIntegral:[NSString stringWithFormat:@"%d", self.order.integral]];
    [self.view addSubview:self.confirmView];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1];
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"支付确认" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    // 隐藏TabBar
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
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

#pragma mark 银联支付按钮事件
- (void)paymentTypeAction:(UIButton *)sender {
    self.confirmView.paymentTypeButton.selected = !self.confirmView.paymentTypeButton.selected;
    self.confirmView.quickPayButton.selected = NO;
}

#pragma mark - 快钱支付事件
- (void)quickPayAction:(UIButton *)sender
{
    self.confirmView.quickPayButton.selected = !self.confirmView.quickPayButton.selected;
    self.confirmView.paymentTypeButton.selected = NO;
}
#pragma mark - 去付款按钮事件
- (void)payButtonAction:(UIButton *)sender
{
    if(!self.confirmView.paymentTypeButton.selected && ! self.confirmView.quickPayButton.selected)
    {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:nil message:@"请选择支付方式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
    if(self.confirmView.paymentTypeButton.selected)
    {
        [[self mainDelegate] beginLoad];
        // 调用银联相关操作
        [NSThread detachNewThreadSelector: @selector(sendLoginXml) toTarget: self withObject: nil];
    }
   if(self.confirmView.quickPayButton.selected)
    {
        
//        [[TUtilities getInstance]popTarget:self.view];
//        [[TServerFactory getServerInstance:@"TMasCnpServer"]requestPaidDataByOrderId:self.order.orderId
//                                                                      andOrderAmount:[NSString stringWithFormat:@"%f",self.order.paidAmount]
//                                                                         andCallback:^(NSDictionary *dict) {
//                                                                             [self senderPaidParameter:dict];
//                                                                         } failureCallback:^(NSString *resp) {
//                                                                             [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.0];
//                                                                             
//                                                                         }];
        
    }
}

- (void)senderPaidParameter:(NSDictionary*)dict {
    [[TUtilities getInstance]dismiss];
    NSString *signMsg = [NSString stringWithFormat:@"%@",[dict objectForKey:@"signMsg"]];
    NSString *signMsgVal =  [dict objectForKey:@"signMsgVal"];
    NSString *billBw = [NSString stringWithFormat:@"%@&signMsg=%@",signMsgVal,signMsg];
    NSString *urlString = [NSString stringWithFormat:@"%@mobilegateway/recvMerchantInfoAction.htm?%@",@"http://sandbox.99bill.com/",billBw];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[UIApplication sharedApplication]openURL:url];
    
    /*TBill99PayController *bill99Pay = [[TBill99PayController alloc]initWithURL:url];
    UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:bill99Pay]autorelease];
    [bill99Pay.navigationController setNavigationBarHidden:NO];
    [navi.view setFrame:CGRectMake(0, -50, self.view.frame.size.width, self.view.frame.size.height)];
    [self.navigationController pushViewController:bill99Pay animated:YES];*/
}




#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    // 为了不使订单重新生成，这里返回上一级为结算页面的前面一级
    NSArray *controllers = [NSArray arrayWithArray:self.navigationController.viewControllers];
    [self.navigationController popToViewController:[controllers objectAtIndex:0] animated:YES];
}

#pragma mark - 弹窗回调方法
-(void)pushDetail:(UIButton *)button{
    switch (button.tag) {
        case 908:{
            //返回订单
            [self.navigationController popViewControllerAnimated:YES];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            break;
        }
        case 9901:
        {
            //返回首页
            [self.leveyTabBarController setSelectedIndex:0];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            //            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 9902:
        {
            
            [self goBackViewControllers];
            
//            
//            //返回个人中心
//            [self.leveyTabBarController setSelectedIndex:4];
//            successBaseView.hidden = YES;
//            fieldBaseView.hidden = YES;
//            //            DfhddViewController *df=[[DfhddViewController alloc]init];
//            //            [self.navigationController pushViewController:df animated:YES];
            
        }
            break;
        case 9903:
        {
            //返回首页
            [self.leveyTabBarController setSelectedIndex:0];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
            //            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
            break;
        case 9904:
        {
            //直接放回上一页
            
            /*
             支付失败提示“查看订单”按钮，如果是单笔订单或礼包的支付失败，那就返回该笔订单的详情页，如果是合并支付失败，那就返回待付款订单页。
                暂时没实现
             */
            
            [self goBackViewControllers];
//            
//            
//            
//            // 为了不使订单重新生成，这里返回上一级为结算页面的前面一级
//            NSArray *controllers = [NSArray arrayWithArray:self.navigationController.viewControllers];
//            if ([controllers count] > 0) {
//                [self.navigationController popToViewController:[controllers objectAtIndex:0] animated:YES];
//            } else {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
            

        }
            break;
        default:
            break;
    }
}


#pragma mark - 查看订单返回待付款
- (void)goBackViewControllers
{
    // 失败
    if (successBaseView.hidden) {
        NSArray *currentControllers = self.navigationController.viewControllers;                //获得视图控制器堆栈数组
        NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];    //基于堆栈数组实例化新的数组
        [newControllers removeLastObject];          // 移出确认付款视图
        [newControllers removeLastObject];          // 移出结算中心视图
        DfkddViewController *dfkVC = [[DfkddViewController alloc] initWithNibName:@"DfkddViewController" bundle:nil];
        [newControllers addObject:dfkVC];
        [self.navigationController setViewControllers:newControllers animated:YES];             //为堆栈重新赋值
        [self.navigationController popViewControllerAnimated:YES];
    // 成功
    } else {
        NSArray *currentControllers = self.navigationController.viewControllers;                //获得视图控制器堆栈数组
        NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];    //基于堆栈数组实例化新的数组
        [newControllers removeLastObject];          // 移出确认付款视图
        [newControllers removeLastObject];          // 移出结算中心视图
        DfhddViewController *ywcVC = [[DfhddViewController alloc] init];
        [newControllers addObject:ywcVC];
        [self.navigationController setViewControllers:newControllers animated:YES];             //为堆栈重新赋值
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 银联操作
#pragma mark 获取订单
- (void)sendLoginXml//登录数据请求
{
    NSString * plugInUrl = [NSString stringWithFormat:@"%@payMent/result/submitOrder?orderId=%@",serviceHost,self.order.orderId];
    
    NSURL *url = [NSURL URLWithString:plugInUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    //获取返回值
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];//获取返回值
    //    NSString *retrunText = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];//格式转换
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
    NSString * returnStatus = [dict objectForKey:@"status"];
    if (returnStatus.intValue ==0) {
        [[self mainDelegate] endLoad];
        NSString *retrunText = [dict objectForKey:@"lanchPayXml"];
        //多线程操作ui使用以下方法
        [self performSelectorOnMainThread:@selector(goCustomerInfoView:) withObject:retrunText waitUntilDone:YES];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark 调用插件
-(void)goCustomerInfoView :(NSString *)infoXML
{
    upomp = [[UPOMP alloc] initUPOMPWithXML:infoXML ServerType:ServerProduct];//ServerProduct
    upomp.UPOMPDelegate = self;
    [self presentViewController:upomp animated:YES completion:nil];
}
#pragma mark 获取返回参数回调方法
- (void)closeUPOMPWithXMLString:(NSString *)xmlString
{
    //调用XMLParser类进行解析
    UPOMPXMLParser *xmlParser = [[UPOMPXMLParser alloc] init];
    NSData *_xmlStrData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];//将String转成Data
    NSDictionary *xmlDictionary = [[NSDictionary alloc]initWithDictionary:[xmlParser parserXML:_xmlStrData]];
    if ([xmlDictionary count] > 0) {
        NSString * respCode = [xmlDictionary objectForKey:@"respCode"];
        if ([respCode isEqualToString:@"0000"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            successBaseView.hidden = NO;
            [self.view bringSubviewToFront:successBaseView];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_DbuyerLoginSucess" object:nil userInfo:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
            fieldBaseView.hidden = NO;
            [self.view bringSubviewToFront:fieldBaseView];
        }
    }
}

#pragma mark - 弹窗
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
