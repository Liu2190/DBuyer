//
//  ChooseSupermarketViewController.m
//  DBuyer
//  选择超市
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ChooseSupermarketViewController.h"
#import "BtnDelegate.h"
#import "Xuanzechaoshi.h"
#import "PatternOfPaymenViewController.h"
#import "AreaMarket.h"
#import "SqliteAreaObject.h"
#import "SqliteMarketObject.h"
#import "SqliteManager.h"
#import "DBManager.h"

@interface ChooseSupermarketViewController ()
- (void)_createAreaSqliteTable;
- (void)_createMarketSqliteTable;
- (void)_addAreaToSqlite:(NSArray *)array;
- (void)_addMarketToSqlite:(NSArray *)array;
//将最新的版本号存储到本地
- (void)_saveVersionNumberToLocal:(NSString *)version;
//将本地版本号获取到
- (NSString *)_getLocalVersionNumber;
@end

@implementation ChooseSupermarketViewController
{
    NSInteger numberOfCellClick;//把点击一级cell的时候记录是第几个
    CLLocationManager *locationManager;
    double latitude;
    double longitude;
    NSMutableArray *areaAllCell;//地区里所有的cell
    NSMutableArray *marketArray;
    
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    LoadView * loadView;
}

- (void)_saveVersionNumberToLocal:(NSString *)version {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _market = [[SqliteMarketObject alloc]init];
        marketArray =[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKCOLOR;
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    [mainDelegate beginLoad];
    [self _createMarketSqliteTable];
    // Do any additional setup after loading the view from its nib.
    self.needShowAreaArray=[[NSMutableArray alloc]init];
    self.needShowMarketArray = [[NSMutableArray alloc] init];
    areaAllCell = [[NSMutableArray alloc] init];
    self.view.backgroundColor=BACKCOLOR;
    self.delegate=self;
    [_btn1 setImage:[UIImage imageNamed:@"切片绿_向左"] forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"切片绿_向左1"] forState:UIControlStateHighlighted];
    
    [_fenxiang setImage:[UIImage imageNamed:@"分享1"] forState:UIControlStateNormal];
    [_fenxiang setImage:[UIImage imageNamed:@"分享2"] forState:UIControlStateHighlighted];
    _label1.textColor=TITLECOLOR;
    _shengbianhualian.textColor=[UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1];
    
    
    _userTable.frame=CGRectMake(0, 44, 100,  (self.view.bounds.size.height-44));
    _userTable.delegate=self;
    _userTable.dataSource=self;
    _contentTable.frame=CGRectMake(100, 44, 220, (self.view.bounds.size.height-44));
    _contentTable.delegate=self;
    _contentTable.dataSource=self;
    _contentTable.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
    
   //获取版本号
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [dict setObject:@"7" forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryVersionInfoForFL,serviceHost]];
    hd.type = 11188;
    hd.method=@selector(downloadComplete:);
//    
//    
//    [self getNearShop];
    
}
#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    [mainDelegate endLoad];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    switch (hd.type) {
        case 11188://获取版本号完成
        {
            
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0){
                NSString *newVersionNumber = [dict objectForKey:@"version"];//????????????key不知道
                //判断版本号是不是一样
                NSInteger versionResult = [[DBManager sharedDatabase] updateMarketListVersion:newVersionNumber.intValue];
                //versionResult == 1 1代表需要更新 2代表不需要更新
                if (versionResult == 1) {
                    //如果版本号不一样
                    //从服务器上获取城区列表，并存到数据库中
                    [self _accessAreasFromService];//从服务器上获取区域列表
                    [self _accessMarketListFromService];
                }
                else
                {
                    //如果版本号一样，从数据库中找出区域列表
                    //
//                    [self _dropAreaTable:@"SqliteAreaObject"];//？？？？把表格删除
                    [self.needShowAreaArray addObjectsFromArray:[self _accessAreaListFromSqlite]];
                    [marketArray addObjectsFromArray:[self selectMarketListWithMarketType:self.marketType]];
                    //对刚进入的table进行处理
                    [self initTableArray:self.market];
                    if (self.needShowMarketArray.count == 0) {
                        [self getNearShop];
                    }
                    [_userTable reloadData];
                    [_contentTable reloadData];
                    _userTable.contentSize = CGSizeMake(_userTable.contentSize.width, _userTable.contentSize.height+50);//下边有点挡，所有加50
                }
            }
            
            
            break;
        }
        case 11189://获取地区列表完成
        {
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0){
                NSArray *array = [dict objectForKey:@"resultList"];
                [self _addAreaToSqlite:array];//将获取到得区域列表添加到数据库中
                //将获取到的城区列表显示出来
                [self.needShowAreaArray addObjectsFromArray:array];
                [_userTable reloadData];
            
            }
            
            
            break;
        }
        case 11190://从服务器上下载超市完成
        {
            NSArray *array = [dict objectForKey:@"storeList"];//正数据
            
            [self _addMarketToSqlite:array];
            [marketArray  addObjectsFromArray:[self selectMarketListWithMarketType:self.marketType]];
            [self initTableArray:self.market];
            [_contentTable reloadData];
            break;
        }
