//
//  TContextSetting.h
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IsIOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 7
#define isIphone5 fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON;
