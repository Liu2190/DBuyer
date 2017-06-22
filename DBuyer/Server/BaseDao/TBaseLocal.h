//
//  TBaseLocal.h
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRecord.h"
#import "RequestDelegate.h"

@class TDatabase;

@interface TBaseLocal : NSObject {
	TDatabase *db;
}


@property (nonatomic, retain) TDatabase *db;

-(NSMutableDictionary*)resultSet;
-(BOOL)insertWithObject:(TRecord*)record;
-(BOOL)updateAtIndex:(NSInteger)index record:(TRecord*)record;
-(BOOL)deleteAtIndex:(NSInteger)index;
-(TRecord*)selectRecordById:(NSInteger)idx;

-(NSString *)SQL:(NSString *)sql inTable:(NSString *)table;

@end