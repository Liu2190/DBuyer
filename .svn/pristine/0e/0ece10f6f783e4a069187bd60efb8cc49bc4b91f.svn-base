//
//  PlanTotalModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanTotalModel.h"
#import "DBManager.h"
@implementation PlanTotalModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _planArray = [[NSMutableArray alloc]init];
        _titleArray = [[NSMutableArray alloc]init];
        _imageIconArray = [[NSMutableArray alloc]init];
        _pickRemindTime = [[NSMutableString alloc]init];
        _pickTimeStamp = [[NSMutableString alloc]init];
        _thisSection = 0;
        
    }
    return self;
}
-(id)initFromDB
{
    [self init];
    [self.planArray removeAllObjects];
    NSMutableArray *arrayFromDB=[[DBManager sharedDatabase]readThingFromShoppingplan];
    for(NSMutableDictionary *dict in arrayFromDB)
    {
        PlanModal *plan=[[PlanModal alloc]initWithDictionaryFromDB:dict];
        [self.planArray addObject:plan];
    }
    return self;
}
-(void)updateLocalNotification
{
    UIApplication *app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    NSMutableArray *arrayClock=[[NSMutableArray alloc]init];
    [arrayClock addObjectsFromArray:[DBManager sharedDatabase].getClockArrayFromShoppinglist];
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    int numberOfNotification = 0 ;
    if (notification != nil)
    {
        for(int i=0;i<[arrayClock count];i++)
        {
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            if([arrayClock objectAtIndex:i]> timeSp )
            {
                NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
                NSDate *date2=[[NSDate alloc] initWithTimeIntervalSince1970:[[arrayClock objectAtIndex:i] integerValue]];
                notification.fireDate=date2;
                // 设置时区
                notification.timeZone = timeZone;
                // 设置重复间隔
                notification.repeatInterval = 0;
                // 推送声音
                notification.soundName = UILocalNotificationDefaultSoundName;
                // 推送内容
                notification.alertBody = @"购物计划提醒";
                //显示在icon上的红色圈中的数子
                numberOfNotification ++;
                notification.applicationIconBadgeNumber=1;
                notification.alertAction = @"打开";
                UIApplication *app = [UIApplication sharedApplication];
                [app scheduleLocalNotification:notification];
            }
        }
    }
    notification=nil;
}
-(void)addPlanWith:(PlanModal *)plan
{
    
}
-(void)updatePlanWith:(PlanModal *)plan
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:plan.status,@"status",plan.imageid,@"imageid",plan.planname,@"planname",plan.remindtime,@"remindtime",plan.comparetime,@"comparetime",plan.urlimage,@"urlimage",plan.type,@"type",plan.planid,@"planid",plan.cuxCount,@"cuxCount",plan.groupFlag,@"groupFlag",nil];
    [DBManager sharedDatabase].rememberplanid=plan.planid;
    [[DBManager sharedDatabase]changeShopinglist:dict];
}
-(void)deletePlanWith:(PlanModal *)plan
{
    [DBManager sharedDatabase].rememberplanid=plan.planid;
    [[DBManager sharedDatabase] deleteItemFromShoppingplanWith:plan.planid];
}
@end
