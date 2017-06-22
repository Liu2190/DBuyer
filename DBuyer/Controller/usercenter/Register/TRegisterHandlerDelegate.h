//
//  TRegisterHandlerDelegate.h
//  DBuyer
//
//  Created by dilei liu on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDbuyerUser.h"

@protocol TRegisterHandlerDelegate <NSObject>

/**
 * 注册成功
 */
- (void)registerSuccess:(TDbuyerUser*)dbuyerUser;

@end
