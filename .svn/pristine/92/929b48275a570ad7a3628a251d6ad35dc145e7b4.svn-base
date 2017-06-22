//
//  DBManager.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "DBManager.h"
#define debugMethod(...) NSLog((@"In %s,%s [Line %d] "), __PRETTY_FUNCTION__,__FILE__,__LINE__,##__VA_ARGS__)
static DBManager *gl_Database=nil;
@implementation DBManager
@synthesize rememberplanid;
+(DBManager *)sharedDatabase
{
    if (!gl_Database) {
        gl_Database=[[DBManager alloc] init];
    }
    return gl_Database;
}
-(void)createTable
{
    NSArray *tableArray=[NSArray arrayWithObjects:@"CREATE TABLE IF NOT EXISTS users(serial integer  PRIMARY KEY AUTOINCREMENT,name TEXT(1024),realname TEXT(1024),headimage TEXT(1024) DEFAULT NULL,uid TEXT(1024))",@"CREATE TABLE IF NOT EXISTS AreaIDlist(AreaId TEXT,AreaName TEXT)",@"CREATE TABLE IF NOT EXISTS marketlistVersion(updateDate TEXT,version TEXT)",nil];
    
    for (NSString *sql in tableArray) {
        //增加，修改，删除,创建都用这个方法
        if ([mDB executeUpdate:sql]) {
            
        }
        else{
           
        }
    }
}
-(id)init
{
    if (self=[super init]) {
        NSString *path=[DBManager filePath:@"dbuyer.db"];
        mDB=[[FMDatabase databaseWithPath:path] retain];
    }
    return self;
}
-(NSInteger)count
{
    NSString *sql=[NSString stringWithFormat:@"select count(*) from users"];
    FMResultSet *rs=[mDB executeQuery:sql];
    while ([rs next]) {
        return [rs intForColumnIndex:0];
    }
    return 0;
}
+(NSString*)filePath:(NSString *)fileName
{
    //获得当前软件安装目录(沙盒目录)
    NSString *homePath=NSHomeDirectory();
    homePath=[homePath stringByAppendingPathComponent:@"Library/Caches"];
    NSFileManager *fm=[NSFileManager defaultManager];
    //目录存在
    if ([fm fileExistsAtPath:homePath]) {
        //文件名不为空
        if (fileName&& [fileName length]!=0) {
            homePath=[homePath stringByAppendingPathComponent:fileName];
            //return homePath;
            
        }
    }
    else{
    }
    return homePath;
}
-(NSMutableArray *)readThingFromSearchHistory{
    //从搜索历史中取数据
    if([mDB open]){
        
        NSString *sql=@"CREATE TABLE IF NOT EXISTS SEARCHHISTORY(history TEXT)";
        if ([mDB executeUpdate:sql]) {
            
        }
        else{
           
        }
    }
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString * readSql=@"SELECT * FROM SEARCHHISTORY";
    FMResultSet *rs=[mDB executeQuery:readSql];
    while ([rs next]) {
        [array addObject:[rs objectForColumnName:@"history"]];
    }
    return array;
    

}
-(void)insertIntoSearchHistory:(NSString *)history{
    //存到搜索历史中去
    if([mDB open]){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS SEARCHHISTORY(history TEXT)";
        if ([mDB executeUpdate:sql]) {
            
        }
        else{
           
        }
        NSString *string=@"";
        NSString *isExit=[NSString stringWithFormat: @"select * from SEARCHHISTORY where  history = '%@'",history];
        FMResultSet *rs=[mDB executeQuery:isExit];
        while ([rs next]) {
            string=[rs objectForColumnName:@"history"];
        }
        if([string isEqualToString:@""]==YES){
        NSString  *insertSql=@"INSERT INTO SEARCHHISTORY VALUES(?)";
        if([mDB executeUpdate:insertSql,history]){
            
            
        }
        else
        {
           
        }
        }
        [mDB close];
    }
    

}
-(void)deleteAllThingFromSearchHistory{
    if([mDB open]){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS SEARCHHISTORY(history TEXT)";
        if ([mDB executeUpdate:sql]) {
            
        }
        else{
            
        }
        
        NSString  *insertSql=@"DELETE  FROM SEARCHHISTORY ";
        if([mDB executeUpdate:insertSql]){
           
            
        }
        else
        {
                   }
        [mDB close];
    }

}
-(NSMutableArray *)readThingFromCollectlist{
    if([mDB open]){
            
    NSString *sql=@"CREATE TABLE IF NOT EXISTS Collectlist(ID TEXT PRIMARY KEY,IMG TEXT,YUANJIA TEXT,XIANJIA TEXT,BIAOQIAN1 TEXT,BIAOXIAN2 TEXT,BIAOQIAN3 TEXT)";
        if ([mDB executeUpdate:sql]) {
            
        }
        else{
            
        }

    }
    NSMutableArray *array=[[NSMutableArray alloc]init];
  
    NSString * readSql=@"SELECT ID,IMG,YUANJIA,XIANJIA,BIAOQIAN1,BIAOQIAN2,BIAOQIAN3 FROM Collectlist";
    FMResultSet *rs=[mDB executeQuery:readSql];
    while ([rs next]) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:[rs objectForColumnName:@"ID"] forKey:@"ID"];
        [dict setObject:[rs objectForColumnName:@"IMG"] forKey:@"IMG"];
        [dict setObject:[rs objectForColumnName:@"YUANJIA"] forKey:@"YUANJIA"];
        [dict setObject:[rs objectForColumnName:@"XIANJIA"] forKey:@"XIANJIA"];
        [dict setObject:[rs objectForColumnName:@"BIAOQIAN1"] forKey:@"BIAOQIAN1"];
        [dict setObject:[rs objectForColumnName:@"BIAOQIAN2"] forKey:@"BIAOQIAN2"];
        [dict setObject:[rs objectForColumnName:@"BIAOQIAN3"] forKey:@"BIAOQIAN3"];
        [array addObject:dict];

    }
    return array;
    
}
-(int)getAllcountfromShoppinglist
{
    int count = 0;
    if([mDB open]){
        NSString *isExit=[NSString stringWithFormat: @"select * from Carlist"];
        FMResultSet *rs=[mDB executeQuery:isExit];
        while ([rs next])
        {
            count += [[rs objectForColumnName:@"count"] intValue];
        }
        [mDB close];
    }
    return count;
}
#pragma mark - 未登录情况下将商品放到本地数据库中
-(void)insertIntoCarlist:(NSMutableDictionary *)dict{
    if([mDB open]){
        
    NSString *sql=@"CREATE TABLE IF NOT EXISTS Carlist(id TEXT,type TEXT,categoryID TEXT,count TEXT,sellPrice TEXT,attrValue TEXT,commodityName TEXT)";
    [mDB executeUpdate:sql];
   
    NSString *isExit=[NSString stringWithFormat: @"select * from Carlist where id = '%@'",[dict objectForKey:@"id"]];
    FMResultSet *rs=[mDB executeQuery:isExit];
    NSString *panduan=[[NSString alloc]initWithString:@""];
        NSString *countString= [NSString stringWithFormat:@""];
    while ([rs next])
    {
        panduan=[rs objectForColumnName:@"id"];
        countString=[rs objectForColumnName:@"count"];
    }
    if([panduan isEqualToString:@""]==YES){
    //新数据
        NSString  *insertSql=@"INSERT INTO Carlist VALUES(?,?,?,?,?,?,?)";
        if([mDB executeUpdate:insertSql,[dict objectForKey:@"id"],[dict objectForKey:@"type"],[dict objectForKey:@"categoryID"],[dict objectForKey:@"count"],[dict objectForKey:@"sellPrice"],[dict objectForKey:@"attrValue"],[dict objectForKey:@"commodityName"]]){
            
            
        }
        else
        {
            
        }
    }
    else{
    //已经存在
        int countNum = [[dict objectForKey:@"count"]intValue]+[countString intValue];
        NSString *numString = [NSString stringWithFormat:@"%d",countNum];
        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE Carlist SET count = '%@' WHERE id =  '%@'",numString,[dict objectForKey:@"id"]];
        if([mDB executeUpdate:updateSQL]){
        }
        else{
        }
    }
    
    
        [mDB close];
    }
    
}
-(NSString *)batchInsertToNet
{
    NSMutableDictionary *productIdDic = [[NSMutableDictionary alloc] init];
    NSError *error = nil;
    BOOL res=[mDB open];
    if(res==YES)
    {
        NSString * readSql=@"SELECT * FROM Carlist";
        FMResultSet *rs=[mDB executeQuery:readSql];
        while ([rs next])
        {
            NSString *categoryString = nil;
            categoryString = [[rs objectForColumnName:@"type"]intValue]==1?[rs objectForColumnName:@"categoryID"]:@"0";
            NSString *valueString = [NSString stringWithFormat:@"%@,%@,%@",[rs objectForColumnName:@"count"],[rs objectForColumnName:@"type"],categoryString];
            [productIdDic setValue:valueString forKey:[rs objectForColumnName:@"id"]];
        }
    }
    [mDB close];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:productIdDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *proIdsDic = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return proIdsDic;
}
-(NSMutableDictionary *)dictInsertToGoods
{
    //将数据库中数据提交到服务器
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    BOOL res=[mDB open];
    NSString *IdString =[NSString string];
    if(res==YES)
    {
        NSString * readSql=@"SELECT * FROM Carlist";
        FMResultSet *rs=[mDB executeQuery:readSql];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"id"] forKey:@"id"];
            IdString = [rs objectForColumnName:@"id"];
            [dict setValue:[rs objectForColumnName:@"count"] forKey:@"count"];
            [dict setValue:[rs objectForColumnName:@"type"] forKey:@"type"];
            
            if([[rs objectForColumnName:@"type"]intValue]==1)
            {
               [dict setValue:[rs objectForColumnName:@"categoryID"] forKey:@"categoryID"];
            }
            if([IdString length]!=0)
                break;
        }
        NSString *str=[NSString stringWithFormat:@"DELETE  FROM Carlist  WHERE id = '%@'",IdString];
        if([mDB executeUpdate:str]){
            
            
        }
        else
        {
            
        }

    }
    [mDB close];
    return dict;
}
-(void)changeCarlistWith:(NSString *)count AndID:(NSString *)ID
{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS Carlist(id TEXT,type TEXT,categoryID TEXT,count TEXT,sellPrice TEXT,attrValue TEXT,commodityName TEXT)";
        [mDB executeUpdate:sql];
    }
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE Carlist SET count = '%@' WHERE id =  '%@'",count,ID];
    if([mDB executeUpdate:updateSQL]){
    }
    else{
    }
    [mDB close];
}
-(NSMutableArray *)readThingFromCarlist{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS Carlist(id TEXT,type TEXT,categoryID TEXT,count TEXT,sellPrice TEXT,attrValue TEXT,commodityName TEXT)";
        [mDB executeUpdate:sql];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString * readSql=@"SELECT * FROM Carlist ORDER BY categoryID DESC";//购物车数据降序排列
    FMResultSet *rs=[mDB executeQuery:readSql];
    while ([rs next]) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[rs objectForColumnName:@"id"] forKey:@"goodsID"];
        [dict setValue:[rs objectForColumnName:@"attrValue"] forKey:@"attrValue"];
        [dict setValue:[rs objectForColumnName:@"commodityName"] forKey:@"commodityName"];
        [dict setValue:[rs objectForColumnName:@"sellPrice"] forKey:@"sellPrice"];
        [dict setValue:[rs objectForColumnName:@"type"] forKey:@"type"];
        [dict setValue:[rs objectForColumnName:@"categoryID"] forKey:@"categoryID"];
        [dict setValue:[rs objectForColumnName:@"count"] forKey:@"number"];
        [array addObject:dict];
    }
       
    return array;
       
    }
    else{
        return nil;
    }
     [mDB close];
}
#pragma mark - 计划数据写入数据库中
-(void)insertintoShoppinglist:(NSMutableDictionary *)dict{
    if([mDB open]){
        NSString  *insertSql=[NSString stringWithFormat:@"INSERT INTO ShoppingPlan (planid,status,imageid,planname,remindtime,comparetime,urlimage,type,ischanged,cuxCount,groupFlag) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','3','%@','%@')",[dict objectForKey:@"planid"],[dict objectForKey:@"status"],[dict objectForKey:@"imageid"],[dict objectForKey:@"planname"],[dict objectForKey:@"remindtime"],[dict objectForKey:@"comparetime"],[dict objectForKey:@"urlimage"],[dict objectForKey:@"type"],[dict objectForKey:@"cuxCount"],[dict objectForKey:@"groupFlag"]];
        if([mDB executeUpdate:insertSql]){
           
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.method=@selector(downloadComplete1:);
            hd.type=12;
            hd.delegate=self;
            NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
            [dict1 setValue:[dict objectForKey:@"planid"] forKey:@"ID"];
            [dict setValue:@"0" forKey:@"status"];
            [dict1 setValue:[dict objectForKey:@"imageid"] forKey:@"imagId"];
            [dict1 setValue:[dict objectForKey:@"planname"] forKey:@"name"];
            [dict1 setValue:[dict objectForKey:@"remindtime"] forKey:@"remindtime"];
            [dict1 setValue:[dict objectForKey:@"comparetime"] forKey:@"comparetime"];
            [dict1 setValue:[dict objectForKey:@"urlimage"] forKey:@"urlImage"];
            [dict1 setValue:[dict objectForKey:@"type"] forKey:@"type"];
            [dict1 setValue:[dict objectForKey:@"groupFlag"] forKey:@"groupFlag"];
            [dict1 setValue:[dict objectForKey:@"cuxCount"] forKey:@"cuxCount"];
            [hd getResultData:dict1 baseUrl:[NSString stringWithFormat:insertToPlan,serviceHost]];
            
        }
        else
        {
           
        }
        [mDB close];
    }
}
-(BOOL)isExistInShoppinglist:(NSString *)string{
    if([mDB open]){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
            [mDB executeUpdate:sql];
    NSString *isExit=[NSString stringWithFormat: @"select * from ShoppingPlan where planid = '%@'",string];
        
    FMResultSet *rs=[mDB executeQuery:isExit];
    NSString *panduan=[[NSString alloc]initWithString:@""];
    while ([rs next]) {
        panduan=[rs objectForColumnName:@"planid"];
    }
    if([panduan isEqualToString:@""]==YES){
        return NO;
    }
    else{
        return YES;
    }
        [mDB close];
    }
    return NO;
}

