//
//  KQPayPlugin.h
//  KQPayPlugin
//
//  Created by Hunter Li on 13-2-17.
//  Copyright (c) 2013年 99Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KQPayPluginDelegate.h"

@class KQPayOrder;
@interface KQPayPlugin : NSObject
{
    id<KQPayPluginDelegate> kqDelegate;
    
    KQPayOrder  *kqPayorder;            
}

@property(nonatomic,assign) id kqDelegate;

@property(nonatomic,retain) KQPayOrder  *kqPayorder;


+ (KQPayPlugin *) Instance;

/**********支付接口**********/
-(void)Pay:(UIViewController*)bviewController PayOrder:(KQPayOrder*)payOrderU OrderSign:(NSString *)orderSign QuerySign:(NSString *)querySign MebCode:(NSString *)mebCodeU MerchantId:(NSString *)merchantIdU PartnerUserId:(NSString *)partnerUserIdU URL:(NSString *)urlU;

/****用户卡列表查询接口****/
- (void)CardListWithMebCode:(UIViewController*)bviewController MebCode:(NSString *)mebCodeU MerchantId:(NSString *)merchantIdU PartnerUserId:(NSString *)partnerUserIdU  URL:(NSString *)url PayOrder:(KQPayOrder*)payOrderU OrderSign:(NSString *)orderSign QuerySign:(NSString *)querySign;

/****支持的银行查询*****/
- (void)SupportBanks:(UIViewController*)bviewController MebCode:(NSString *)mebCodeU MerchantId:(NSString *)merchantIdU PartnerUserId:(NSString *)partnerUserIdU  URL:(NSString *)url PayOrder:(KQPayOrder*)payOrderU OrderSign:(NSString *)orderSign QuerySign:(NSString *)querySign;

/****用户卡信息*****/
- (void)UserCardInfo:(NSString *)cardNumber cardType:(NSString *)cardType bankId:(NSString *)bankId;

/****组装orderSign****/
-(NSString *)GenerateOrderSignSrc;

/****组装cardQuerySign****/
-(NSString *)GenerateCardQuerySign:(NSString *)mebCodeU MerchantId:(NSString *)merchantIdU PartnerUserId:(NSString *)partnerUserIdU;

@end









