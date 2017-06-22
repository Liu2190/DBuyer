//
//  AreaMarket.h
//  DBuyer
//
//  Created by 王帅帅 on 13-11-18.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaMarket : NSObject

@property (nonatomic,retain)NSMutableArray *marketArray;
@property (nonatomic,assign)BOOL ifContainNearMarket;
@property (nonatomic,retain)NSString *areaID;
@property (nonatomic,retain)NSString *areaName;
@property (nonatomic,assign)BOOL isCheckd;
@end