//        case 11191://身边华联
//        {
//            NSString *storeId = [dict objectForKey:@"storeId"];
//            SqliteMarketObject *market = [[SqliteMarketObject alloc] init];
//            //找到对应的market
//           NSArray *arrayTemp = [[SqliteManager singleton] _findAllMarketFromTable:@"SqliteMarketObject"];
//            for (SqliteMarketObject *item in arrayTemp) {
//                if ([item.marketId isEqualToString:storeId]) {
//                     market = item;//将获取到的market赋给market
//                    break;
//                }
//            }
//            NSLog(@"%@",market.marketId);
//            
//            
//            //把地区列表种包含market的cell标记出来
//            for (UITableViewCell *item in areaAllCell) {
//                if ([item.textLabel.text isEqualToString:market.inAreaName]) {
//                    UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_70"]];
//                    ima.frame=CGRectMake(0, 0, 100, 60);
//                    item.backgroundView=ima;
//                    item.textLabel.textColor=[UIColor whiteColor];
//                }
//            }
//            
//            //把market的cell移动到第一位
//            [self.needShowMarketArray removeAllObjects];
//            [self.needShowMarketArray addObjectsFromArray:[[SqliteManager singleton] itemListFromTable:@"SqliteMarketObject" andInAreaName:market.inAreaName]];
//            _contentTable.contentSize = CGSizeMake(_contentTable.contentSize.width, _contentTable.contentSize.height+50);
//            
//            [self.needShowMarketArray replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] withObjects:@[market]];
//            [_contentTable reloadData];
//            break;
//        }
        default:
            break;
    }
    
}

#pragma mark - Private methods
-(void) initTableArray:(SqliteMarketObject *) market{
    //先找到传入超市所在的区域,找到后将该超市的信息存到market中，补全信息
    for (SqliteMarketObject * item in marketArray) {
        if ([item.marketName isEqualToString:self.market.marketName]) {
            self.market = item;
        }
    }
    //找到所选超市所在区域的所有超市
    [self.needShowMarketArray removeAllObjects];
    for (SqliteMarketObject * item in marketArray) {
        if ([item.inAreaName isEqualToString:self.market.inAreaName]) {
            [self.needShowMarketArray addObject:item];
        }
    }
}
-(NSMutableArray *) selectMarketListWithMarketType:(NSInteger)marketType{
    //查询数据库中对应超市类型的超市列表
    NSArray * array =[[SqliteManager singleton] _findAllMarketFromTable:@"SqliteMarketObject"];
    
    NSMutableArray * mutArray = [[NSMutableArray alloc]init];
    for (SqliteMarketObject * item  in array) {
        if (item.storeSort == marketType) {
            [mutArray addObject:item];
        }
    }
    return mutArray;
}
- (NSString *)_getLocalVersionNumber
{
    //将本地版本号获取到
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"marketVersionNumber"];
}
- (void)_accessAreasFromService
{
    //从服务器上获取地区列表
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:@"%@interface/store/queryCitys",serviceHost]];
    hd.type = 11189;
    hd.method=@selector(downloadComplete:);
    [self toExtend];
}

