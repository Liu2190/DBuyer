//
//  SelectSuperMarketViewController.m
//  DBuyer
//
//  Created by simman on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SelectSuperMarketViewController.h"
#import "SelectSuperMarketSection.h"
#import "SelectSuperMarketCell.h"
#import "SqliteManager.h"
#import "DBManager.h"
#import "WCAlertView.h"

@interface SelectSuperMarketViewController () {
    UITableView *_tableView;
    NSInteger _section;                 // 当前的选中的section
    id _target;
    SEL _action;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    NSMutableArray *_areaArray;         // 区域数组
    NSMutableDictionary *_marketDic;    // 超市数组
    SqliteMarketObject *_currentMarket;  // 当前超市
    
}
@property (nonatomic,assign) NSInteger marketType; // 超市类型
@end

@implementation SelectSuperMarketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _section = -1;
        _areaArray = [[NSMutableArray alloc] init];
        _marketDic = [[NSMutableDictionary alloc] init];
        _marketType = 0;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViewHandle]; // 加载其他
}

#pragma mark - 数据加载相关
#pragma mark 
- (void)loadViewHandle
{
    self.navigationController.navigationBarHidden = YES;
    
    [self setNavigationBarWithContent:@"选择超市" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    // 设置TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height - 64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    [mainDelegate beginLoad];
    [self _createMarketSqliteTable];
    // Do any additional setup after loading the view from its nib.
    
    //获取版本号
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [dict setObject:@"7" forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryVersionInfoForFL,serviceHost]];
    hd.type = 11188;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
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
                    
                    [_areaArray addObjectsFromArray:[self _accessAreaListFromSqlite]];
                    [_marketDic setDictionary:[self selectMarketListWithMarketType:self.marketType]];
                    
                    //对刚进入的table进行处理
//                    [self initTableArray:self.market];
                    [_tableView reloadData];
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
                [_areaArray addObjectsFromArray:array];
                [_tableView reloadData];
            }
            
            
            break;
        }
        case 11190://从服务器上下载超市完成
        {
            NSArray *array = [dict objectForKey:@"storeList"];//正数据
            
            [self _addMarketToSqlite:array];
            [_marketDic setDictionary:[self selectMarketListWithMarketType:self.marketType]];
//            [self initTableArray:self.market];
//            [_contentTable reloadData];
            break;
        }
        case 10103: // 设置默认自提地址
        {
            if([[dict objectForKey:@"status"] intValue]==0){
                //说明设置成功。
                [_target performSelector:_action withObject:_currentMarket];
                [self leftButtonClick:nil];
            }
        }
        default:
            break;
    }
    
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
//创建地区数据库表格
- (void)_createAreaSqliteTable
{
    
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    [attribute setObject:@"text" forKey:@"areaName"];
    [attribute setObject:@"text" forKey:@"areaId"];
    [[SqliteManager singleton] createTable:@"SqliteAreaObject" attribute:attribute];
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
-(NSMutableDictionary *) selectMarketListWithMarketType:(NSInteger)marketType{
    //查询数据库中对应超市类型的超市列表
    NSArray * array =[[SqliteManager singleton] _findAllMarketFromTable:@"SqliteMarketObject"];
    
    // 返回值
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithCapacity:1];
    for (SqliteMarketObject * item  in array) {
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:1];      // 临时数组
        NSInteger isCount = [[tmpDic valueForKey:item.inAreaName] count];   // 查看字典中是否有值
        if (isCount > 0) {  // 如果有则加入数组
            [[tmpDic valueForKey:item.inAreaName] addObject:item];
        } else {            // 否则加入大字典
            [tmpArr addObject:item];
            [tmpDic setValue:tmpArr forKey:item.inAreaName];
        }
        
        // 只有单一超市，此处不做判断
//        if (item.storeSort == marketType) {
//            [mutArray addObject:item];
//        }
    }
    return tmpDic;
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
#pragma mark 从服务器上获取地区列表
- (void)_accessAreasFromService
{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:GetAddressList,serviceHost]];
    hd.type = 11189;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}
#pragma mark 从服务器上获取超市列表
- (void)_accessMarketListFromService{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:GetStoreList,serviceHost]];
    hd.type = 11190;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}
#pragma mark 创建超市数据库表格
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
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView 代理方法
#pragma mark 设置Section的HeadView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SelectSuperMarketSection *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"SelectSuperMarketSection" owner:nil options:nil] lastObject];
    [sectionView addTarget:self Action:@selector(showCell:)];
    // 如果为当前选中的Section，设置图片
    if (_section == section) {
        [sectionView.DistrictButton setBackgroundImage:[UIImage imageNamed:@"arrows_up"] forState:UIControlStateNormal];
    } else {
        [sectionView.DistrictButton setBackgroundImage:[UIImage imageNamed:@"arrows_right"] forState:UIControlStateNormal];
    }
    sectionView.DistrictLable.text = [NSString stringWithFormat:@"%@", [[_areaArray objectAtIndex:section] valueForKey:@"name"]];
    [sectionView setSectionIndex:section];
    return sectionView;
}

#pragma mark 设置SectionHeader的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 71;
}

#pragma mark 设置Row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_areaArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_section == section) {
        NSString *areaName = [[_areaArray objectAtIndex:section] valueForKey:@"name"];
        return [[_marketDic valueForKey:areaName] count];
    }
    return 0;
}
#pragma mark 设置Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"selectSuperMarketCell";
    SelectSuperMarketCell*cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectSuperMarketCell" owner:nil options:nil] lastObject];
    }
    SqliteMarketObject *market = [self getSqliteMarketObjectWithIndexPath:indexPath];
    
    cell.titleLable.text = market.marketName;
    cell.contentLable.text = market.marketAddress;
    return cell;
}
#pragma mark Cell被点击时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SqliteMarketObject *market = [self getSqliteMarketObjectWithIndexPath:indexPath];
    _currentMarket = market;
    //设置默认地址
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:@"1" forKey:@"type"];
    NSString *str=[NSString stringWithFormat:@"%d",[market.marketId integerValue]];
    [dict setObject:str forKey:@"value"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:saveByUserIdAndAttrType,serviceHost]];
    hd.type =10103;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}
-(NSMutableDictionary *)httpDic{
    //网路请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
}

#pragma mark - 根据IndexPath取得SqliteMarketObject对象
- (SqliteMarketObject *)getSqliteMarketObjectWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *areaName = [[_areaArray objectAtIndex:indexPath.section] valueForKey:@"name"];
    SqliteMarketObject *market = [[_marketDic valueForKey:areaName] objectAtIndex:indexPath.row];
    return market;
}

#pragma mark - 
#pragma mark Section上的按钮事件
- (void)showCell:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    SelectSuperMarketSection *sectionView = (SelectSuperMarketSection *)btn.superview;
    NSInteger section = [sectionView sectionIndex];

    if ([sectionView sectionIndex] == _section) {
        _section = -1;
    } else {
        _section = [sectionView sectionIndex];
    }
    [_tableView reloadData];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section]  withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark -
#pragma mark TargetAction
- (void)addTarget:(id)target Action:(SEL)action
{
    _target = target;
    _action = action;
}

#pragma mark 网络请求失败
-(void)downloadFail{
    
    [mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
