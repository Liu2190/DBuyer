//
//  LXD.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-23.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXD : UILabel
-(id)initWithText:(NSString *)text font:(NSInteger)labelfont textAlight:(NSInteger) textAlight frame:(CGRect )frame backColor:(UIColor *)backcolor textColor:(UIColor *)color;
+ (CGFloat)calculatorWithWidth:(CGFloat)width font:(UIFont *)font text:(NSString *)text;
@end
