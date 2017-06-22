//
//  BtnDelegate.h
//  DBuyer
//
//  Created by liuxiaodan on 13-9-18.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BtnDelegate <NSObject>
-(void) pushDetail:(UIButton *)button;
@end
