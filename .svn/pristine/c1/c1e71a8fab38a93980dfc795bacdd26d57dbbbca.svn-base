//
//  AppDelegate.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-16.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AppDelegate.h"
#import "ThirdViewController.h"
#import "HttpDownload.h"
#import "MD5.h"
#import "TimeStamp.h"
#import "UIDevice+Resolutions.h"
#import "DBManager.h"
#import "ShoppingCartViewController.h"
#import "LoadView.h"
#import "PlanViewController.h"
#import "UserGuideViewController.h"
#import "BMKMapView.h"
#import "HomeViewController.h"
#import "MobClick.h"
#import "TExceptionHandle.h"
#import "TUtilities.h"
#import "TUserCenterController.h"
#import "StartPoint.h"

@implementation AppDelegate

@synthesize userName,password,clockArray,countOfCart;

//网络检测
- (void) reachabilityChanged: (NSNotification* )note {
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
    
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    if ([curReach currentReachabilityStatus] == NotReachable) {
        
        //[self showAlert:@"网络错误,请稍后重试"];
        
    }else if ([curReach currentReachabilityStatus] == ReachableViaWiFi){
        
        //        [self showAlert:@"ReachableViaWiFi"];
        
    }else if([curReach currentReachabilityStatus] == ReachableViaWWAN){
        
//        [self showAlert:@"提醒:您现在的是使用3G/GPRS网络"];
    }
}

