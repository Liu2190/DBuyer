//
//  TAllscoPayViewController.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TAllscoPayDelgate.h"
#import "TItemAllscoPayController.h"
#import "TConfirmPay.h"
#import "TAllScoValidataView.h"


@interface TAllscoPayViewController : TRootViewController<UIScrollViewDelegate> {
    UIScrollView *_mainScrollView;
    TItemAllscoPayController *_itemPayController;
    
    /**
     * 验证码
     */
    TAllScoValidataView *_validataView;
    UIButton *_tradeBtn;
    
    
    BOOL keyboardShown;
    BOOL viewMoved;
}

- (id)initWithNavigationTitle:(NSString *)title andDatas:(NSArray*)datas;

@property (nonatomic,assign)id<TAllscoPayDelgate> allscoPayDelegate;
@property (nonatomic,retain) TConfirmPay *confirmPay;
@property (nonatomic,retain) NSMutableArray *allscoList;


@end
