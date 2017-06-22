//
//  MapStorDetailViewController.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "MapStorDetailViewController.h"
#import "BMKMapView.h"
#import "BMKMapView+addAnnotation.h"
#import "Store.h"
#import "HttpDownload.h"
#import "SqliteMarketObject.h"
#import "WCAlertView.h"
#import "MapRouteViewController.h"
#import "AppDelegate.h"
#import "TMapStore.h"

@interface MapStorDetailViewController () {
    AppDelegate *mainDelegate;
}

@end

@implementation MapStorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithContent:@"身边华联" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    navigationBar=[NavigationBarView navigationBarView];
    //调用百度地图
    [self initMapView];
    [self detailTable];
}

- (void)dealloc
{
    self.mapManager = nil;
    self.mapView = nil;
    self.locManager = nil;
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated {
    if([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]==NSOrderedAscending) {
        self.mapView.frame = CGRectMake(0,44, 320,250);
        self.storeDetailTableView.frame=CGRectMake(0,self.view.frame.size.height-self.mapView.frame.size.height-20+10, 320,260);
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.storeDetailTableView.frame=CGRectMake(0,WindowHeight-255, 320,255);
        self.mapView.frame = CGRectMake(0,60, 320,WindowHeight-310);
    }

    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [self addAnnotationWithStore:self.store];

}


- (void)addAnnotationWithStore:(Store*)mapStore {
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];//添加图标
    CGFloat latitude = mapStore.XAxis;
    CGFloat longitude = mapStore.YAxis;
    NSString * title = mapStore.name;
    NSString *subTitle=mapStore.address;
    
    CLLocationCoordinate2D nearStore;
    nearStore.latitude = latitude;
    nearStore.longitude = longitude;
    annotation.coordinate = nearStore;
    annotation.title = title;
    annotation.subtitle=subTitle;
    [_mapView addAnnotation:annotation];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}


//导航栏的左边返回按钮
-(void)leftButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
   [self.leveyTabBarController hidesTabBar:NO animated:YES];
}

-(void)detailTable {
    self.storeDetailTableView =[[UITableView alloc]initWithFrame:CGRectMake(0,WindowHeight-255, 320,255) style:UITableViewStylePlain];
    self.storeDetailTableView.showsHorizontalScrollIndicator=NO;
    self.storeDetailTableView.showsVerticalScrollIndicator=NO;
    self.storeDetailTableView.backgroundColor=[UIColor whiteColor];
    self.storeDetailTableView.separatorColor=[UIColor whiteColor];
    self.storeDetailTableView.delegate=self;
    self.storeDetailTableView.dataSource=self;
    self.storeDetailTableView.userInteractionEnabled=YES;
    [self.view addSubview:self.storeDetailTableView];
}

//初始化百度地图
-(void)initMapView {
    self.mapView.showsUserLocation = NO;

    self.mapView=[[[BMKMapView alloc] initWithFrame:CGRectMake(0,60, 320,WindowHeight-310)] autorelease];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate=self;
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    //[self.mapView setZoomLevel:10];
    [self.view addSubview:self.mapView];
    //self.mapView.showsUserLocation=NO;

}
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    _region.center.longitude =self.store.YAxis;
    
    _region.center.latitude =self.store.XAxis;
    _region.span.latitudeDelta = 0.05;
    _region.span.longitudeDelta = 0.05;
}

//加载网络数据  b
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    static NSString *identifier = @"Annotation";
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"MapIcon"];
        annotationView.canShowCallout = YES;
    }
    
    return annotationView;
}

