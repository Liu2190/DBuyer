//
//  PublicClass.h
//  DBuyer
//
//  Created by lu gang on 13-11-21.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadView.h"
#import "AppDelegate.h"

@interface PublicClass : NSObject

@end

@interface UIViewController (CategoryCon)
-(void)customSet;
-(void)addTopBarWithTitle:(NSString *)title andBack:(BOOL)haveBack andExtend:(BOOL)hanveExtend;
-(void)addLoadView;
-(AppDelegate *)mainDelegate;
-(BOOL)IsEmptyOfString:(NSString *)string;
-(BOOL)IsEmptyOfPrice:(NSString *)string;
-(NSString *)generateUuidString;
-(NSString *)generateRemindTime;
-(NSString *)generateCompareTime;
-(void)showError:(NSString *)errInfo;
-(void)isLogined;
-(BOOL)isAlreadyLogined; // 判断是否已登录，返回判断结果
-(void)showNotLoginAlertView; // 显示用户为登录弹框
-(void)getShoppingCarNumFromNet;
-(void)setNavigationBarWithContent:(NSString *)content WithLeftButton:(UIImage *)leftImage AndRightButton:(UIImage *)rightImage;
-(void)setNavigationBarWithContent:(NSString *)content WithLeftButton:(UIImage *)leftImage AndRightButton:(UIImage *)rightImage AndCenterButton:(UIImage *)centerImage;
@end

@interface NSString (IsEmptyJudgment)
-(BOOL)IsEmptyOfString:(NSString *)string;

@end

@interface UIButton (UIButtonCategory)

-(void)setImage:(NSString *)imageName;

@end



