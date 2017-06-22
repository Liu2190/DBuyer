//
//  DbuyerActive.h
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

typedef enum {
    Active_Postion_Default, // 枚举Active位置
    Active_Postion_Left,
    Active_Postion_Right,
    Active_Postion_Top,
    Active_Postion_Bootom,
    
} ActivePostinType;

#import <UIKit/UIKit.h>
#import "TActivityIndicatorView.h"

@interface DbuyerActive : UIViewController

/**
 * 目标视图的具体位置,把加载器放在控制视图哪儿交由枚举值来决定
 */
@property (nonatomic,assign) CGPoint postion;

/**
 * 封装系统级加载器视图,便于以后定置扩展
 */
@property (nonatomic,retain) TActivityIndicatorView *actionView;





+ (id)getInstance;



@end
