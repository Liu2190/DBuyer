//
//  TServerFactory.h
//  Tutebang
//
//  Created by dilei liu on 12-12-24.
//  Copyright (c) 2012年 柳 刚强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TServerFactory : NSObject {
    NSMutableDictionary *_serverDicts;
}

+ (id)getServerInstance:(NSString*)serverName;

@end
