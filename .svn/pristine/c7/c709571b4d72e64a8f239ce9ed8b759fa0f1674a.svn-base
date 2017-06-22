//
//  Database.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "TDB.h"

#define DB_NAME @"TDaoGouDB.sqlite"


static TDatabase *exsitDB = nil;

@implementation TDB


- (BOOL)initDatabase
{
	BOOL success;
    NSError *error;
	
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];

    NSFileManager *fm = [NSFileManager defaultManager];
	success = [fm fileExistsAtPath:writableDBPath];
	
	if(!success){ // 从工程目录拷贝文件到应用程序沙盒中

        NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DB_NAME];
		success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        NSLog(@"the path of local db file is: %@",defaultDBPath);
        
		if(!success){
			NSLog(@"error: %@", [error localizedDescription]);
		}
        
		success = YES;
	}
	
	if(success){ // 如果存在
		exsitDB = [TDatabase databaseWithPath:writableDBPath];
		if ([exsitDB open]) {
			[exsitDB setShouldCacheStatements:YES];
		}else{
			NSLog(@"Failed to open database.");
			success = NO;
		}
	}
	
	return success;
}


- (void)closeDatabase {
	[exsitDB close];
}


- (TDatabase *)getDatabase
{
	if ([self initDatabase]){
		return exsitDB;
	}
	
	return NULL;
}

+ (TDatabase*)getDataBase {
    @synchronized(self)	{ // 避免多线程并发创建多个实例
		if (exsitDB) {
            return exsitDB;
        }
        [[TDB alloc]initDatabase];
	}
    
    return exsitDB;
}

- (void)dealloc
{
	[self closeDatabase];
	
	[db release];
    db = nil;
    
	[super dealloc];
}

@end
