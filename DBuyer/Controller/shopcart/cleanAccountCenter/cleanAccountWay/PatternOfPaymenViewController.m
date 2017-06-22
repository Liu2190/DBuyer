//
//  PatternOfPaymenViewController.m
//  DBuyer
//  支付方式页面
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "PatternOfPaymenViewController.h"
#import "BtnDelegate.h"
#import "UPOMPXMLParser.h"
//#import "RetrunViewController.h"
#import "CheckFieldView.h"
#import "CheckSuccessView.h"
#import "DfhddViewController.h"
#import "OrderFooterView.h"



@interface PatternOfPaymenViewController ()

@end

@implementation PatternOfPaymenViewController
{
    UPOMP *upomp;
    UIView * successBaseView;
    UIView * fieldBaseView;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _orderID = [[NSString alloc]init];//订单号
        _amountPayable= [[NSString alloc]init]; //消费金额
        _integral= [[NSString alloc]init]; //返回积分
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.yingfujifen.text = [NSString stringWithFormat:@"应付金额：%@",self.amountPayable];
    self.totalPriceLabel.text = self.amountPayable;
    self.zengsongjifen.text = [NSString stringWithFormat:@"赠送积分：%@分",self.integral];
    self.haoma.text = self.orderID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=BACKCOLOR;
    self.delegate=self;
    [_btn1 setImage:[UIImage imageNamed:@"切片绿_向左"] forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"切片绿_向左1"] forState:UIControlStateHighlighted];
    _label1.textColor=TITLECOLOR;
    _label2.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
    _label3.textColor=[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1];
    _yingfujifen.textColor=[UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1];
    _zengsongjifen.textColor=[UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1];
    _jiangliwenan.textColor=[UIColor colorWithRed:139.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1];
    
    _dingdanhao.textColor=[UIColor colorWithRed:139.0/255.0 green:139.0/255.0 blue:139.0/255.0  alpha:1];
    _haoma.textColor=[UIColor colorWithRed:238.0/255.0 green:163.0/255.0  blue:7.0/255.0  alpha:1];
    _yingfujifen.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
    
    CheckSuccessView * successView =[[[NSBundle mainBundle]loadNibNamed:@"CheckSuccessView" owner:self options:nil]lastObject];
    successView.center = CGPointMake(160, 290);
    successView.delegate = self;
    successView.backgroundColor = [UIColor clearColor];
    successBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    successBaseView.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:0.8];
    successBaseView.hidden = YES;
    [successBaseView addSubview:successView];
    [self.view addSubview:successBaseView];
    
    CheckSuccessView * fieldView =[[[NSBundle mainBundle]loadNibNamed:@"CheckFieldView" owner:self options:nil]lastObject];
    fieldView.center = CGPointMake(160, 290);
    fieldView.delegate = self;
    fieldView.backgroundColor = [UIColor clearColor];
    fieldBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    fieldBaseView.backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:128.0f/255.0f blue:128.0f/255.0f alpha:0.8];
    fieldBaseView.hidden = YES;
    [fieldBaseView addSubview:fieldView];
    [self.view addSubview:fieldBaseView];
    
    
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"支付方式" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    OrderFooterView *footer = [[OrderFooterView alloc] initWithTotalPrice:@"892.00" payButtonTitle:@"确认支付" CheckBoxHidden:YES];
    footer.frame = CGRectMake(0, 130, 320, 60);
    [self.view addSubview:footer];
    
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
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
            //返回个人中心
            [self.leveyTabBarController setSelectedIndex:4];
            successBaseView.hidden = YES;
            fieldBaseView.hidden = YES;
//            DfhddViewController *df=[[DfhddViewController alloc]init];
//            [self.navigationController pushViewController:df animated:YES];
            
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
            [self.navigationController popViewControllerAnimated:YES];
//            DfhddViewController *df=[[DfhddViewController alloc]init];
//            [self.navigationController pushViewController:df animated:YES];
        }
            break;
        default:
            break;
    }
}
//- (void)dealloc {
//    [_totalPriceLabel release];
//    [super dealloc];
//}
- (IBAction)didClickPayButton:(UIButton *)sender {
    //    [self sendLoginXml];
    [NSThread detachNewThreadSelector: @selector(sendLoginXml) toTarget: self withObject: nil];
    
}

