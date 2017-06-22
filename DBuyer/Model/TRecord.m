//
//  TRecord.m
//  XHDaoGouIOS
//
//  Created by dilei liu on 13-1-17.
//  Copyright (c) 2013年 tutebang. All rights reserved.
//

#import "TRecord.h"

@implementation TRecord

- (id)init {
    self = [super init];
    
    return self;
}

- (id)initWithJsonDictionary:(NSDictionary*)dic {
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    
}

- (void)dealloc {

    [_creater release];
    _creater = nil;
    
    [_createTime release];
    _createTime = nil;
    
    [_synUpTime release];
    _synUpTime = nil;
    
    [_serverId release];
    _serverId = nil;
    
    [super dealloc];
}

@end
