//
//  TPasswordMenuView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPasswordMenuView : UIView {
    UIImageView *arrowImageView_0;
    UIImageView *arrowImageView_1;
}


/**
 *  通过index索引号跳转到指定的页
 */
- (void) goPageByindex:(int)index;

@end
