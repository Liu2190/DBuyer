//
//  TAllScoBindingController.h
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TDbuyerFieldController.h"
#import "TAllScoBindingView.h"

/**
 * Allsco虚拟卡绑定控制器
 */
@interface TAllScoBindingController : TRootViewController<UIScrollViewDelegate,UITextFieldDelegate> {
    TAllScoBindingView *_contentBlockView;
    UIScrollView *_mainScrollView;
    
    BOOL keyboardShown;
    BOOL viewMoved;
}

@end
