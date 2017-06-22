//
//  DefaultAddressViewController.m
//  DBuyer
//  地址列表页
//  Created by lixinda on 13-11-23.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "DefaultAddressViewController.h"
#import "AddAddressBtnCell.h"
#import "ChooseAddressCell.h"
#import "AddAddressViewController.h"
#import "BtnDelegate.h"
#import "ShkongCell.h"
#import "EditReceivingViewController.h"
#import "ChooseSupermarketViewController.h"
#import "SelectSuperMarketViewController.h"
#import "LoadView.h"
#import "SupermarketCell.h"

@interface DefaultAddressViewController () {
    id _target;
    SEL _action;
}

@property (nonatomic, retain) SqliteMarketObject *marketObject;
@property (nonatomic, retain) NSMutableArray *cellArray;

@end

@implementation DefaultAddressViewController

{
    UITableView * userTableView;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    LoadView * loadView;
    
    NSInteger ifNeedRefreshAddressList;
    NSInteger ifHasAddress;
    NSString * boutique;//精品店id
    NSString * stores;//综合店id
    SqliteMarketObject * zhMarket;
    SqliteMarketObject * jpMarket;
    ChooseSupermarketViewController * zhMarketVC;
    ChooseSupermarketViewController * jpMarketVC;
    NSInteger ifChangeMarket;
    NSString * defaultAddressID;
    NSString * tempAddressID;
    AddressItem *_addressItem;      // 当前的地址
    AddressItem *_backaddress;      // 回传的地址
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _addressList = [[NSMutableArray alloc]init];
        boutique = [[NSString alloc]init];
        defaultAddressID = [[NSString alloc]init];
        tempAddressID = [[NSString alloc]init];
        stores = [[NSString alloc]init];
        zhMarket = [[SqliteMarketObject alloc]init];
        jpMarket = [[SqliteMarketObject alloc]init];
        zhMarketVC = [[ChooseSupermarketViewController alloc]initWithNibName:@"ChooseSupermarketViewController" bundle:nil];
        zhMarketVC.delegate1 = self;
        jpMarketVC = [[ChooseSupermarketViewController alloc]initWithNibName:@"ChooseSupermarketViewController" bundle:nil];
        jpMarketVC.delegate1 = self;
        _addressItem = [[AddressItem alloc] init];
        _marketObject = [[SqliteMarketObject alloc] init];
        [self addLoadView];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAddressList];  // 获取地址
    [self getQueryUserAttrType]; // 获取默认自提超市
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.addressList removeAllObjects];
    ifChangeMarket=0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBarWithContent:@"地址管理" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    float startPoint ;
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending){
        //当前系统小于IOS7.0
        startPoint = 44.0f;
    }
    else
    {
        startPoint = 64.0f;
    }
    userTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, startPoint + 10, 320, WindowHeight-startPoint-42) style:UITableViewStylePlain];
    userTableView.backgroundColor=[UIColor clearColor];
    [userTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    userTableView.delegate=self;
    userTableView.dataSource=self;
    userTableView.backgroundColor = [UIColor clearColor];
    userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    userTableView.allowsSelection = NO;
    [self.view addSubview:userTableView];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
//    loadView = (LoadView *)[self.view viewWithTag:LoadViewFlag];
   
}
-(void)leftButtonClick:(UIButton *)button{
    if (_target && _action) {
        [_target performSelector:_action withObject:_addressItem];
    } else {
        //保存地址信息
//        if (self.addressList.count == 0) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您没有常用收货地址，添加常用收货地址能让您购物更快捷" delegate:self cancelButtonTitle:@"不添加" otherButtonTitles:@"添加", nil];
//            alert.tag =11;
//            [alert show];
//            return;
//        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            if (ifHasAddress == 1) {
                return 0;
            }
            return 1;
        }
        case 1:
        {
            if (ifHasAddress == 1) {
                return self.addressList.count;
            }
            return 0;
        }
        case 2:
        {
            return 1;
        }
        case 3:
        {
            return 1;
        }
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier_AddBtnCell = @"AddAddressBtnCell";
//    static NSString *CellIdentifier_MarketChoose = @"MarketChoose";
    static NSString *CellIdentifier_SupermarketCell = @"SupermarketCell";

    static NSString *CellIdentifier_ChooseCell = @"ChooseAddressCell";
    switch (indexPath.section) {
        case 0:
        {
            //收货地址为空时
            ShkongCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShkongCell"];
            if (cell ==nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"ShkongCell" owner:self options:nil]lastObject];
            }
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }
            
        case 1:
        {
            //地址cell
            ChooseAddressCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier_ChooseCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"ChooseAddressCell" owner:self options:nil]lastObject];
            }
            if (self.addressList.count >0) {
                [cell setMyAddressItem:[self.addressList objectAtIndex:indexPath.row]];
            }
            // 如果是第一个或者是最后一个，加圆角
