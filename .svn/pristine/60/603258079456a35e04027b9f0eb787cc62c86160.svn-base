//
//  UIDevice+Resolutions.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-24.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{ 
    //iPhone 1、3G、3GS，iPod Touch 1、2、3  标准分辨率(320x480px)普通屏
    UIDevice_iPhoneStandardRes   = 1,
    //iPhone 4、4S，iPod Touch 4          高清分辨率(640x960px)3：2 Retina 屏
    UIDevice_iPhoneHiRes         = 2,
    //iPhone 5，iPod Touch 5,iPhone 5s,iPhone5c  高清分辨率(640x1136px)16：9 Retina 屏
    UIDevice_iPhoneTallerHiRes   = 3,
    //iPad 1， iPad2，iPad mini          标准分辨率(1024x768px)普通屏
    UIDevice_iPadStandardRes     = 4,
    //New iPad，iPad 4                  2048x1536px  Retina屏
    UIDevice_iPadHiRes           = 5
};typedef NSUInteger UIDeviceResolution;


@interface UIDevice (Resolutions)
/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution;
/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5;
/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone;
@end
