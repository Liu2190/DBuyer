//
//  AppDelegate.h
//  DBuyer
//
//  Created by liuxiaodan on 13-9-16.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "Reachability.h"
#import "LeveyTabBarController.h"
#import "BMapKit.h"

enum{
    SINA=1,
    WECHAT=2,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate,UIAlertViewDelegate>{
    
    LoadView *loadView;
    Reachability* hostReach;
    LeveyTabBarController * leveyTabBarController;
    BMKMapManager * _mapManager;
    UIAlertView * forcedUpdateView;
    UIAlertView * notForcedUpdateView;
    UIImageView *finishLaunch;
    BOOL isHidden;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)int urlMark;
@property(nonatomic,assign)int countOfCart;//未登录状态下购物车的数量
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSMutableArray *clockArray;
@property(nonatomic,strong)NSString *downLoadUrl;
@property(nonatomic,strong)NSString *notForcedVersion;
-(void)beginLoad;
-(void)endLoad;
-(void)getShoppingCartNum;
-(void)changeTabbarCartNum:(int)number;
-(void)submitProToNet;
@end
