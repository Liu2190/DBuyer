//
//  TUtilities.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUtilities.h"
#import "SVProgressHUD.h"


static TUtilities *instance = nil;


@implementation TUtilities


+ (id)getInstance {
    @synchronized(self)	{ // 避免多线程并发创建多个实例
		if (instance == nil) {
            instance = [[TUtilities alloc]init];
        }
	}
    return instance;
}

- (id)init {
    self = [super init];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setLocale: [NSLocale currentLocale]];
    [_dateFormatter setDateFormat:@"yy-MM-dd"];
    
    _longFormatter = [[NSDateFormatter alloc] init];
    [_longFormatter setLocale: [NSLocale currentLocale]];
    [_longFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _dateParserFormatter = [[NSDateFormatter alloc] init];
    [_dateParserFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    _hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [_hzdateParserFormatter setLocale: [NSLocale currentLocale]];
    [_hzdateParserFormatter setDateFormat:@"MM月dd日 HH:mm"];

    
    _allscoStatuDesc = @{@"1001":@"缺少必选的参数",@"1002":@"非法参数",@"1003":@"服务不可用",@"1004":@"服务繁忙",@"1005":@"数据层操作异常",
                           @"1006":@"无此权限",@"1007":@"渠道异常",@"1008":@"超时未处理",@"1009":@"余额不足",@"1010":@"密码错误",
                           @"1011":@"订单不存在",@"1012":@"订单号重复",@"1013":@"账号不存在",@"1014":@"账号状态异常",@"1015":@"账号已存在",
                           @"1016":@"远程调用异常",@"1017":@"超出尝试次数"};
    
    return self;
}

/*
 ****************************************************
 */
- (NSString*) formatDateAsOriginal:(NSDate*)date {
    return [_dateParserFormatter stringFromDate:date];
}

- (NSString*)formatDate:(NSDate *)date {
    return [_dateFormatter stringFromDate: date];
}

- (NSString*)simpleFormatDate:(NSDate *)date {
    if (date) {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setLocale: [NSLocale currentLocale]];
        [formatter setDateFormat:@"YYYY-MM"];
        
        return [formatter stringFromDate: date];
    } else {
        return @"最近";
    }
}

- (NSString*)formatDateFromString:(NSString *)dateStr {
    NSDate *date = [_dateParserFormatter dateFromString:dateStr];
    return [self formatDate:date];
}

- (NSString*) prettyTime:(NSDate *)date {
    return [self prettyTime:date longFormat:NO];
}

- (NSString*) prettyTime:(NSDate *)date longFormat:(BOOL)longFormat {
    NSTimeInterval elapsed = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
    if (elapsed < 60) {
        return @"片刻之前";
    }
    if (elapsed < 60*60) {
        double min = floor(elapsed/60);
        return [NSString stringWithFormat:@"%d分钟前", (int)min];
    }
    if (elapsed < 24*60*60) {
        double hour = floor(elapsed/3600);
        return [NSString stringWithFormat:@"%d小时前", (int)hour];
    }
    if (elapsed < 7*24*60*60) {
        double hour = floor(elapsed/86400);
        return [NSString stringWithFormat:@"%d天前", (int)hour];
    }
    
    return longFormat ? [_longFormatter stringFromDate:date]: [_dateFormatter stringFromDate:date];
}

- (NSString*) prettyTimeFromString:(NSString *)dateStr {
    return [self prettyTimeFromString:dateStr longFormat:NO];
}

- (NSString*) prettyTimeFromString:(NSString *)dateStr longFormat:(BOOL)longFormat {
    NSDate *date = [_dateParserFormatter dateFromString:dateStr];
    return [self prettyTime:date longFormat:longFormat];
}

- (NSDate*) dateParserFromString:(NSString*)dateStr {
    return [_dateParserFormatter dateFromString:dateStr];
}

- (NSDate*) dateLongFromString:(NSString*)dateStr {
    return [_longFormatter dateFromString:dateStr];
}

- (NSDate*) dateSimplyFromString:(NSString*)dateStr {
    return [_dateFormatter dateFromString:dateStr];
}


