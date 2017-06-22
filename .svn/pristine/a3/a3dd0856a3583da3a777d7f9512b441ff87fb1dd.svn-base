//
//  TUserCenterServer.h
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterLocalServer.h"
#import "TDbuyerUser.h"
#import "TOrdersNum.h"

@interface TUserCenterServer : TUserCenterLocalServer


/**
 *  获取关于我们
 */
- (void)doGetAbountDataByCallback:(void(^)(NSArray *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 退出登录请求
 */
- (void)doExitLoginByCallback:(void(^)(NSString *ret))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 发送登录请求
 */
- (void)doLoginByUserName:(NSString*)username andPassword:(NSString*)password andCallback:(void(^)(TDbuyerUser *dbuyerUser))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 *  请求验证码
 *  reqflag:支持注册时请求验证码1、找回密码时请求验证码0
 */
- (void)doSendVerifyByUserName:(NSString*)username and:(int)reqflag
                   andCallback:(void(^)(NSString *verifyStr))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 * 发送注册请求
 */
- (void)doRegisterDbuyerByUserName:(NSString*)userName andpassword:(NSString*)password andCode:(NSString*)code
                       andCallback:(void(^)(NSString *verifyStr))callback failureCallback:(void(^)(NSString *resp))failureCallback;

/**
 *  重置密码
 */
- (void)updatePasswordByUserName:(NSString*)userName andpassword:(NSString*)password andCode:(NSString*)code
                     andCallback:(void(^)(NSString *verifyStr))callback failureCallback:(void(^)(NSString *resp))failureCallback;


@end
