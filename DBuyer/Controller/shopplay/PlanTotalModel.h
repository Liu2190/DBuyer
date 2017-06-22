//
//  PlanTotalModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlanModal.h"
@interface PlanTotalModel : NSObject
@property(nonatomic,retain)NSMutableArray *planArray;
@property(nonatomic,retain)NSMutableArray *titleArray;
@property(nonatomic,retain)NSMutableArray *imageIconArray;
@property(nonatomic,retain)NSMutableString *pickRemindTime;
@property(nonatomic,retain)NSMutableString *pickTimeStamp;
@property(nonatomic,assign)NSInteger thisSection;
-(id)initFromDB;
-(void)updateLocalNotification;//更新推送信息；
-(void)addPlanWith:(PlanModal *)plan;//增加一条计划信息；
-(void)updatePlanWith:(PlanModal *)plan;//修改一条计划信息；
-(void)deletePlanWith:(PlanModal *)plan;//删除一条计划信息

@end
