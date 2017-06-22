//
//  PlanModal.h
//  DBuyer
//
//  Created by lu gang on 13-11-19.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PlanModal : NSObject

@property(strong, nonatomic)NSString *planid;
@property(strong, nonatomic)NSString *status;
@property(strong, nonatomic)NSString *imageid;
@property(strong, nonatomic)NSString *planname;
@property(strong, nonatomic)NSString *remindtime;
@property(strong, nonatomic)NSString *comparetime;
@property(strong, nonatomic)NSString *urlimage;
@property(strong, nonatomic)NSString *type;
@property(strong, nonatomic)NSString *ischanged;
@property(nonatomic ,assign)BOOL isOpen;
@property (nonatomic,retain)NSString *cuxCount;//每条计划对应的促销商品的数量
@property (nonatomic,retain)NSString *groupFlag;//搜索促销商品所需要的关键词
-(id)initWithDictionaryFromDB:(NSMutableDictionary *)dict;
-(void)changeThisPlan;//修改当前的计划
-(void)addThisPlan;//增加计划；
-(void)deleteThisPlan;//删除计划；

@end
