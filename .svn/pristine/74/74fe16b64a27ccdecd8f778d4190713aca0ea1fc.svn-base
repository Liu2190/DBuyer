//
//  TAllScoChoiceView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Allsco支付表单 选择Allsco虚拟号列表控件
 */
@interface TAllScoChoiceView : UIView {
    
    /**
     * 用来获取AllSco虚拟卡行为按钮
     */
    UIButton *_choiceBtn;
    
    /**
     * 显示虚拟卡和余额的Label
     */
    UILabel *_showAllscoLabel;
    
    /**
     * 需要多少张预付卡来对本次订单支付
     */
    NSMutableArray *_shoiceBlockViews;
}

@property (nonatomic,retain)NSMutableArray *choiceCards;

- (void)setTargetForView:(id)target;

/**
 * 切换虚拟卡选举列表(如果为YES，则是展现;如果为NO，则反之)
 */
- (void)switchAllscoListView:(BOOL)boolValue;

/**
 * 为showAllscoLabel控件设值
 */
- (void)setValueForControl:(NSString*)value;

@end
