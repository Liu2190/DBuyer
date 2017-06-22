//
//  GuideOperationView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol guideOperationDelegate
@optional
-(void)guideOperationDidClick;
@end
@interface GuideOperationView : UIView
@property (nonatomic,assign)id delegate;
-(id)initGuideOperationViewWith:(NSMutableArray *)imageArray;
@end
