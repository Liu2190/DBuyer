//
//  BargainViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPullUPRefreshController.h"
/**
 * 数据排序规则
 */
typedef enum {
    TeseGoods,           //特色排序
    MeiyueXinpinGoods,   //每月新品
    TejiaGoods,          //特价排序
    PaihangGoods,        //销量排行排序
    YingjiGoods,         //应季排序
} Sourcetype;

@interface BargainViewController : TPullUPRefreshController
@property (nonatomic,assign)Sourcetype type;
@property (nonatomic,retain)NSString *parentId;
@property (nonatomic,retain)NSString *titleName;
@end
