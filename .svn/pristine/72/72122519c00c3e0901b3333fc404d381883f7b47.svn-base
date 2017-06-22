//
//  MyOrderViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-28.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "MyOrderViewController.h"
#import "DfkddViewController.h"
#import "YwcListViewController.h"
#import "DfhddViewController.h"
#import "LeveyTabBarController.h"
#import "HttpDownload.h"
#import "TimeStamp.h"
#import "MD5.h"
#import "UIDevice+Resolutions.h"
#import "AppDelegate.h"
#import "WCAlertView.h"
#import "BtnDelegate.h"
#import "Product.h"
#import "UIImageView+WebCache.h"
#import "OrderView.h"
#import "TReturnOrderListController.h"
#import "StartPoint.h"
#define ORDERVIEW_BACKGROUND_COLOR  [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1] // 我的订单背景颜色

@interface MyOrderViewController () {
    OrderView *oView;
}
@end

@implementation MyOrderViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.failMethod = @selector(downloadFail);
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    hd.type=10;
    [hd downloadFromUrl:[NSString stringWithFormat:IndividualCenter,serviceHost]];
    [[self mainDelegate] beginLoad];
    
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mainDelegate = [self mainDelegate];
    
    // 加载我的订单View
    UIScrollView *scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint])];
    scrol.contentSize = CGSizeMake(WindowWidth, 500);
    scrol.userInteractionEnabled = YES;
    [self.view addSubview:scrol];
    oView = [OrderView loadNibViewWithName:@"OrderView"];
    oView.backgroundColor =  ORDERVIEW_BACKGROUND_COLOR;  // 背景颜色
    [oView addTarget:self Action:@selector(pushViewController:)];
    [oView setStayPayment:YES tipNum:0];
    [oView setConsigne:YES tipNum:0];
    [oView setFinish:YES tipNum:0];
    [oView setTuikuan:YES tipNum:0];
    
    oView.frame = CGRectMake(0, 0, 320, 450);
    [scrol addSubview:oView];
    
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"我的订单" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
}

#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}

#pragma mark - 下载数据
-(void)downloadFail{
    
    [mainDelegate endLoad];
}

#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd1{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        [mainDelegate endLoad];
                
        if([[dict objectForKey:@"status"] intValue]==0){
            // 判断是否有相关订单是否>0，设置Bubble显示
            if ([dict[@"noPayOrderInfo"] integerValue]!=0) {
                [oView setStayPayment:NO tipNum:[dict[@"noPayOrderInfo"] integerValue]];
            }
            if ([dict[@"noGetGoods"] integerValue]!=0) {
                [oView setConsigne:NO tipNum:[dict[@"noGetGoods"] integerValue]];
            }
            if ([dict[@"alreadyGoods"] integerValue]!=0) {
                [oView setFinish:NO tipNum:[dict[@"alreadyGoods"] integerValue]];
            }
            if ([dict[@"refundCount"] integerValue]!=0) {
                [oView setFinish:NO tipNum:[dict[@"refundCount"] integerValue]];
            }
        }
    }
}


#pragma mark - 按钮点击事件
- (void)pushViewController:(id)sender
{
#define STAYPAYMENT_BUTTON_TAG  800  // 等待付款
#define CONSIGNE_BUTTON_TAG     801  // 等待收货
#define FINISH_BUTTON_TAG       802  // 完成付款
#define TUIKUAN                 803  // 退款
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case STAYPAYMENT_BUTTON_TAG:
        {
            DfkddViewController *df=[[DfkddViewController alloc]init];
            [self.navigationController pushViewController:df animated:YES];
        }
            break;
        case CONSIGNE_BUTTON_TAG:
        {
            DfhddViewController *df=[[DfhddViewController alloc]init];
            [self.navigationController pushViewController:df animated:YES];
        }
            
            break;
        case FINISH_BUTTON_TAG:
        {
            YwcListViewController *ywc=[[YwcListViewController alloc]init];
            [self.navigationController pushViewController:ywc animated:YES];
        }
            break;
            case TUIKUAN:
        {
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            TReturnOrderListController *reOrderListController = [[TReturnOrderListController alloc]initWithNavigationTitle:@"退款中订单"];
            [self.navigationController pushViewController:reOrderListController animated:YES];
            [reOrderListController release];
        }
            break;
        default:
            break;
    }
}
#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