//百度地图图标的视图代理方法
-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    Store *store=self.store;
    MapRouteViewController *MapHearcontroller = [[MapRouteViewController alloc]init];
    MapHearcontroller.store=store;
    [self.navigationController pushViewController:MapHearcontroller animated:YES];
}
//定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
    if (error != nil) {

    }else {

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIndefiter=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiter];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiter];
        //商店信息
        countLable=[[UILabel alloc]initWithFrame:CGRectMake(10,5,150, 30)];
        countLable.backgroundColor=[UIColor clearColor];
        countLable.tag=100;
        countLable.font=[UIFont systemFontOfSize:16];
        countLable.textAlignment=NSTextAlignmentLeft;
        countLable.textColor=[UIColor blackColor];
        [cell.contentView addSubview:countLable];
        
        addressLable=[[UILabel alloc]initWithFrame:CGRectMake(20,35,280, 20)];
        addressLable.backgroundColor=[UIColor clearColor];
        addressLable.tag=120;
        addressLable.numberOfLines=0;
        addressLable.font=[UIFont systemFontOfSize:14];
        addressLable.textAlignment=NSTextAlignmentLeft;
        addressLable.textColor=[UIColor colorWithRed:0.525 green:0.525 blue:0.525 alpha:1];
        [cell.contentView addSubview:addressLable];
        
        areaLable=[[UILabel alloc]initWithFrame:CGRectMake(20,60,60, 20)];
        areaLable.backgroundColor=[UIColor clearColor];
        areaLable.tag=130;
        areaLable.font=[UIFont systemFontOfSize:14];
        areaLable.textAlignment=NSTextAlignmentLeft;
        areaLable.textColor=[UIColor colorWithRed:0.525 green:0.525 blue:0.525 alpha:1];
        [cell.contentView addSubview:areaLable];
        
        UILabel *timeLable=[[UILabel alloc]initWithFrame:CGRectMake(100,60,170, 20)];
        timeLable.backgroundColor=[UIColor clearColor];
        timeLable.tag=140;
        timeLable.font=[UIFont systemFontOfSize:14];
        timeLable.textAlignment=NSTextAlignmentCenter;
        timeLable.textColor=[UIColor colorWithRed:0.525 green:0.525 blue:0.525 alpha:1];
        [cell.contentView addSubview:timeLable];
        
        meterLable=[[UILabel alloc]initWithFrame:CGRectMake(240,0,80,40)];
        meterLable.backgroundColor=[UIColor clearColor];
        meterLable.numberOfLines=0;
        meterLable.tag=150;
        meterLable.font=[UIFont systemFontOfSize:12];
        meterLable.textAlignment=NSTextAlignmentCenter;
        meterLable.textColor=[UIColor colorWithRed:0.165 green:0.584 blue:0.365 alpha:1];
        [cell.contentView addSubview:meterLable];
        
        UIImageView *cellLineImg=[[UIImageView alloc]initWithFrame:CGRectMake(240, 5, 80,1)];
        cellLineImg.backgroundColor=[UIColor clearColor];
        cellLineImg.tag=260;
        [cell.contentView addSubview:cellLineImg];
        
        UIImageView *cellLineImge=[[UIImageView alloc]initWithFrame:CGRectMake(240, 33, 80, 1)];
        cellLineImge.backgroundColor=[UIColor clearColor];
        cellLineImge.tag=270;
        [cell.contentView addSubview:cellLineImge];
        
        UIImageView *shuxianImg=[[UIImageView alloc]initWithFrame:CGRectMake(10,30,10,50)];
        shuxianImg.backgroundColor=[UIColor clearColor];
        shuxianImg.tag=280;
        [cell.contentView addSubview:shuxianImg];
        
        //”到这里去“的按钮
        
        //电话
        //到这里去的小汽车
        
        UIImageView *carImg=[[UIImageView alloc]initWithFrame:CGRectMake(90, 20, 20, 20)];
        carImg.tag=170;
        carImg.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:carImg];
        
        
        UILabel *phonelable=[[UILabel alloc]initWithFrame:CGRectMake(65, 10, 200, 30)];
        phonelable.textColor=[UIColor blackColor];
        phonelable.tag=180;
        phonelable.backgroundColor=[UIColor clearColor];
        phonelable.textAlignment=NSTextAlignmentCenter;
        phonelable.font=[UIFont systemFontOfSize:20];
        [cell.contentView addSubview:phonelable];
        //电话图标
        UIImageView *leftImg=[[UIImageView alloc]initWithFrame:CGRectMake(50, 15, 25, 25)];
        leftImg.tag=190;
        leftImg.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:leftImg];
        //电话向右的图片
        UIImageView *rightImg=[[UIImageView alloc]initWithFrame:CGRectMake(280, 15, 20, 20)];
        rightImg.tag=200;
        rightImg.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:rightImg];
        //订单
        UILabel *dingdanlable=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 200, 30)];
        dingdanlable.textColor=[UIColor colorWithRed:0.165 green:0.584 blue:0.365 alpha:1];
        dingdanlable.tag=210;
        dingdanlable.backgroundColor=[UIColor clearColor];
        dingdanlable.textAlignment=NSTextAlignmentCenter;
        dingdanlable.font=[UIFont boldSystemFontOfSize:18];
        [cell.contentView addSubview:dingdanlable];
        
        UIImageView *imageLine=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 1)];
        imageLine.backgroundColor=[UIColor clearColor];
        imageLine.tag=220;
        [cell.contentView addSubview:imageLine];
        
        UIImageView *dagouImg_=[[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 25, 25)];
        dagouImg_.tag=230;
        dagouImg_.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:dagouImg_];
        
        UIImageView *cellImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320,50)];
        cellImg.tag=240;
        cellImg.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:cellImg];
        
        
    }
    
    switch (indexPath.section) {
        case 0:
        {
            if(indexPath.row==0)
            {
                UILabel *title=(UILabel *)[cell.contentView viewWithTag:100];
                title.text=[NSString stringWithFormat:@"北京的%@", self.store.name];
                UILabel *address=(UILabel *)[cell.contentView viewWithTag:120];
                address.text=[NSString stringWithFormat:@"%@", self.store.address];
                UILabel *area=(UILabel *)[cell.contentView viewWithTag:130];
                area.text=[NSString stringWithFormat:@"%@",self.store.areaName];
                UILabel *time=(UILabel *)[cell.contentView viewWithTag:140];
                time.text=@"早8：00--晚9：00";
                UILabel *meterlab=(UILabel *)[cell.contentView viewWithTag:150];
                meterlab.text=[NSString stringWithFormat:@"%.2fKm",self.store.meter/1000];
                
                UIImageView *cellLine=(UIImageView *)[cell.contentView viewWithTag:260];
                cellLine.image=[UIImage imageNamed:@"MapCellLines"];
                
                UIImageView *cellLine2=(UIImageView *)[cell.contentView viewWithTag:270];
                cellLine2.image=[UIImage imageNamed:@"MapCellLines"];
                
                UIImageView *shuxianImg=(UIImageView *)[cell.contentView viewWithTag:280];
                shuxianImg.image=[UIImage imageNamed:@"MapSecondLine"];
            }
            
            if(indexPath.row==1)
            {
                UIImageView *carImg=[[UIImageView alloc]initWithFrame:CGRectMake(90,13, 25, 25)];
                carImg.backgroundColor=[UIColor clearColor];
                carImg.image=[UIImage imageNamed:@"MapSecondCar"];
                UIButton *goButton=[UIButton buttonWithType:UIButtonTypeCustom];
                [goButton setTitle:@"到这里去" forState:UIControlStateNormal];
                goButton.frame=CGRectMake(0, 0, 320,50);
                [goButton setBackgroundColor:[UIColor colorWithRed:0.165 green:0.584 blue:0.365 alpha:1]];
                [goButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:goButton];
                [goButton addSubview:carImg];

            }
            
        }
            break;
        case 1:
        {
           if(indexPath.row==0)
           {
               
               if([self IsEmptyOfString:self.store.telephone]==NO)
               {
               
               UILabel *lable=(UILabel *)[cell.contentView viewWithTag:180];
               lable.text=[NSString stringWithFormat:@"010-%@",self.store.telephone];
               UIImageView *leftImg=(UIImageView *)[cell.contentView viewWithTag:190];
               leftImg.image=[UIImage imageNamed:@"MapCellPhone"];
               UIImageView *rightImg=(UIImageView *)[cell.contentView viewWithTag:200];
               rightImg.image=[UIImage imageNamed:@"MapSecondCellBack"];
               UIButton *callUs=[UIButton buttonWithType:UIButtonTypeCustom];
               callUs.frame=CGRectMake(0, 0, 320, 40);
               [callUs addTarget:self action:@selector(callus) forControlEvents:UIControlEventTouchUpInside];
               [cell.contentView addSubview:callUs];
               }
               else
               {
                   UILabel *lable=(UILabel *)[cell.contentView viewWithTag:180];
                   lable.text=[NSString stringWithFormat:@"暂无联系方式"];
                   UIImageView *leftImg=(UIImageView *)[cell.contentView viewWithTag:190];
                   leftImg.image=[UIImage imageNamed:@"MapCellPhone"];
                   UIImageView *rightImg=(UIImageView *)[cell.contentView viewWithTag:200];
                   rightImg.image=[UIImage imageNamed:@"MapSecondCellBack"];
                   

               }
           }
        if(indexPath.row==1)
        {
            UILabel *dingdanlable=(UILabel *)[cell.contentView viewWithTag:210];
            dingdanlable.text=@"设为您的订单自提地址";
            UIImageView *lineImg=(UIImageView *)[cell.contentView viewWithTag:220];
            lineImg.image=[UIImage imageNamed:@"horizontal_line"];
            dagouImg=(UIImageView *)[cell.contentView viewWithTag:230];
            dagouImg.image=[UIImage imageNamed:@"MapDingDan"];
            dagouImg.hidden=YES;
            UIButton *dindanButton=[UIButton buttonWithType:UIButtonTypeCustom];
            dindanButton.frame=CGRectMake(0, 0, 320, 50);
            [dindanButton addTarget:self action:@selector(zidingdan) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:dindanButton];
        }
            
        }
            break;

        default:
            break;
    }
   
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if (indexPath.row == 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)go
{
    Store *store=self.store;
    MapRouteViewController *MapHearVC=[[MapRouteViewController alloc]init];
    MapHearVC.store=store;
    [self.navigationController pushViewController:MapHearVC animated:YES];
   
}
-(void)zidingdan
{
    //   kSetDeAddrss
    //设置默认地址
    HttpDownload *hd=[[HttpDownload alloc]init];
    Store *store=self.store;
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:@"1" forKey:@"type"];//saveByUserIdAndAttrType
    NSString *str=[NSString stringWithFormat:@"%d",store.storeId];
    [dict setObject:str forKey:@"value"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:saveByUserIdAndAttrType,serviceHost]];//interface/userAttribute/saveByUserIdAndAttrType
    hd.type =10103;
    hd.method=@selector(downloadComplete:);

    
    dagouImg.hidden=NO;
}
-(NSMutableDictionary *)httpDic{
    //网路请求的固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}

 -(void)downloadComplete:(HttpDownload *)hd1{
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
        
        if(dict){
            if(hd1.type==10103){
                if([[dict objectForKey:@"status"] intValue]==1){
                    //说明设置成功。
                    [WCAlertView showAlertWithTitle:nil message:@"已设为您的常用自提超市" customizationBlock:^(WCAlertView * alertView1) {
                        alertView1.style=WCAlertViewStyleBlack;
                    }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                        if(buttonIndex==0){
                            
                        }
                    }cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                    
                }
            }
        }

}
-(void)callus{

    UIWebView*callWebview =[[UIWebView alloc] init];
  //  NSString *phone =[[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNum];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.store.telephone]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        switch (indexPath.row) {
            case 0:
                return 90;
                break;
            case 1:
                return 50;
                break;
            default:
                break;
        }
    
    }
    
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