-(void)showAlert:(NSString *)info{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.downLoadUrl=[[NSString alloc]init];
    self.notForcedVersion = [[NSString alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [[TExceptionHandle getInstance]installUncaughtExceptionHandler];
    application.applicationIconBadgeNumber = 0;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    [MobClick startWithAppkey:@"52b93b4756240be10b008a05"];
    hostReach = [[Reachability reachabilityWithHostname: @"www.baidu.com"] retain];
	[hostReach startNotifier];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WEIBOKEY];
    [WXApi registerApp:WEIXINKEY];
    [self addLoadView];
    [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"versionNum"];//版本号为2
    [self update];
    HomeViewController *one=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    PlanViewController *sec=[[PlanViewController alloc]init];
    ThirdViewController *thi=[[ThirdViewController alloc]init];
    ShoppingCartViewController * shoppintCartVC = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
    TUserCenterController *fif = [[TUserCenterController alloc]initWithImageUrls:nil andNavigationTitle:@"个人中心"];
    
    UINavigationController *nc1=[[UINavigationController alloc]initWithRootViewController:one];
    UINavigationController *nc2=[[UINavigationController alloc]initWithRootViewController:sec];
    UINavigationController *nc3=[[UINavigationController alloc]initWithRootViewController:thi];
    UINavigationController *nc4=[[UINavigationController alloc]initWithRootViewController:shoppintCartVC];
    UINavigationController *nc5=[[UINavigationController alloc]initWithRootViewController:fif];
    
    NSArray *array=[NSArray arrayWithObjects:nc1,nc2,nc3,nc4,nc5,nil];
    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic setObject:[UIImage imageNamed:@"tab1.png"] forKey:@"Default"];
	[imgDic setObject:[UIImage imageNamed:@"tab1s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:[UIImage imageNamed:@"tab2.png"] forKey:@"Default"];;
	[imgDic2 setObject:[UIImage imageNamed:@"tab2s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:[UIImage imageNamed:@"tab3"] forKey:@"Default"];;
	[imgDic3 setObject:[UIImage imageNamed:@"tab3s"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:[UIImage imageNamed:@"tab4.png"] forKey:@"Default"];
	[imgDic4 setObject:[UIImage imageNamed:@"tab4s.png"] forKey:@"Seleted"];
	NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic5 setObject:[UIImage imageNamed:@"tab5.png"] forKey:@"Default"];
	[imgDic5 setObject:[UIImage imageNamed:@"tab5s.png"] forKey:@"Seleted"];
	
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic3,imgDic4,imgDic5,nil];
    leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:array imageArray:imgArr];
	[leveyTabBarController setTabBarTransparent:YES];
    _mapManager=[[BMKMapManager alloc]init];
    BOOL ret=[_mapManager start:@"anRvxpZu4vFBtSdhdoWdxmWX" generalDelegate:nil];
    if(!ret) {
    }
    [self updateInterfaceWithReachability: hostReach];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"firstLaunch"];
        UserGuideViewController *userGuide = [[UserGuideViewController alloc] init];
        self.window.rootViewController=userGuide;
    } else{
        self.window.rootViewController=leveyTabBarController;
    }
    [self.window makeKeyAndVisible];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setHiddenStatuBarByMake];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:isHidden withAnimation:UIStatusBarAnimationSlide];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setHiddenStatuBar:)
                                                 name:@"ApplicationSetStatusBar"
                                               object:nil];
    //添加程序启动画面
    [self addFinishLaunch];
    return YES;
}
-(void)addFinishLaunch
{
    finishLaunch = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    if(isIPhone5)
    {
        finishLaunch.image =[UIImage imageNamed:@"FinishLaunching@2x.png"];
    }
    else{
        finishLaunch.image =[UIImage imageNamed:@"FinishLaunching.png"];
    }
    [self.window addSubview:finishLaunch];
    NSTimeInterval timeInterval = 2.0 ;
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleMaxShowTimer) userInfo:nil repeats:NO];
}
-(void)handleMaxShowTimer
{
    [finishLaunch removeFromSuperview];
}
-(void)update{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.type=8000;
    hd.delegate=self;
    NSString *str=[NSString stringWithFormat:@"%@interface/version/queryVersionInfo?versionNum=%d&type=1",serviceHost,[[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"] intValue]];//安卓type为0，IOS为1
    
    hd.method=@selector(downloadComplete:);
    [hd downloadFromUrlWithASI:str];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self update];
}

-(void)addLoadView{
    loadView = [LoadView loadView];
    loadView.tag = LoadViewFlag;
    [self.window addSubview:loadView];
}

-(void)beginLoad{
    [self.window bringSubviewToFront:loadView];
    loadView.beStop = NO;
}

-(void)endLoad{
    [self.window bringSubviewToFront:loadView];
    loadView.beStop = YES;
}

-(void)downloadComplete:(HttpDownload *)hd{
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData
                                                       options:NSJSONReadingMutableContainers error:nil];
    
    if(dict){
        if(hd.type == 10089)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShoppingCartRefresh" object:nil];
            [[DBManager sharedDatabase]deleteAllthingInShoppinglist];
            [self getShoppingCartNum];
        }
        if(hd.type==1989){
            if([[dict objectForKey:@"status"]intValue]==0){ // 查询购物车列表
                [self changeTabbarCartNum:[[dict objectForKey:@"count"] intValue]];
                
            }
        }
        
        if(hd.type==10){ // 登录请求成功
            if([[dict objectForKey:@"status"]intValue]==0){
                NSString *userId = [[dict objectForKey:@"user"] objectForKey:@"ID"];
                if( userId )
                {
                    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userid"];
                }
                /*发起"查询购物车列表"请求 */
                [self getShoppingCartNum];
                NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
                NSLog(@"%@登录成功",str);
                HttpDownload *hd2=[[HttpDownload alloc]init];
                hd2.delegate=self;
                hd2.type=14;
                hd2.method=@selector(downloadComplete:);
                NSMutableDictionary *dict1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
                [hd2 downloadFromUrlWithASI:[NSString stringWithFormat:planList,serviceHost] dict:dict1];
                if (![[NSUserDefaults standardUserDefaults] objectForKey:str]) {
                    
                    /*发起"查询购物计划列表"请求 */
                    [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
                }
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:@""forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:@""forKey:@"password"];
            }
        }
        
        if(hd.type==14){ // 查询购物计划列表
            [[DBManager sharedDatabase] getListFromNetWithDict:dict
                                                  WithUsername:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
        }
        
        if(hd.type==8000) {//应用内下载最新的应用
            if([[dict objectForKey:@"status"] intValue]!=0){
                self.downLoadUrl = [dict objectForKey:@"downLoadUrl"];
                //如果不是最新版本
                NSString *tips =[NSString stringWithFormat:@"发现新版本：%@",[dict objectForKey:@"versionName"]];
                if([[dict objectForKey:@"mark"] intValue]!=0){
                    //强制更新
                    forcedUpdateView = [[UIAlertView alloc]initWithTitle:tips message:[dict objectForKey:@"updateInfo"] delegate:self cancelButtonTitle:@"去升级" otherButtonTitles:nil, nil];
                    [forcedUpdateView show];
                }
                else {
                    //非强制更新
                    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"notForcedVersion"]isEqualToString:[dict objectForKey:@"versionName"]])
                        {
                            //不再提示
                            return;
                        }
                    self.notForcedVersion = [dict objectForKey:@"versionName"];
                    notForcedUpdateView=[[UIAlertView alloc]initWithTitle:tips message:[dict objectForKey:@"updateInfo"] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"不再提醒",@"去升级", nil];
                    [notForcedUpdateView show];
                }
            } else{
                   //当前版本是最新的版本
            }
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == forcedUpdateView)
    {
        [self exitApplication];//强制更新：退出应用
        NSURL * url = [NSURL URLWithString:self.downLoadUrl];//进入下载页面
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else{
            
        }
    }
    if(alertView == notForcedUpdateView)
    {
        if(buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults]setObject:self.notForcedVersion forKey:@"notForcedVersion"];
        }
        else
        {
            
            notForcedUpdateView.hidden = YES;
            if(buttonIndex == 0)
            {
                
            }else
            {
                NSURL * url = [NSURL URLWithString:self.downLoadUrl];//进入下载页面
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                } else{
                    
                }
                [self exitApplication];//非强制更新：退出应用
            }
        }
    }
}

