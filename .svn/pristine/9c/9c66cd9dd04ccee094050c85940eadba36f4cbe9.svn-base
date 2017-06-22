//
//  TBaseLocal.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "TDB.h"
#import "TBaseLocal.h"
#import "TDatabase.h"
#import "TRecordQuery.h"


@implementation TBaseLocal

@synthesize db;

- (id)init{
	if(self = [super init]) {
        db = [[TDB getDataBase]retain];
	}
	
	return self;
}

-(NSString *)SQL:(NSString *)sql inTable:(NSString *)table {
	return [NSString stringWithFormat:sql, table];
}

-(NSMutableDictionary*)resultSet {
    return nil;
}

-(BOOL)insertWithObject:(TRecord*)record {
    return YES;
}

-(BOOL)updateAtIndex:(NSInteger)index record:(TRecord*)record {
    return YES;
}

-(BOOL)deleteAtIndex:(NSInteger)index {
    return YES;
}

-(TRecord *)selectRecordById:(NSInteger)idx {

    return nil;
}

- (void)dealloc {
	[db release];
    db = nil;
	[super dealloc];
}

@end