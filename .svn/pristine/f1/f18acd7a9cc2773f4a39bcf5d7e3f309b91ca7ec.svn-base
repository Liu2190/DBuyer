//
//  PlanModal.m
//  DBuyer
//
//  Created by lu gang on 13-11-19.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "PlanModal.h"
#import "DBManager.h"
@implementation PlanModal

- (id)init
{
    self = [super init];
    if (self) {
        _planid = [[NSString alloc]init];
        _status = [[NSString alloc]init];
        _imageid = [[NSString alloc]init];
        _planname = [[NSString alloc]init];
        _remindtime = [[NSString alloc]init];
        _comparetime = [[NSString alloc] init];
        _urlimage = [[NSString alloc]init];
        _type = [[NSString alloc]init];
        _ischanged=[[NSString alloc]init];
        _cuxCount = [[NSString alloc]init];
        _groupFlag = [[NSString alloc]init];
    }
    return self;
}
-(id)initWithDictionaryFromDB:(NSMutableDictionary *)dict{
    [self init];
    self.planid=[dict objectForKey:@"planid"];
    self.status=[dict objectForKey:@"status"];
    self.imageid=[dict objectForKey:@"imageid"];
    self.planname=[dict objectForKey:@"planname"];
    self.remindtime=[dict objectForKey:@"remindtime"];
    self.comparetime=(NSString *)[dict objectForKey:@"comparetime"];
    self.urlimage=[dict objectForKey:@"urlimage"];
    self.type=[dict objectForKey:@"type"];
    self.ischanged=[dict objectForKey:@"ischanged"];
    self.cuxCount = [dict objectForKey:@"cuxCount"];
    self.groupFlag = [dict objectForKey:@"groupFlag"];
    self.isOpen=NO;
    return self;
}
-(void)changeThisPlan
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.status,@"status",self.imageid,@"imageid",self.planname,@"planname",self.remindtime,@"remindtime",self.comparetime,@"comparetime",self.urlimage,@"urlimage",self.type,@"type",self.planid,@"planid",self.cuxCount,@"cuxCount",self.groupFlag,@"groupFlag", nil];
    [DBManager sharedDatabase].rememberplanid=self.planid;
    [[DBManager sharedDatabase]changeShopinglist:dict];
}
-(void)addThisPlan
{
    
}
-(void)deleteThisPlan
{
    
}
@end