#pragma mark - 退出应用代码
- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    [UIView commitAnimations];
}


- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[TUtilities getInstance]setControlAppVar:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    if(application.applicationIconBadgeNumber!=0){
        
    }
    NSString * name = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    NSString * pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    if (!(name.length > 0 && pwd.length > 0)) {
        countOfCart=[[DBManager sharedDatabase]getAllcountfromShoppinglist];
        NSString *countString = [NSString stringWithFormat:@"%d",countOfCart];
        [leveyTabBarController addNumToCarList:countString];
        return;
    }
    
    HttpDownload *hd = [[HttpDownload alloc]init];
    hd.delegate = self;
    hd.type = 10;
    hd.method = @selector(downloadComplete:);
    NSString *url = [NSString stringWithFormat:LOGIN,serviceHost];
    NSMutableDictionary *dict55 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:name, @"phone", pwd,@"password",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"], @"versionNum", @"2", @"os_code", [NSString stringWithFormat:@"%d", [UIDevice currentResolution]], @"size_code", nil];
    [hd getResultData:dict55 baseUrl:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if(_urlMark==SINA){
        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if (_urlMark==WECHAT){
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return NO;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if(_urlMark==SINA){
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if (_urlMark==WECHAT){
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return NO;
}

#pragma mark - weibosdkdelegate
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    if([request isKindOfClass:WBProvideMessageForWeiboRequest.class]){
        
    }
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        if(response.statusCode==WeiboSDKResponseStatusCodeSuccess){

        } else if (response.statusCode==WeiboSDKResponseStatusCodeUserCancel){
            
        } else if (response.statusCode == WeiboSDKResponseStatusCodeSentFail){
            
        }
        
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if(response.statusCode==WeiboSDKResponseStatusCodeAuthDeny){
            
        } else if (response.statusCode==WeiboSDKResponseStatusCodeSuccess){
            
        }
    }
}

#pragma mark - WXAPIDELEGATE
-(void)onReq:(BaseReq *)req{

}

-(void)onResp:(BaseResp *)resp{
    int result=[resp errCode];
    if(result==0){

    }
}
#pragma mark -  推送
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
}



- (void)setHiddenStatuBarByMake {
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        if(IsIOS7)[[UIApplication sharedApplication] setStatusBarHidden:isHidden withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)setHiddenStatuBar:(NSNotification *)notification{
    NSString *value = [notification object];
    if([value isEqualToString:@"0"]) {
        isHidden = YES;
        [self setHiddenStatuBarByMake];
    } else {
        isHidden = NO;
        [self setHiddenStatuBarByMake];
    }
}

- (BOOL)prefersStatusBarHidden {
    return isHidden;
}
-(void)getShoppingCartNum
{
    NSString *url=[NSString stringWithFormat:@"%@interface/goodsCar/queryCarCount",serviceHost];
    HttpDownload *hd1=[[HttpDownload alloc]init];
    hd1.delegate=self;
    hd1.type=1989;
    hd1.method=@selector(downloadComplete:);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd1 downloadFromUrlWithASI:url dict:dict];
}
-(void)changeTabbarCartNum:(int)number
{
    countOfCart = number;
    NSString *count = [NSString stringWithFormat:@"%d",countOfCart];
    [leveyTabBarController addNumToCarList:count];
}
-(void)submitProToNet
{
    if([[DBManager sharedDatabase]getAllcountfromShoppinglist]>0)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:[[DBManager sharedDatabase]batchInsertToNet] forKey:@"ids"];
        HttpDownload *hd=[[HttpDownload alloc]init];
        hd.delegate=self;
        [hd getResultData:dict baseUrl:[NSString stringWithFormat:insertToGoods,serviceHost]];
        hd.type =10089;
        hd.method=@selector(downloadComplete:);
    }
}
@end
