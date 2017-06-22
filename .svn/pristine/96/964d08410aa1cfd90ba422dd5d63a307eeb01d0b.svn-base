//
//  NSDictionary+Json.m
//  XHDaoGouIOS
//
//  Created by dilei liu on 13-1-29.
//  Copyright (c) 2013年 tutebang. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

- (NSString*) _objectForKey:(NSString*)key {
    
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"(null)"]) {
            return nil;
        }
    }

    return value;
}

@end
