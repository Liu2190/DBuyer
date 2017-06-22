//
//  LXD.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-23.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "LXD.h"
@implementation LXD
-(id)initWithText:(NSString *)text font:(NSInteger)labelfont textAlight:(NSInteger)textAlight frame:(CGRect )frame backColor:(UIColor *)backcolor textColor:(UIColor *)color{
    self=[super init];
    if(self){
        self.text=text;
        self.font=[UIFont systemFontOfSize:labelfont];
        self.textAlignment=textAlight;
        self.frame=frame;
        self.backgroundColor=backcolor;
        self.textColor=color;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark 计算Lable的高度（自适应）by LIWEI
+ (CGFloat)calculatorWithWidth:(CGFloat)width font:(UIFont *)font text:(NSString *)text
{
    //    UILabel *lable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 10)] autorelease];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 10)];
    
    lable.text = text;  // 设置文本
    if (font) {        // 如果没有传入font，设置font
        lable.font = font;
    }
    
    lable.numberOfLines = 0;    // 设置换行
    
    [lable sizeToFit];  // 自适应文本
    
    return  lable.bounds.size.height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