- (void)_accessMarketListFromService{
    //从服务器上获取超市列表
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:@"%@interface/store/queryStoreByStoreSort",serviceHost]];
    hd.type = 11190;
    hd.method=@selector(downloadComplete:);
}
//- (void)_accessAreasFromServiceWithInAreaId:(NSString *)inAreaId
//{
//    HttpDownload *hd=[[HttpDownload alloc]init];
//    hd.delegate=self;
//    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",inAreaId,@"cityId",nil];//用3104来测试
//    [hd getResultData:dict baseUrl:[NSString stringWithFormat:@"%@interface/store/queryStoreByCityId",serviceHost]];
//    hd.type = 11190;
//    hd.method=@selector(downloadComplete:);
//}
-(CLLocationDistance) getDistenceFromLocal:(SqliteMarketObject *)item{
    //当前坐标
    CLLocation *current=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    //超市坐标
    CLLocation *before=[[CLLocation alloc] initWithLatitude:item.latitude longitude:item.longtitude];
    // 计算距离
    CLLocationDistance meters=[current distanceFromLocation:before];
    return meters;
}
-(void) getNearShop{
    //查找最近的超市
    SqliteMarketObject *market = [[SqliteMarketObject alloc] init];
    CLLocationDistance minDistance = 999999999;
    if (marketArray.count>0) {
        for (NSInteger index = 0; index<marketArray.count; index++) {
            CLLocationDistance meters=[self getDistenceFromLocal:marketArray[index]];
            if (minDistance>meters) {
                market = marketArray[index];
                minDistance = meters;
            }
        }
        //把地区列表种包含market的cell标记出来
        for (UITableViewCell *item in areaAllCell) {
            if ([item.textLabel.text isEqualToString:market.inAreaName]) {
                UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_70"]];
                ima.frame=CGRectMake(0, 0, 100, 60);
                item.backgroundView=ima;
                item.textLabel.textColor=[UIColor whiteColor];
            }
        }
        self.market = market;
        [self initTableArray:market];
        //把market的cell移动到第一位
//        [self.needShowMarketArray removeAllObjects];
//        [self.needShowMarketArray addObjectsFromArray:[[SqliteManager singleton] itemListFromTable:@"SqliteMarketObject" andInAreaName:market.inAreaName]];
        _contentTable.contentSize = CGSizeMake(_contentTable.contentSize.width, _contentTable.contentSize.height+50);
        
//        [self.needShowMarketArray replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:0] withObjects:@[market]];
        [_contentTable reloadData];
    }
    
//    NSLog(@"%@,,%@,%@",market.marketId,market.marketName,market.marketAddress);
    
    
    

    //取得超市坐在区域
    
    
//    for (Xuanzechaoshi * item in self.needShowMarketArray) {
//        //超市坐标
//        CLLocation *before=[[CLLocation alloc] initWithLatitude:item.latitude longitude:item.longtitude];
//        // 计算距离
////        CLLocationDistance meters=[current distanceFromLocation:before];
////        NSLog(@"%@,%f",item.marketName ,meters);
//    }
//    return nil;
}

- (void)_accessNearMarketFromService {
    //从服务器上获取身边华联超市
    NSString *latitudeString = [NSString stringWithFormat:@"%f",latitude];
    NSString *longtitudeString = [NSString stringWithFormat:@"%f",longitude];

    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",latitudeString,@"XAxis",longtitudeString,@"YAxis", nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:@"%@interface/store/queryNearStore",serviceHost]];
    hd.type = 11191;
    hd.method=@selector(downloadComplete:);
}
//从数据库中获取地区列表
- (NSArray *)_accessAreaListFromSqlite
{
   return [[SqliteManager singleton] itemListFromTable:@"SqliteAreaObject"];
}
//从数数据库中获取超市列表
- (NSArray *)_accessMarketListFromSqliteWithAreaName:(NSString *)inAreaName
{
   return [[SqliteManager singleton] itemListFromTable:@"SqliteMarketObject" andInAreaName:inAreaName];
}
//从数数据库中获取超市列表
- (NSArray *)_accessMarketListFromSqliteWithAreaName:(NSString *)inAreaName withType:(NSInteger)marketType
{
    return [[SqliteManager singleton] itemListFromTable:@"SqliteMarketObject" andInAreaName:inAreaName andType:marketType];
}