#pragma mark - 银联Demo
//获取订单
- (void)sendLoginXml//登录数据请求
{
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];//开线程要创建自动回收池
    
    //        //获取代理设置
    //        NSDictionary *proxySettings = NSMakeCollectable([(NSDictionary *)CFNetworkCopySystemProxySettings() autorelease]);
    //        NSArray *proxies = NSMakeCollectable([(NSArray *)CFNetworkCopyProxiesForURL((CFURLRef)[NSURL URLWithString:@"http://www.google.com"], (CFDictionaryRef)proxySettings) autorelease]);
    //        NSDictionary *settings = [proxies objectAtIndex:0];
    //        NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    //        NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    //        NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    
    /* 康建给的地址
     1)测试环境：http://devdemo.argorse.com.cn:8080/merchantServer/PluginOrderTest
     2)生产环境：http://devdemo.argorse.com.cn:8080/merchantProServer/PluginOrderTest
     */
    
//    NSString * plugInUrl = @"http://devdemo.argorse.com.cn:8080/merchantProServer/PluginOrderTest";
    
    NSString * plugInUrl = [NSString stringWithFormat:@"%@payMent/result/submitOrder?orderId=%@",serviceHost,self.orderID];
    
    NSURL *url = [NSURL URLWithString:plugInUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    //获取返回值
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];//获取返回值
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:nil];
    NSString * returnStatus = [dict objectForKey:@"status"];
    if (returnStatus.intValue ==0) {
        
        NSString *retrunText = [dict objectForKey:@"lanchPayXml"];
        
        //多线程操作ui使用以下方法
        [self performSelectorOnMainThread:@selector(goCustomerInfoView:) withObject:retrunText waitUntilDone:YES];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
//    if (retrunText) {
//        
//        //        [self performSelector:@selector(goCustomerInfoView:) withObject:retrunText];
//    }
    
    //    [plugInUrl release];
    //    [request release];
    //    [retrunText release];
    //
    //
    //    [pool release];
    
}

//调用插件
-(void)goCustomerInfoView :(NSString *)infoXML{
    //    [self waitingViewHidden];
    
    upomp = [[UPOMP alloc] initUPOMPWithXML:infoXML ServerType:ServerProduct];//ServerProduct
    
    upomp.UPOMPDelegate = self;
    //    [self.navigationController pushViewController:upomp animated:YES];
//    [self presentModalViewController:upomp animated:YES];
    [self presentViewController:upomp animated:YES completion:nil];
    
    //    [upomp release];
    //    UINavigationBar
    
}


//获取返回参数回调方法
- (void)closeUPOMPWithXMLString:(NSString *)xmlString{
    
    //调用XMLParser类进行解析
    UPOMPXMLParser *xmlParser = [[UPOMPXMLParser alloc] init];
    NSData *_xmlStrData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];//将String转成Data
    NSDictionary *xmlDictionary = [[NSDictionary alloc]initWithDictionary:[xmlParser parserXML:_xmlStrData]];
    //    [xmlParser release];
    
    
    //    [self.navigationController popViewControllerAnimated:YES];
    if ([xmlDictionary count] > 0) {
        NSString * respCode = [xmlDictionary objectForKey:@"respCode"];
        if ([respCode isEqualToString:@"0000"]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            successBaseView.hidden = NO;
            [self.view bringSubviewToFront:successBaseView];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
            fieldBaseView.hidden = NO;
            [self.view bringSubviewToFront:fieldBaseView];
        }
        
        //        NSString * xmlDictionary = xmlString;
        
    }
    //    [self.navigationController pushViewController:retrunVC animated:NO];
    
    
    //    RetrunViewController *retrunVC = [[RetrunViewController alloc]initWithNibName:@"RetrunViewController" bundle:nil];
    //    if ([xmlDictionary count] > 0) {
    //        retrunVC.respCode = [xmlDictionary objectForKey:@"respCode"];
    //
    //        retrunVC.xmlDictionary = xmlString;
    //    }
    //    [self.navigationController pushViewController:retrunVC animated:NO];
    //    [retrunVC release];
    //
    //    [xmlDictionary release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)dealloc {
//    [_submitButton release];
//    [super dealloc];
//}
@end
