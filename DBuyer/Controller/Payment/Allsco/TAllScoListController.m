//
//  TAllScoListController.m
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoListController.h"
#import "TAllScoBindingController.h"
#import "TChargeAllscoController.h"
#import "TServerFactory.h"
#import "TAllScoServer.h"
#import "TUtilities.h"
#import "TAllScoCard.h"

@implementation TAllScoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allscoListForm = [[TAllScoListFormController alloc]init];
    _allscoListForm.allscoListController = self;
    [_allscoListForm.view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_allscoListForm.view];

    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [[TServerFactory getServerInstance:@"TAllScoServer"]selectCardsByPhoneNumber:dbuyerUser.name andCallback:^(NSArray *datas,NSString *usageFor) {
        [[TUtilities getInstance]dismiss];
        [_allscoListForm setUsageForBtnSectionFooter:usageFor];
        
        if (datas.count>0) {
            [[TUtilities getInstance]dismiss];
            [_allscoListForm addDataSources:[datas retain]];
        }
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.0];
    }];
    
//    TAllScoCard *card = [[TAllScoCard alloc]init];
//    card.cardNumber = @"1234567890123456789";
//    card.residual = @"0";
//    NSMutableArray *datas = [[NSMutableArray alloc]init];
//    [datas addObject:card];
//    [_allscoListForm addDataSources:datas];
    
    // 向通知中心注册登录成功事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doBindingSuccess:) name:@"Notification_BindingSuccess" object:nil];
    
    // 向通知中心注册登录成功事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doChargeSuccess:) name:@"Notification_ChargeSuccess" object:nil];
}

/**
 * 绑定成功后的回调
 */
- (void)doBindingSuccess:(NSNotification*)notification {
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [_allscoListForm removeAllSection];
    
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]selectCardsByPhoneNumber:dbuyerUser.name andCallback:^(NSArray *datas,NSString *usageFor) {
        [[TUtilities getInstance]dismiss];
        [_allscoListForm addDataSources:[datas retain]];
        [_allscoListForm setUsageForBtnSectionFooter:usageFor];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.0];
    }];
}

- (void)doChargeSuccess:(NSNotification*)notification {
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [_allscoListForm removeAllSection];
    
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]selectCardsByPhoneNumber:dbuyerUser.name andCallback:^(NSArray *datas,NSString *usageFor) {
        [[TUtilities getInstance]dismiss];
        [_allscoListForm addDataSources:[datas retain]];
        [_allscoListForm setUsageForBtnSectionFooter:usageFor];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.0];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _allscoListForm.root.appearance.buttonAlignment = NSTextAlignmentLeft;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

- (void)doBindingAllsco {
    TAllScoBindingController *allscoBindingController = [[TAllScoBindingController alloc]initWithNavigationTitle:@"绑定储值卡"];
    [self.navigationController pushViewController:allscoBindingController animated:YES];
    [allscoBindingController release];
}

- (void)doChargeAllsco:(TAllScoCard*)card {
    TChargeAllscoController *allscoChargeController = [[TChargeAllscoController alloc]initWithNavigationTitle:@"充值我的预付卡"];
    allscoChargeController.card = card;
    [self.navigationController pushViewController:allscoChargeController animated:YES];
    [allscoChargeController release];
}

- (void)dealloc {
    [super dealloc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notification_BindingSuccess" object:nil];
}


@end