-(void)deleteItemFromAreaIDList{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS AreaIDlist(AreaId TEXT,AreaName TEXT)";
        [mDB executeUpdate:sql];
        NSString *str=[NSString stringWithFormat:@"DELETE  FROM ShoppingPlan  WHERE planid =  *"];
        if([mDB executeUpdate:str]){
            
           
        }
        else
        {
            
        }
        
    }
    [mDB close];
}

-(void)insertintoAreaIDlist:(NSMutableDictionary *)dict{
    if([mDB open]){
        
        NSString  *insertSql=[NSString stringWithFormat:@"INSERT INTO AreaIDlist (AreaId,AreaName) VALUES('%@','%@')",[dict objectForKey:@"id"],[dict objectForKey:@"name"]];
        if([mDB executeUpdate:insertSql]){

            
        }
        else
        {
            
        }
        [mDB close];
    }
}

-(NSMutableArray *)readThingFromShoppingplan{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSString * readSql=@"SELECT * FROM ShoppingPlan ORDER BY status ASC,comparetime ASC";
        FMResultSet *rs=[mDB executeQuery:readSql];
        while ([rs next]) {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"planid"] forKey:@"planid"];
            [dict setValue:[rs objectForColumnName:@"status"] forKey:@"status"];
            [dict setValue:[rs objectForColumnName:@"imageid"] forKey:@"imageid"];
            [dict setValue:[rs objectForColumnName:@"planname"] forKey:@"planname"];
            [dict setValue:[rs objectForColumnName:@"remindtime"] forKey:@"remindtime"];
            [dict setValue:[rs objectForColumnName:@"comparetime"] forKey:@"comparetime"];
            [dict setValue:[rs objectForColumnName:@"urlimage"] forKey:@"urlimage"];
            [dict setValue:[rs objectForColumnName:@"type"] forKey:@"type"];
            [dict setValue:[rs objectForColumnName:@"ischanged"] forKey:@"ischanged"];
            [dict setValue:[rs objectForColumnName:@"cuxCount"] forKey:@"cuxCount"];
            [dict setValue:[rs objectForColumnName:@"groupFlag"] forKey:@"groupFlag"];
            [array addObject:dict];
        }
        return array;
    }
    else{
        return nil;
    }
    [mDB close];

}
#pragma mark - 删除购物车数据库中的所有数据
-(void)deleteAllthingInShoppinglist{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *str=@"DROP TABLE Carlist";
        if([mDB executeUpdate:str]){
        }
        else
        {
            
        }

    }
     [mDB close];
}
-(void)deleteDataFromCarlistWithID:(NSString *)ID
{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *str=[NSString stringWithFormat:@"DELETE  FROM Carlist  WHERE id = '%@'",ID];
        if([mDB executeUpdate:str]){
            
            
        }
        else
        {
            
        }
        
    }
    [mDB close];
}
-(void)thingDeletedFromshoppingplanWith:(NSString *)planid{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlanDetele(planid TEXT)";
        [mDB executeUpdate:sql];
        NSString  *insertSql=@"INSERT INTO ShoppingPlanDetele VALUES(?)";
        if([mDB executeUpdate:insertSql,planid]){
            
        }else{
            
        }
    }
    [mDB close];
}
-(void)deleteItemFromShoppingplanWith:(NSString *)planid{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];

            NSString  *insertSql=[NSString stringWithFormat:@"DELETE  FROM ShoppingPlan  WHERE planid =  '%@'",planid];
            if([mDB executeUpdate:insertSql]){
               
            }
    }
    [mDB close];
                HttpDownload *hd=[[HttpDownload alloc]init];
                hd.method=@selector(downloadComplete1:);
                hd.delegate=self;
                hd.type=1;
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                [dict setValue:planid forKey:@"id"];
                [dict setValue:@"-1" forKey:@"status"];
                
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:updatePlan,serviceHost]];
    
}
-(void)changeShopinglist:(NSDictionary *)dict
{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString  *insertSql=[NSString stringWithFormat:@"UPDATE ShoppingPlan SET status = '%@',imageid = '%@',planname =  '%@',remindtime = '%@' ,comparetime = '%@',urlimage = '%@',type = '%@',ischanged = '1',cuxCount = '%@',groupFlag = '%@' WHERE planid =  '%@'",[dict objectForKey:@"status"],[dict objectForKey:@"imageid"],[dict objectForKey:@"planname"],[dict objectForKey:@"remindtime"],[dict objectForKey:@"comparetime"],[dict objectForKey:@"urlimage"],[dict objectForKey:@"type"],[dict objectForKey:@"cuxCount"],[dict objectForKey:@"groupFlag"],[dict objectForKey:@"planid"]];
                if([mDB executeUpdate:insertSql]){
                    HttpDownload *hd=[[HttpDownload alloc]init];
                    hd.method=@selector(downloadComplete1:);
                    hd.delegate=self;
                    hd.type=1;
                    NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
                    [dict1 setValue:[dict objectForKey:@"planid"] forKey:@"id"];
                    [dict1 setValue:@"0"forKey:@"status"];
                    [dict1 setValue:[dict objectForKey:@"imageid"]forKey:@"imagId"];
                    [dict1 setValue:[dict objectForKey:@"planname"]forKey:@"name"];
                    [dict1 setValue:[dict objectForKey:@"remindtime"]forKey:@"remindtime"];
                    [dict1 setValue:[dict objectForKey:@"cuxCount"]forKey:@"cuxCount"];
                    [dict1 setValue:[dict objectForKey:@"groupFlag"]forKey:@"groupFlag"];
                    [dict1 setValue:[dict objectForKey:@"comparetime"]forKey:@"comparetime"];
                    [dict1 setValue:[dict objectForKey:@"urlimage"]forKey:@"urlImage"];
                    [hd getResultData:dict1 baseUrl:[NSString stringWithFormat:updatePlan,serviceHost]];
                }
                else
                {
                
        }
    }
    [mDB close];

}
-(NSMutableArray *)getClockArrayFromShoppinglist{ NSMutableArray *array=[[NSMutableArray alloc]init];
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=@"SELECT * FROM ShoppingPlan";
        FMResultSet *rs=[mDB executeQuery:sql1];
        
       
        while ([rs next]) {
            [array addObject:[rs objectForColumnName:@"comparetime"]];
        }
    [mDB close];
        return array;
}
    return nil;
}
-(void)getListFromNetWithDict:(NSDictionary *)dict WithUsername:(NSString *)userName
{
    BOOL res=[mDB open];
    if(res==YES)
    {
        NSString *str=@"DROP TABLE ShoppingPlan";
        [mDB executeUpdate:str];
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
            [mDB executeUpdate:sql];
        if(![[dict objectForKey:@"msg"]isEqualToString:@"没有响应的数据"])
        {
             NSArray *array= [dict objectForKey:@"Result_list"];
            for(int i=0;i<[array count];i++)
            {
                NSDictionary *dict1=[array objectAtIndex:i];
                NSString  *insertSql=@"INSERT INTO ShoppingPlan (planid,status,imageid,planname,remindtime,comparetime,urlimage,type,ischanged,cuxCount,groupFlag) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
                if([mDB executeUpdate:insertSql,[dict1 objectForKey:@"ID"],[dict1 objectForKey:@"status"],[dict1 objectForKey:@"imagId"],[dict1 objectForKey:@"name"],[dict1 objectForKey:@"remindtime"],[dict1 objectForKey:@"comparetime"],[dict1 objectForKey:@"urlImage"],[dict1 objectForKey:@"type"],@"0",[dict1 objectForKey:@"cuxCount"],[dict1 objectForKey:@"groupFlag"]])
                {
                
                }
                else
                {
                    
                }
            }
        }
    }
    [mDB close];
}
-(int)getNumofnotfinished{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=@"SELECT COUNT(*) FROM ShoppingPlan WHERE status='0'";
        FMResultSet *rs=[mDB executeQuery:sql1];
       
        while ([rs next]) {
            
            
            return [[rs objectForColumnIndex:0] intValue];
        }
        
    }
    [mDB close];

    return 0;
}
-(void)updateShoppinglistToNet{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=@"SELECT * FROM ShoppingPlan WHERE ischanged='1'";
        FMResultSet *rs=[mDB executeQuery:sql1];
       
        while ([rs next]) {
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.method=@selector(downloadComplete:);
            hd.delegate=self;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"planid"] forKey:@"ID"];
            [dict setValue:[rs objectForColumnName:@"status"] forKey:@"status"];
            [dict setValue:[rs objectForColumnName:@"imageid"] forKey:@"imagId"];
            [dict setValue:[rs objectForColumnName:@"planname"] forKey:@"name"];
            [dict setValue:[rs objectForColumnName:@"remindtime"] forKey:@"remindtime"];
            [dict setValue:[rs objectForColumnName:@"comparetime"] forKey:@"comparetime"];
            [dict setValue:[rs objectForColumnName:@"urlimage"] forKey:@"urlImage"];
            [dict setValue:[rs objectForColumnName:@"type"] forKey:@"type"];
            
            [hd getResultData:dict baseUrl:[NSString stringWithFormat:updatePlan,serviceHost]];
            
        }
        NSString *sql2=@"SELECT * FROM ShoppingPlan WHERE ischanged='3'";
        FMResultSet *rs1=[mDB executeQuery:sql2];
        
        while ([rs1 next]) {
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.method=@selector(downloadComplete:);
            hd.delegate=self;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs1 objectForColumnName:@"planid"] forKey:@"ID"];
            [dict setValue:[rs1 objectForColumnName:@"status"] forKey:@"status"];
            [dict setValue:[rs1 objectForColumnName:@"imageid"] forKey:@"imagId"];
            [dict setValue:[rs1 objectForColumnName:@"planname"] forKey:@"name"];
            [dict setValue:[rs1 objectForColumnName:@"remindtime"] forKey:@"remindtime"];
            [dict setValue:[rs1 objectForColumnName:@"comparetime"] forKey:@"comparetime"];
            [dict setValue:[rs1 objectForColumnName:@"urlimage"] forKey:@"urlImage"];
            [dict setValue:[rs1 objectForColumnName:@"type"] forKey:@"type"];
            
            [hd getResultData:dict baseUrl:[NSString stringWithFormat:insertToPlan,serviceHost]];
            
        }

        
    }
    [mDB close];
}
-(void)deleteItemToNet{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlanDetele(planid TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=@"SELECT * FROM ShoppingPlan";
        FMResultSet *rs=[mDB executeQuery:sql1];
        
        while ([rs next]) {
            HttpDownload *hd=[[HttpDownload alloc]init];
            hd.method=@selector(downloadComplete:);
            hd.delegate=self;
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"planid"] forKey:@"ID"];
            [dict setValue:@"-1" forKey:@"status"];
            
            [hd getResultData:dict baseUrl:[NSString stringWithFormat:insertToPlan,serviceHost]];
        }
    }
    [mDB close];
}
-(void)downloadComplete1:(HttpDownload *)hd{
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        if(hd.type==1)
        {
            
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:[dict objectForKey:@"msg"] message:@"YES" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            [al show];
        
        }
        if(hd.type==12){
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:[dict objectForKey:@"msg"] message:@"YES" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//            [al show];
            if([[dict objectForKey:@"status"]integerValue]==0){
                
//                UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"服务器同步成功" message:@"YES" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//                [al show];
                NSString  *insertSql=[NSString stringWithFormat:@"UPDATE ShoppingPlan SET ischanged = '0' WHERE planid =  '%@'",rememberplanid];
                
                if([mDB executeUpdate:insertSql]){
                   
                }
                else
                {
                   
                }

            }
            
        }
    }
}
-(void)saveimageWith:(NSString *)planid AndWithpath:(NSString *)path{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=[NSString stringWithFormat:@"UPDATE ShoppingPlan SET urlimage='%@',type='2' WHERE planid='%@'",path,planid];
       
        if([mDB executeUpdate:sql1])
        {
            
        }
        else{
            
        }
    }
    [mDB close];
    

}
-(void)saveimageWith:(NSString *)planid AndWithimgid:(NSString *)imgid{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS ShoppingPlan(planid TEXT,status TEXT,imageid  TEXT,planname TEXT,remindtime TEXT,comparetime TEXT,urlimage TEXT,type Text,ischanged TEXT,cuxCount TEXT,groupFlag TEXT)";
        [mDB executeUpdate:sql];
        NSString *sql1=[NSString stringWithFormat:@"UPDATE ShoppingPlan SET imageid='%@',type='1' WHERE planid='%@'",imgid,planid];
        if([mDB executeUpdate:sql1])
        {
           
        }
        else{
           
        }
    }
    [mDB close];
}
-(NSString *)selectAreaIdWihtAreaname:(NSString *) name{
    BOOL res=[mDB open];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS AreaIDlist(AreaId TEXT,AreaName TEXT)";
        [mDB executeUpdate:sql];
        //INSERT INTO AreaIDlist (AreaId,AreaName) VALUES('%@','%@')"
        NSString *sql1=[NSString stringWithFormat:@"SELECT AreaId FROM AreaIDlist WHERE AreaName = '%@'",name];
        FMResultSet *rs=[mDB executeQuery:sql1];
        while ([rs next]) {
            return [rs objectForColumnIndex:0];
        }
        
    }
    [mDB close];
    return 0;
}
-(NSMutableArray  *)selectAreaListFromAreaId{
    BOOL res=[mDB open];
    NSMutableArray * areaList = [[NSMutableArray alloc]init];
    if(res==YES){
        NSString *sql=@"CREATE TABLE IF NOT EXISTS AreaIDlist(AreaId TEXT,AreaName TEXT)";
        [mDB executeUpdate:sql];
        //INSERT INTO AreaIDlist (AreaId,AreaName) VALUES('%@','%@')"
        NSString *sql1=@"SELECT * FROM AreaIDlist";
        FMResultSet *rs=[mDB executeQuery:sql1];
       
        
        while ([rs next]) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            [dic setObject:[rs objectForColumnIndex:0] forKey:@"areaId"];
            [dic setObject:[rs objectForColumnIndex:1] forKey:@"areaName"];

            [areaList addObject:dic];
        }
        
    }
    [mDB close];
    return areaList;
}
//@"CREATE TABLE IF NOT EXISTS marketlistVersion(updateDate TEXT,version TEXT)"
-(NSInteger) updateMarketListVersion:(NSInteger) netVersion{
    NSInteger result = 0;// 1代表需要更新 2代表不需要更新
    NSString * selectSql = @"select version from marketlistVersion";
    NSString * localVersion = [[NSString alloc]init];
    BOOL res=[mDB open];
    NSString *sql=@"CREATE TABLE IF NOT EXISTS marketlistVersion(updateDate TEXT,version TEXT)";
    [mDB executeUpdate:sql];
    if (res == YES) {
        FMResultSet *rs=[mDB executeQuery:selectSql];
        while ([rs next]) {
            localVersion = [rs objectForColumnIndex:0];
        }
        NSDate * date = [NSDate date];
        NSString * dateStr = [date description];
        
        if ([localVersion isEqualToString:@""]) {
            NSString *insertSQL =[NSString stringWithFormat:@"insert into marketListVersion(updateDate,version) VALUES('%@','%d')",dateStr,netVersion];
            [mDB executeUpdate:insertSQL];
            result = 1;
            return result;
        }
        if (localVersion.intValue<netVersion) {
            NSString *insertSQL =[NSString stringWithFormat:@"UPDATE marketListVersion SET updateDate = '%@',version= '%d'",dateStr,netVersion];
            [mDB executeUpdate:insertSQL];
            result = 1;
            return result;
        }
    }
    
    [mDB close];
    result = 2;
    return result;
}
-(NSInteger) compareMarketListVersion:(NSInteger) netVersion{
    NSInteger result = 0;// 1代表需要更新 2代表不需要更新
    NSString * selectSql = @"select version from marketlistVersion";
    NSString * localVersion = [[NSString alloc]init];
    BOOL res=[mDB open];
    NSString *sql=@"CREATE TABLE IF NOT EXISTS marketlistVersion(updateDate TEXT,version TEXT)";
    [mDB executeUpdate:sql];
    if (res == YES) {
        FMResultSet *rs=[mDB executeQuery:selectSql];
        while ([rs next]) {
            localVersion = [rs objectForColumnIndex:0];
        }
        
        if ([localVersion isEqualToString:@""]) {
            result = 1;
            return result;
        }
        if (localVersion.intValue<netVersion) {
            result = 1;
            return result;
        }
    }
    
    [mDB close];
    result = 2;
    return result;
}
@end