- (NSString*) stringFromDate:(NSDate*)date {
    return [_dateParserFormatter stringFromDate:date];
}

- (NSString*) stringLongFromDate:(NSDate *)date {
    return [_longFormatter stringFromDate:date];
}

-(NSString*) stringHzFromDate:(NSDate*)date {
    return [_hzdateParserFormatter stringFromDate:date];
}



- (CGSize) scaleImage:(CGSize)imageSize reference:(float)theParm isWidth:(BOOL)isWidth {
    CGSize size;
    int parm = 0;
    
    if (isWidth) {
        parm = theParm*imageSize.height/imageSize.width;
        size = CGSizeMake(theParm, parm);
    } else {
        parm = theParm*imageSize.width/imageSize.height;
        size = CGSizeMake(parm, theParm);
    }
    
    return size;
}

- (void)storeUserInfo:(NSString *)username andPassword:(NSString *)password andUserId:(NSString*)userId{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userid"];
}

- (void)storeUserInfo:(NSString *)username andPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}

- (TDbuyerUser*)getDbuyerUser {
    TDbuyerUser *dbuyerUser = [[TDbuyerUser alloc]init];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    [dbuyerUser setName:phone];
    [dbuyerUser setPassword:password];
    [dbuyerUser setServerId:userid];
    
    return dbuyerUser;
}

- (void)storeValidCode:(NSString *)validCode {
    [[NSUserDefaults standardUserDefaults] setObject:validCode forKey:@"mima"];
}

+ (float)getIosVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

- (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}


- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void) popTarget:(UIView*)view {
    [SVProgressHUD showInView:view];
}

- (void) popTarget:(UIView*)view status:(NSString*)message{
    [SVProgressHUD showInView:view status:message];
}

- (void) popMessage:(NSString*)message target:(UIView*)view {
    [SVProgressHUD showInView:view status:@"" networkIndicator:YES];
    [SVProgressHUD dismissWithSuccess:message afterDelay:2.0];
}

- (void) popMessageError:(NSString*)message target:(UIView*)view delayTime:(float)delayTime{
    [SVProgressHUD showInView:view status:@"" networkIndicator:YES];
    [SVProgressHUD dismissWithError:message afterDelay:delayTime];
}

- (void) popMessage:(NSString*)message target:(UIView*)view delayTime:(float)delayTime {
    [SVProgressHUD showInView:view status:@"" networkIndicator:YES];
    [SVProgressHUD dismissWithSuccess:message afterDelay:delayTime];
}

- (void)setControlAppVar:(BOOL)appVar {
    _appVar = appVar;
}

- (BOOL)controlAppVar {
    return _appVar;
}

- (NSString*)getDescByStatuNum:(NSString *)statusNum {
    
    NSString *desc = [_allscoStatuDesc objectForKey:statusNum];
    return desc;
}

- (NSString*)toConvertStauts:(int)status {
    NSString *showStatusText = @"";
    
    if (status == 0) { //
        showStatusText = @"您的退款已经退还到您的支付银行卡中,请在3-5个工作日后查询";
    }
    
    if (status == 1) { //
        showStatusText = @"您的退款正在处理中";
    }
    
    if (status == 2) { //
        showStatusText = @"您的退款申请已经审核通过";
    }
    
    if (status == 3) { //
        showStatusText = @"您的退款申请正在审核中";
    }
    
    if (status == 4) { //
        showStatusText = @"已收到您的退款申请";
    }
    
    if (status == 5) { //
        showStatusText = @"已收到您的退款申请";
    }
    
    if (status == 6) { //
        showStatusText = @"已收到您的退款申请";
    }
    
    if (status == 7) { //
        showStatusText = @"已收到您的退款申请";
    }
    
    return showStatusText;
}

/*
 ********************************************************
 */
- (CAKeyframeAnimation*) objectMoveFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint duration:(float)durTime{
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:fromPoint];
    [path addLineToPoint:toPoint];
    
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = durTime;
    
    return moveAnimation;
}

@end