//            if (indexPath.row == 0) {
//                [cell.backGroundView setImage:[UIImage imageNamed:@"top_raduis"]];
//            } else if (indexPath.row == (self.addressList.count - 1)) {
//                [cell.backGroundView setImage:[UIImage imageNamed:@"buttom_raduis"]];
//            }else {
                [cell.backGroundView setBackgroundColor:[UIColor whiteColor]];
//            }
            // 如果不是第一个，则添加中间的绿线（没办法拉。。。）
            if (indexPath.row != 0 && self.addressList.count != 1) {
                UIImageView *lineImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_line"]];
                lineImg.frame=CGRectMake(9, 0, 302, 1);
                [cell addSubview:lineImg];
            }
            
            
            
            cell.delegate = self;
            cell.checkboxBtn.enabled=NO;
            cell.backgroundColor = [UIColor clearColor];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToAddressDetailViewController:)];
            [cell addGestureRecognizer:tap];
            return cell;
        }
        case 2:
        {
            
            SupermarketCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_SupermarketCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SupermarketCell" owner:nil options:nil] objectAtIndex:0];
            }
            
            if (_marketObject) {
                [cell.SuperMarketButton setTitle:[NSString stringWithFormat:@"+%@", _marketObject.marketName] forState:UIControlStateNormal];
            } else {
                [cell.SuperMarketButton setTitle:@"+综合超市" forState:UIControlStateNormal];
            }
            
            [cell addTarget:self Action:@selector(pushDetail:)];
            
            return cell;
        }
        case 3:
        {
            //添加地址的按钮
            AddAddressBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_AddBtnCell];
            if (cell==nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"AddAddressBtnCell" owner:self options:nil]lastObject];
            }
            cell.delegate = self;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
            break;
        }
            
        default:
            break;
    }
    if (indexPath.row ==self.addressList.count) {
        AddAddressBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_AddBtnCell];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AddAddressBtnCell" owner:self options:nil]lastObject];
        }
        cell.delegate = self;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    ChooseAddressCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier_ChooseCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChooseAddressCell" owner:self options:nil]lastObject];
    }
    
    [cell setMyAddressItem:[self.addressList objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return 243.0f;
        }
        case 1:
        {
            return 90.0f;
        }
        case 2:
        {
            return 60.0f;
        }
        case 3:
        {
            return 78.0f;
        }
        default:
            break;
    }

    return 134.0f;
}
#pragma mark - private methods
-(void) addAddress{
    //添加地址
    ifNeedRefreshAddressList = 1;
    AddAddressViewController * addVC = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    addVC.boutique = jpMarket.marketId;
    addVC.stores = zhMarket.marketId;
    if (_target && _action) {
        [addVC addTarget:_target action:_action];
    } else {
        [addVC addTarget:self action:@selector(addAddressBackAction:)];
    }
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark 添加完地址的回调方法
- (void)addAddressBackAction:(AddressItem *)sender
{
    _addressItem = sender;
    tempAddressID = sender.addressId;
    [self setDefaultAddress];
}
- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

-(void)goToAddressDetailViewController:(UITapGestureRecognizer *) sender{
    //跳转到地址编辑
//    ShxqViewController * shbxqVC = [[ShxqViewController alloc]init];
//    [self.navigationController pushViewController:shbxqVC animated:YES];
   
    
    ChooseAddressCell * cell =(ChooseAddressCell *) sender.view;
    AddressItem *address = [self.addressList objectAtIndex:[userTableView indexPathForCell:cell].row];
    
    if (_action && _target) {
        tempAddressID = address.addressId;
        _backaddress = address;
        [self setDefaultAddress];
        return;
    }
    EditReceivingViewController * shbjVC = [[EditReceivingViewController alloc]init];
    shbjVC.address = address;
    NSLog(@"%@",shbjVC.address);
    [self.navigationController pushViewController:shbjVC animated:YES];
}
-(void)saveAddressListResult{
//    //保存地址列表的结果
//    AddressItem * tempAddress = [self.addressList objectAtIndex:0];
//    
//    //向服务器发送超市地址
//    //向网络请求待发货订单List
//    HttpDownload *hd=[[HttpDownload alloc]init];
//    thisDownLoad = hd;
//    hd.delegate=self;
//    
//    NSMutableDictionary *dict=[self httpDic];
//    [dict setObject:jpMarket.marketId forKey:@"boutique"];
//    [dict setObject:zhMarket.marketId forKey:@"stores"];
//    [dict setObject:tempAddress.addressId forKey:@"addreId"];
//    [dict setObject:tempAddress.areaId forKey:@"areaId"];
//    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kGetUpdateStatus,serviceHost]];
//    NSLog(@"%@",dict);
//    hd.type =10104;
//    hd.method=@selector(downloadComplete:);
//    hd.failMethod = @selector(downloadFail);
//    loadView.beStop =NO;
//    [[self mainDelegate] beginLoad];
}
-(void)setDefaultAddress{
//    kSetDeAddrss
    //设置默认地址
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:tempAddressID forKey:@"addreId"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kSetDeAddrss,serviceHost]];
    hd.type =10103;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
    [[self mainDelegate] beginLoad];
}


