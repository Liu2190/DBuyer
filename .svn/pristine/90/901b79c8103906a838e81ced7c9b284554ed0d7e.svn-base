//
//  ChooseAddressViewController.m
//  DBuyer
//  选择地址
//  Created by lixinda on 13-11-22.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "AddAddressBtnCell.h"
#import "ChooseAddressCell.h"
#import "AddAddressViewController.h"
#import "BtnDelegate.h"
#import "EditReceivingViewController.h"


@interface ChooseAddressViewController ()

@end

@implementation ChooseAddressViewController
{
    LoadView * loadView;
    NSInteger ifNeedRefreshAddressList;
    NSString * defaultAddressID;
    NSString * tempAddressID;
    EditReceivingViewController * shbjVC;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _addressList = [[NSMutableArray alloc]init];
        defaultAddressID = [[NSString alloc]init];
        tempAddressID = [[NSString alloc]init];
        shbjVC = [[EditReceivingViewController alloc]init];
        shbjVC.delegate = self;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (ifNeedRefreshAddressList ==1) {
        [self getAddressList];
    }else{
        for (AddressItem * item in self.addressList) {
            if (item.isDefault ==1) {
                defaultAddressID = item.addressId;
            }
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKCOLOR;
    self.tableView.backgroundColor = BACKCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressList.count+1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row !=self.addressList.count){
        
        AddressItem * item =[self.addressList objectAtIndex:indexPath.row];
        shbjVC.address = item;
        shbjVC.chooseFlag =1;
        [self.navigationController pushViewController:shbjVC animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier_AddBtnCell = @"AddAddressBtnCell";
    
    static NSString *CellIdentifier_ChooseCell = @"ChooseAddressCell";
    
    if (indexPath.row ==self.addressList.count) {
        AddAddressBtnCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_AddBtnCell];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AddAddressBtnCell" owner:self options:nil]lastObject];
        }
        cell.delegate = self;
        cell.backgroundColor = BACKCOLOR;
        return cell;
    }
    ChooseAddressCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier_ChooseCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ChooseAddressCell" owner:self options:nil]lastObject];
    }
    AddressItem * item = [self.addressList objectAtIndex:indexPath.row];
    if (item.isDefault == 1) {
        tempAddressID = item.addressId;
    }
    [cell setMyAddressItem:[self.addressList objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.backgroundColor = BACKCOLOR;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.addressList.count) {
        return 128.0f;
    }
    return 134.0f;
}
- (IBAction)didClickBack:(UIButton *)sender {
    //设定默认地址
    if (![tempAddressID isEqualToString:defaultAddressID]) {
        [self setDefaultAddress];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - private methods

-(void)setDefaultAddress{
    //    kSetDeAddrss
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:tempAddressID forKey:@"addreId"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kSetDeAddrss,serviceHost]];
    hd.type =10080;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    
    
    
    //    loadView.beStop =NO;
}

-(void)getAddressList{
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryAddressList,serviceHost]];
    hd.type =10101;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
}

-(NSMutableDictionary *)httpDic{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}
#pragma mark - BtnDelegate
-(void)pushDetail:(UIButton *)button{
    
    switch (button.tag) {
        
        case 9120:
        {
            //选择地址
            ChooseAddressCell * chooseCell = nil;
            if ([[[UIDevice currentDevice]systemVersion] compare:@"7.0"] == NSOrderedAscending) {
                chooseCell = (ChooseAddressCell *)[[button superview]superview];
            }else{
               chooseCell = (ChooseAddressCell *)[[[button superview]superview]superview];
            }
            
            chooseCell.checkboxBtn.enabled = NO;
            for (AddressItem * item in self.addressList) {
                item.isDefault = 0;
                if ([self.addressList indexOfObject:item]==[self.tableView indexPathForCell:chooseCell].row) {
                    item.isDefault = YES;
                    tempAddressID = item.addressId;
                }
            }
            [self.tableView reloadData];
        
        }
            break;
        case 9121:
        {
            //添加地址
            ifNeedRefreshAddressList = 1;
            AddAddressViewController * addVC = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
            [self.navigationController pushViewController:addVC animated:YES];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    [self.mainDelegate endLoad];
    
    switch (hd.type) {
            
             case 10103:
            //接收设定默认地址的结果
             if ([[dict objectForKey:@"status"] intValue] == 0) {
             
             }
             else
             {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置默认地址失败,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alertView show];
             }
             
             break;
             
        case 10101:
            //接收地址列表
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                loadView.beStop = YES;
                [self.addressList removeAllObjects];
                NSArray * array = [dict objectForKey:@"result"];
                
                for (NSDictionary * item in array) {
                    AddressItem * tempAddress = [[AddressItem alloc]initWithDic:item];
                    if (tempAddress.isDefault ==1) {
                        defaultAddressID = tempAddress.addressId;
                    }
                    [self.addressList addObject:tempAddress];
                }
                [self.tableView reloadData];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加失败了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }

            break;
        default:
            break;
    }
    
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

#pragma mark - ShbjViewControllerDelegate
-(void) refreshAddressList{
    //刷新地址列表
    [self getAddressList];
}

@end
