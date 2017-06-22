//
//  ProRecommendView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProRecommendDelegate<NSObject>
@optional
-(void)proRecommendDidClick:(NSInteger)index;
@end
@interface ProRecommendView : UIView
@property(nonatomic,assign)id<ProRecommendDelegate>delegate;
- (id)initWithArray:(NSArray *)productArray startPoint:(CGPoint)point;
@end