#pragma mark 获取默认自提超市
- (void)getQueryUserAttrType {
    [[self mainDelegate] beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:@"1" forKey:@"type"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:queryUserAttrType,serviceHost]];
    hd.type =10109;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
}

-(void)getAddressList{
    //查询地址列表
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryAddressList,serviceHost]];
    hd.type =10102;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
    [[self mainDelegate] beginLoad];
}

-(NSMutableDictionary *)httpDic{
    //网路请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    return dict;
    
}

#pragma mark - BtnDelegate
-(void)pushDetail:(UIButton *)button{
#define BoutiqueSupermarket_tag   6554  // 精品超市
#define VarietySupermarket_tag    6555  // 综合超市
    
    switch (button.tag) {
            
        case 9120:  // 设置默认收货地址
        {
            //选择地址
            ChooseAddressCell * chooseCell = nil;
            if([[[UIDevice currentDevice]systemVersion] compare:@"7.0"] == NSOrderedAscending){
                chooseCell = (ChooseAddressCell *)[[button superview]superview];
            }else{
                chooseCell = (ChooseAddressCell *)[[[button superview]superview]superview];
            }
//            chooseCell.checkboxBtn.enabled = NO;
            for (AddressItem * item in self.addressList) {
                item.isDefault = 0;
                if ([self.addressList indexOfObject:item]==[userTableView indexPathForCell:chooseCell].row) {
                    item.isDefault = YES;
                    tempAddressID = item.addressId;
                    _addressItem = item;
                }
            }
            
            if (![defaultAddressID isEqualToString:chooseCell.addressItem.addressId]) {
                [self setDefaultAddress];
            }
            
            
            //设定默认地址
            if (![tempAddressID isEqualToString:defaultAddressID]) {
                
//               [userTableView reloadData];
            }
        }
            break;
        case 9121:
        {
            //添加地址的事件
            [self addAddress];
            
        }
            break;
            
        case VarietySupermarket_tag:
        {
            //选择综合超市
            zhMarketVC.marketType = 0;
            zhMarketVC.market = zhMarket;
            SelectSuperMarketViewController *selectVC = [[SelectSuperMarketViewController alloc] init];
            [selectVC addTarget:self Action:@selector(returnSelectedMarket:)];
            [self.navigationController pushViewController:selectVC animated:YES];
            [userTableView reloadData];
            
        }
            break;
        case BoutiqueSupermarket_tag:
        {
            //选择精品超市
            jpMarketVC.marketType = 1;
            jpMarketVC.market = jpMarket;

            [self.navigationController pushViewController:jpMarketVC animated:YES];

            [userTableView reloadData];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    switch (hd.type) {
            
        case 10109:
        {
            [[self mainDelegate] endLoad];
            
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                NSDictionary *item = [[dict objectForKey:@"storeList"] objectAtIndex:0];
                _marketObject.marketName =[item objectForKey:@"name"];
                [userTableView reloadData];
            } else {
             // ------
            }
        }
            break;
        case 10102:
            //接收超市列表信息
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                [self.addressList removeAllObjects];
                NSArray * array = [dict objectForKey:@"result"];
                if (array.count == 1) {
                    if ([[array objectAtIndex:0] objectForKey:@"address"]==nil&&[[array objectAtIndex:0] objectForKey:@"consignee"]==nil) {
                    ifHasAddress = 0;
                    }else{
                        ifHasAddress =1;
                        NSDictionary * dic = [array objectAtIndex:0];
                        
                        if (ifChangeMarket==2) {
                            boutique = [dic objectForKey:@"boutique"];
                            stores = [dic objectForKey:@"stores"];
//                            jpMarket.marketId = [dic objectForKey:@"boutique"];
//                            jpMarket.marketName =[dic objectForKey:@"boutiqueAdd"];
                            _marketObject.marketId = [dic objectForKey:@"stores"];
                            _marketObject.marketName =[dic objectForKey:@"storesAdd"];
                        }
                    }
                }else{
                    ifHasAddress =1;
                    
                    NSDictionary * dic = [array objectAtIndex:0];
                    
                    
                    if(ifChangeMarket ==2){
                        boutique = [dic objectForKey:@"boutique"];
                        stores = [dic objectForKey:@"stores"];
                        jpMarket.marketId = [dic objectForKey:@"boutique"];
                        jpMarket.marketName =[dic objectForKey:@"boutiqueAdd"];
                        zhMarket.marketId = [dic objectForKey:@"stores"];
                        zhMarket.marketName =[dic objectForKey:@"storesAdd"];
                    }
                    
                    
                }
                
                for (NSDictionary * item in array) {
                    AddressItem * tempAddress = [[AddressItem alloc]initWithDic:item];
                    if (tempAddress.isDefault == 1) {
                        tempAddressID = tempAddress.addressId;
                        defaultAddressID =tempAddress.addressId;
                    }
                    [self.addressList addObject:tempAddress];
                }
                [userTableView reloadData];
                [[self mainDelegate] endLoad];
                ifChangeMarket =1;
            }else if([[dict objectForKey:@"status"] intValue] == 3){
                [mainDelegate endLoad];
                ifHasAddress =0;
                if([jpMarket.marketName isEqual:[NSNull class]]){
                    jpMarket.marketName = @"+精品超市";
                }
                else if([jpMarket.marketName length] == 0) {
                    jpMarket.marketName = @"+精品超市";
                }
                if([zhMarket.marketName isEqual:[NSNull class]]){
                    zhMarket.marketName = @"+综合超市";
                }
                else if ([zhMarket.marketName length] == 0) {
                    zhMarket.marketName = @"+综合超市";
                }
                [[self mainDelegate] endLoad];
                [userTableView reloadData];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"取得地址列表失败,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [[self mainDelegate] endLoad];
            }
            
            break;
        case 10104:
            [[self mainDelegate] endLoad];
            //接收更新收货地址的结果
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                NSString * str = [dict objectForKey:@"msg"];
                NSString * errMsg = [NSString stringWithFormat:@"保存地址更新失败,请检查网络\n%@",str];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:errMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            break;
        case 10103:
            [[self mainDelegate] endLoad];
            [userTableView reloadData];
            //接收设置默认地址的结果
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                if (_target && _action) {
                    [_target performSelector:_action withObject:_backaddress];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [userTableView reloadData];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置默认地址失败,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            break;
        default:
            break;
    }
    
}

- (IBAction)didClickBack:(UIButton *)sender {
    //保存地址信息
    if (self.addressList.count == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请添加地址信息" delegate:self cancelButtonTitle:@"不添加" otherButtonTitles:@"添加", nil];
        alert.tag =11;
        [alert show];
        return;
    }
    
    //将结果保存上传服务器
    [[self mainDelegate] beginLoad];
    [self saveAddressListResult];
    
}
#pragma mark - AlertView Delegate
//- (void)alertViewCancel:(UIAlertView *)alertView{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==11) {
        if (buttonIndex ==0) {
           [self.navigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex ==1) {
            [self addAddress];
        }
    }
    if (buttonIndex ==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - ChooseSupermarketViewController Delegate
-(void)returnSelectedMarket:(SqliteMarketObject *)market{
    //将选择超市的结果，进行保存与展现
    
    _marketObject = market;
    [userTableView reloadData];
    if (market.storeSort) {
        jpMarket = market;
        ifChangeMarket = 1;
        [userTableView reloadData];
    }else{
        zhMarket = market;
        ifChangeMarket = 1;
        [userTableView reloadData];
    }
}

#pragma mark 网络请求失败
-(void)downloadFail{
    
    [mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    //关闭菊花
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}

- (void)dealloc
{
    [thisDownLoad ConnectionCanceled];
    [super dealloc];
}

@end
