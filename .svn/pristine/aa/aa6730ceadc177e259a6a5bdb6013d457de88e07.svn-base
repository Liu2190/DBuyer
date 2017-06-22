//
//  TUserCenterController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TParallaxTableController.h"
#import "TOrderMenuView.h"
#import "TUserCenterDelegate.h"
#import "TOrderMenuDelegate.h"
#import "TUserFaceController.h"
#import "TLoginHandlerDelegate.h"

@interface TUserCenterController : TParallaxTableController <UIAlertViewDelegate,TUserCenterDelegate,TOrderMenuDelegate,TLoginHandlerDelegate>{
    TOrderMenuView *_menuView;
    TUserFaceController *_userFaceController;
    
    int integralNum;
}


- (id)initWithImageUrls:(NSArray *)imageUrls andNavigationTitle:(NSString*)title;
@end
