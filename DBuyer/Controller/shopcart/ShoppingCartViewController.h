//
//  ShoppingCartViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLoginHandlerDelegate.h"

@interface ShoppingCartViewController : UIViewController<TLoginHandlerDelegate>
@property (nonatomic,assign)BOOL isFromHome;
@end
