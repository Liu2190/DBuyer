//
//  TRecord.h
//  XHDaoGouIOS
//
//  Created by dilei liu on 13-1-17.
//  Copyright (c) 2013年 tutebang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Json.h"

@interface TRecord : NSObject

@property (nonatomic,assign) NSString *recordId;            // 本地id
@property (nonatomic,assign) NSString *serverId;            // 服务器id
@property (nonatomic,retain) NSString *creater;       // 创建人
@property (nonatomic,retain) NSString *createTime;    // 创建时间
@property (nonatomic,retain) NSString *synUpTime;     // 上传时间

- (id)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;

@end
