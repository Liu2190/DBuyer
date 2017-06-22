//
//  TUtilities.h
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDbuyerUser.h"

@interface TUtilities : NSObject {
    BOOL _appVar;
    NSDictionary *_allscoStatuDesc;
}

@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDateFormatter *longFormatter;
@property (nonatomic, retain) NSDateFormatter *dateParserFormatter;
@property (nonatomic, retain) NSDateFormatter *hzdateParserFormatter;

+ (id)getInstance;

/**
 * 日期处理
 */
- (NSString*) formatDateAsOriginal:(NSDate*)date;
- (NSString*) formatDate:(NSDate*)date;
- (NSString*) simpleFormatDate:(NSDate *)date;
- (NSString*) formatDateFromString:(NSString *)dateStr;
- (NSString*) prettyTime:(NSDate *)date;
- (NSString*) prettyTimeFromString:(NSString *)dateStr;
- (NSString*) prettyTimeFromString:(NSString *)dateStr longFormat:(BOOL)longFormat;
- (NSDate*) dateParserFromString:(NSString*)dateStr;
- (NSDate*) dateLongFromString:(NSString*)dateStr;
- (NSDate*) dateSimplyFromString:(NSString*)dateStr;
- (NSString*) stringFromDate:(NSDate*)date;
- (NSString*) stringLongFromDate:(NSDate *)date;
- (NSString*) stringHzFromDate:(NSDate*)date;

/**
 * 图片等比例缩放
 */
- (CGSize) scaleImage:(CGSize)imageSize reference:(float)theParm isWidth:(BOOL)isWidth;

/**
 * 存储用户信息到本地
 */
- (void)storeUserInfo:(NSString *)username andPassword:(NSString *)password andUserId:(NSString*)userId;

/**
 * 用户重置密码后做一个用户信息更新
 */
- (void)storeUserInfo:(NSString *)username andPassword:(NSString *)password;

/**
 * 获取本地dbuyer用户对象
 */
- (TDbuyerUser*)getDbuyerUser;

/**
 *  保存验证码
 */
- (void)storeValidCode:(NSString*)validCode;

/**
 * 获取ios固件版本
 */
+ (float)getIosVersion;

/**
 * 获取App版本号
 */
- (NSString *)getAppVersion;

/**
 * app全局变量控制
 */
- (BOOL)controlAppVar;
- (void)setControlAppVar:(BOOL)appVar;


/**
 * 退款进度实体中的status与ui显示之间的映射
 */
- (NSString*)toConvertStauts:(int)status;

/**
 * 加载动画
 */
- (void) dismiss;
- (void) popTarget:(UIView*)view;
- (void) popTarget:(UIView*)view status:(NSString*)message;
- (void) popMessage:(NSString*)message target:(UIView*)view;
- (void) popMessageError:(NSString*)message target:(UIView*)view delayTime:(float)delayTime;
- (void) popMessage:(NSString*)message target:(UIView*)view delayTime:(float)delayTime;


- (NSString*)getDescByStatuNum:(NSString*)statusNum;

- (CAKeyframeAnimation*) objectMoveFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint duration:(float)durTime;

@end
