//
//  SqliteMarketObject.h
//  DBuyer
//
//  Created by 王帅帅 on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SqliteMarketObjectProtocol <NSObject>
- (NSString *)insertSQL;
@end


@interface SqliteMarketObject : NSObject<SqliteMarketObjectProtocol>

@property (nonatomic,retain)NSString *inAreaName;//所在在地区的Name
@property (nonatomic,retain)NSString *inAreaId;//所在地区的id
@property (nonatomic,retain)NSString *marketName;//超市名称
@property (nonatomic,retain)NSString *marketId;//超市id
@property (nonatomic,assign) double latitude;//超市纬度
@property (nonatomic,assign) double longtitude;//超市经度
@property (nonatomic,retain) NSString *marketAddress;//超市地址
@property (nonatomic,assign) BOOL storeSort;//超市类型

@end