//创建地区数据库表格
- (void)_createAreaSqliteTable
{
    
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    [attribute setObject:@"text" forKey:@"areaName"];
    [attribute setObject:@"text" forKey:@"areaId"];
    [[SqliteManager singleton] createTable:@"SqliteAreaObject" attribute:attribute];
}
//创建超市数据库表格
- (void)_createMarketSqliteTable
{
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    [attribute setObject:@"text" forKey:@"inAreaName"];
    [attribute setObject:@"text" forKey:@"inAreaId"];
    [attribute setObject:@"text" forKey:@"marketName"];
    [attribute setObject:@"text" forKey:@"marketId"];
    [attribute setObject:@"text" forKey:@"marketAddress"];
    [attribute setObject:@"double" forKey:@"latitude"];
    [attribute setObject:@"double" forKey:@"longtitude"];
    [attribute setObject:@"bool" forKey:@"storeSort"];
    [[SqliteManager singleton] createTable:@"SqliteMarketObject" attribute:attribute];
//    [[SqliteManager singleton] cleanTable:@"SqliteMarketObject"];
}
//删除表格
- (void)_dropAreaTable:(NSString *)tableName
{
    [[SqliteManager singleton] dropTable:tableName];
}


//往数据库中添加城区
- (void)_addAreaToSqlite:(NSArray *)array
{
    [self _createAreaSqliteTable];
    for (int i = 0; i < array.count; i++) {
        SqliteAreaObject *area = [[SqliteAreaObject alloc] init];
        area.areaId = [array[i] objectForKey:@"id"];
        area.areaName = [array[i] objectForKey:@"name"];
        //                [qi addObject:area];
        [[SqliteManager singleton] insertArea:area];

    }
}
//往数据库中添加超市
- (void)_addMarketToSqlite:(NSArray *)array
{
    [self _createMarketSqliteTable];
    for (int i = 0; i < array.count; i++) {
        SqliteMarketObject *chaoshi = [[SqliteMarketObject alloc] init];
        chaoshi.marketId = [array[i] objectForKey:@"ID"];
        chaoshi.marketName = [array[i] objectForKey:@"NAME"];
        chaoshi.storeSort = [[array[i] objectForKey:@"storeSort"] intValue];
        if ([array[i] objectForKey:@"XAxis"] == [NSNull null]) {
            chaoshi.latitude = 0;
        }
        else
        {
            chaoshi.latitude = [[array[i] objectForKey:@"XAxis"] doubleValue];
        }
        if ([array[i] objectForKey:@"YAxis"] == [NSNull null]) {
            chaoshi.longtitude = 0;
        }
        else
        {
            chaoshi.longtitude = [[array[i] objectForKey:@"YAxis"] doubleValue];
        }
        
        chaoshi.marketAddress = [array[i] objectForKey:@"address"];
        chaoshi.inAreaName = [array[i] objectForKey:@"cityName"];
        chaoshi.inAreaId = [array[i] objectForKey:@"areaId"];
        [[SqliteManager singleton] insertMarket:chaoshi];
        
    }
}
#pragma mark - UITableView dateSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==_userTable){
        
        return [self.needShowAreaArray count];
    }
    else
    {
        return [self.needShowMarketArray count];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==_userTable){
        static NSString *cellName=@"CellItem";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName ];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        UIImage *i2=[UIImage imageNamed:@"切片_65"];
        UIImageView *ima=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *area = [self.needShowAreaArray objectAtIndex:indexPath.row];
        if ([[area objectForKey:@"name"] isEqualToString:self.market.inAreaName]) {
            i2=[UIImage imageNamed:@"切片_70"];
        }
        cell.textLabel.text=[area objectForKey:@"name"];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        cell.textLabel.backgroundColor=[UIColor clearColor];
        
        ima.image=i2;
        cell.backgroundView=ima;
        cell.textLabel.textColor=[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1];
        [areaAllCell addObject:cell];
        return cell;
    }
    else{
        static NSString *cellName=@"CellItem";
        Xuanzechaoshi *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        
        if(cell==nil){
            cell=[[[NSBundle mainBundle]loadNibNamed:@"Xuanzechaoshi" owner:self options:nil]lastObject];
        }
        
        UIImage *i2=[UIImage imageNamed:@"切片_65"];
        UIImageView *ima=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        ima.image=i2;
        cell.backgroundView=ima;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SqliteMarketObject *chaoshi = [self.needShowMarketArray objectAtIndex:indexPath.row];
        cell.chaoshimingcheng.text=chaoshi.marketName;
        cell.chaoshimingcheng.font=[UIFont systemFontOfSize:14];
        
        if ([chaoshi.marketName isEqualToString:self.market.marketName]) {
            cell.chaoshimingcheng.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
        }else{
            cell.chaoshimingcheng.textColor=[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1];
        }
        cell.chaoshidizhi.text=chaoshi.marketAddress;
        cell.chaoshidizhi.numberOfLines=0;
        cell.chaoshidizhi.textColor=[UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1];
        cell.chaoshidizhi.font=[UIFont systemFontOfSize:10];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==_userTable){
        UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_70"]];
        ima.frame=CGRectMake(0, 0, 100, 60);
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundView=ima;
            cell.textLabel.textColor=[UIColor whiteColor];
        
        
        //把对应的超市列表显示出来
        NSDictionary *area = [self.needShowAreaArray objectAtIndex:indexPath.row];
        self.market.inAreaName = [area objectForKey:@"name"];
        for (UITableViewCell *item in areaAllCell) {
            
            if ([item.textLabel.text isEqualToString:[area objectForKey:@"name"]]) {
                continue;
            }
            UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_65"]];
            ima.frame=CGRectMake(0, 0, 100, 60);
            item.backgroundView=ima;
            item.textLabel.textColor=[UIColor blackColor];
        }
        
        [self.needShowMarketArray removeAllObjects];
        for (SqliteMarketObject * item in marketArray) {
            if ([item.inAreaName isEqualToString:[area objectForKey:@"name"]]) {
                [self.needShowMarketArray addObject:item];
            }
        }
//        [_userTable reloadData];
        [_contentTable reloadData];
        _contentTable.contentSize = CGSizeMake(_contentTable.contentSize.width, _contentTable.contentSize.height+50);
    
        
    }
    if(tableView==_contentTable){
        
        Xuanzechaoshi *cell=(Xuanzechaoshi *)[tableView cellForRowAtIndexPath:indexPath];
        cell.chaoshimingcheng.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
        //将该店设为选择项目
         self.market = [self.needShowMarketArray objectAtIndex:indexPath.row];
        [_contentTable reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==_userTable){
        UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_65"]];
        ima.frame=CGRectMake(0, 0, 100, 60);
        
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundView=ima;
        
        cell.textLabel.textColor=[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1];
    }
    if(tableView==_contentTable){
        
        Xuanzechaoshi *cell=(Xuanzechaoshi *)[tableView cellForRowAtIndexPath:indexPath];
        cell.chaoshimingcheng.textColor=[UIColor colorWithRed:81.0/255.0 green:81.0/255.0 blue:81.0/255.0 alpha:1];
        
        
        //        SpxqViewController *sp=[[SpxqViewController alloc]init];
        //        [self.navigationController pushViewController:sp animated:YES];
        //        [sp release];
    }
    
    
}
//- (void)endUpdates{
//    NSLog(@"111");
//    
//}
#pragma mark - 获取手机gps
-(void)toExtend{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1000.0f;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [locationManager stopUpdatingLocation];
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
//    NSLog(@"%@",[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude]);
//    NSLog(@"%@",[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude]);
//    
//    NSLog(@"location ok");
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ButtonAction

- (IBAction)btnClick:(id)sender {
    //按键处理
    [self.delegate pushDetail:sender];
}

-(void)pushDetail:(UIButton *)button{
    switch (button.tag) {
        case 801:
        {
            //返回上一页
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate1 returnSelectedMarket:self.market];
            break;
        }
            
        case 800:{
            //身边华联
            //向服务器发送身边华联请求，并传送latitude 和longtitude
            [self getNearShop];
//            [self _accessNearMarketFromService];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    //关闭菊花
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
@end