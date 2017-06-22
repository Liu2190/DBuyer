//
//  TMapViewController.m
//  DBuyer
//
//  Created by dilei liu on 14-4-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TMapViewController.h"
#import "UIView+Shadow.h"
#import "UIButton+Extensions.h"
#import "TServerFactory.h"
#import "TStoreMapServer.h"
#import "TMapStore.h"
#import "TUtilities.h"
#import "MapStorDetailViewController.h"

#define storeView_h     220
#define toolbar_h       45

@implementation TMapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    allowPosition = [CLLocationManager locationServicesEnabled]; // 是否定位
    isHadLocal = NO;
    
    self.visiableDatas = [[NSMutableArray alloc]init];
    self.allDatas = [[NSMutableArray alloc]init];
    
    CGRect rect = CGRectMake(0,0, self.contentView.frame.size.width,self.contentView.frame.size.height);
    _mapView = [[BMKMapView alloc] initWithFrame:rect];
    [_mapView setShowsUserLocation:YES];
    _mapView.delegate = self;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    [self.contentView addSubview:_mapView];
    
    
    rect = CGRectMake(0, self.contentView.frame.size.height, self.contentView.frame.size.width, storeView_h);
    _mapStoreView = [[TMapStoreView alloc]initWithFrame:rect];
    [_mapStoreView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_mapStoreView];
    
    rect = CGRectMake(0, toolbar_h, _mapStoreView.frame.size.width, _mapStoreView.frame.size.height-toolbar_h);
    _tableView = [[UITableView alloc]initWithFrame:rect];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    activityView = [[TActivityView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height)];
    [_tableView addSubview:activityView];
    [activityView startAnimation];
    [_mapStoreView addSubview:_tableView];
    
    rect = CGRectMake(0, 0, _mapStoreView.frame.size.width, toolbar_h);
    UIView *toolbar = [[UIView alloc]initWithFrame:rect];
    [toolbar setBackgroundColor:[UIColor whiteColor]];
    [toolbar makeInsetShadowWithRadius:0.3f Color:[UIColor grayColor] Directions:[NSArray arrayWithObjects:@"top",@"bottom", nil]];
    [_mapStoreView addSubview:toolbar];
    
    UILabel *countLable = [[UILabel alloc]init];
    countLable.backgroundColor=[UIColor clearColor];
    countLable.text=@"您的身边有5家华联超市";
    countLable.font=[UIFont systemFontOfSize:14];
    countLable.textAlignment=NSTextAlignmentCenter;
    countLable.textColor=[UIColor blackColor];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [countLable.text sizeWithFont:countLable.font constrainedToSize:maximumLabelSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    [countLable setFrame:CGRectMake(80, (toolbar.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    [toolbar addSubview:countLable];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 30, 30)];
    image.backgroundColor=[UIColor clearColor];
    image.image=[UIImage imageNamed:@"MapGlass.png"];
    [toolbar addSubview:image];
    
    float btn_w = 30;
    float btn_h = 20;
    rect = CGRectMake(toolbar.frame.size.width-btn_w-20, (toolbar.frame.size.height-btn_h)/2, btn_w, btn_h);
    button = [[UIButton alloc]initWithFrame:rect];
    [button setImage:[UIImage imageNamed:@"MapStore_keyboard"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"MapStore_keyboard"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(doTableVisableAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -30)];
    button.tag = 1000;
    [toolbar addSubview:button];
    
    [[TServerFactory getServerInstance:@"TStoreMapServer"]doGetAddress2Map:^(NSArray *datas) {
        for (TMapStore *mapStore in datas){
            [_allDatas addObject:mapStore];
        }
    } failureCallback:^(NSString *resp) {
        [activityView stopAnimation];
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.5];
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    [super viewWillAppear:animated];
    [button setSelected:NO];
    [self doTableVisableAction:button];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}


- (void)doTableVisableAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    [UIView animateWithDuration:.5 animations:^{
        [btn setSelected:!btn.isSelected];
        
        CGRect frame =_mapStoreView.frame;
        if (!btn.isSelected) { // 收缩
            frame.origin.y = _mapView.frame.size.height - toolbar_h;
            
        } else { // 扩张
            frame.origin.y = _mapView.frame.size.height - storeView_h;
        }
        
        _mapStoreView.frame = frame;
    }];
}

/**
 * 通过用户定位数据来做排序
 */
- (void)updateArrayElement2Sort {
    for (TMapStore *mapStore in _allDatas) { // 计算距离
        [self distanceFromStore:mapStore];
    }
    
    for (int i=0; i<_allDatas.count; i++) { // 根据距离排序
        for (int j=i+1; j<_allDatas.count; j++) {
            CGFloat f1 = ((TMapStore *)(_allDatas[i])).distanceFrom;
            CGFloat f2 = ((TMapStore *)(_allDatas[j])).distanceFrom;
            
            if(f1 > f2) {
                [_allDatas exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
}

/**
 * 计算各Annotation与用户位置的距离
 */
- (void)distanceFromStore:(TMapStore *)mapStore {
    CLLocationCoordinate2D storelocation2D = CLLocationCoordinate2DMake(mapStore.yaxis,mapStore.xaxis);
    
    BMKMapPoint mylocation = BMKMapPointForCoordinate(_mylocation2D);
    BMKMapPoint storelocation = BMKMapPointForCoordinate(storelocation2D);
    
    CLLocationDistance meter = BMKMetersBetweenMapPoints( mylocation, storelocation);
    mapStore.distanceFrom = meter;
}


- (void)addAnnotation:(BOOL)isPosition {
    if (_allDatas.count == 0) return;
    [_visiableDatas removeAllObjects];
    
    if (isPosition) {
        float maxNum = 5;
        if (_allDatas.count <= 5)maxNum = _allDatas.count;
        
        NSRange fiveRange = NSMakeRange(0, maxNum);
        [_visiableDatas addObjectsFromArray:[_allDatas subarrayWithRange:fiveRange]];
        
        [_mapView removeAnnotations:_mapView.annotations];
        for (TMapStore *mapStore in _visiableDatas){
            [self addAnnotationWithMapStore:mapStore];
        }
        
        return;
    }
        
    for (int i = 0; i < _allDatas.count; i++) {
        for (TMapStore *mapStore in _allDatas) {
            [_visiableDatas addObject:mapStore];
            [self addAnnotationWithMapStore:mapStore];
        }
    }
}

- (void)addAnnotationWithMapStore:(TMapStore*)mapStore {
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];//添加图标
    CGFloat latitude = mapStore.yaxis;
    CGFloat longitude = mapStore.xaxis;
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


- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [activityView stopAnimation];
    allowPosition = NO;
    [self updateArrayElement2Sort]; // 计算距离并排序
    [self addAnnotation:allowPosition];
    [_tableView reloadData];
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    static NSString *identifier = @"Annotation";
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView == nil) {
        annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"MapIcon.png"];
        annotationView.canShowCallout = YES;
    }
    
    return annotationView;
}

//更新用户的当前位置
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    _region.center.longitude = userLocation.location.coordinate.longitude;
    _region.center.latitude = userLocation.location.coordinate.latitude;
    _mylocation2D.latitude = userLocation.location.coordinate.latitude;
    _mylocation2D.longitude = userLocation.location.coordinate.longitude;
    _region.span.latitudeDelta = 0.05;
    _region.span.longitudeDelta = 0.05;
    
    if (!isHadLocal) {
        isHadLocal = YES;
        [activityView stopAnimation];
        [self updateArrayElement2Sort]; // 计算距离并排序
        // 添加定位Annotation{如果YES则排前五位,否则全部显示}
        [self addAnnotation:allowPosition];
        [_tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _visiableDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndefiter=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiter];
    
    if(cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiter];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        UILabel *munite=[[UILabel alloc]initWithFrame:CGRectMake(220, 10, 120, 20)];
        munite.backgroundColor=[UIColor clearColor];
        munite.textColor=[UIColor blackColor];
        munite.tag=140;
        munite.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:munite];
    }
    
    TMapStore *mapStore = [_visiableDatas objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"北京%@超市",mapStore.name];
    cell.contentView.backgroundColor=[UIColor colorWithRed:0.165 green:0.584 blue:0.365 alpha:(_visiableDatas.count-indexPath.row)/(float)_visiableDatas.count];
    
    UILabel *muniteLable=(UILabel *)[cell.contentView viewWithTag:140];
    if (allowPosition) {
        muniteLable.text = [NSString stringWithFormat:@"%.2fKm",mapStore.distanceFrom/1000];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TMapStore *mapStore = [_visiableDatas objectAtIndex:indexPath.row];
    Store *store = [[Store alloc]init];
    store.name = mapStore.name;
    store.address = mapStore.address;
    store.telephone = mapStore.telephone;
    store.areaName = mapStore.cityName;
    store.YAxis = mapStore.xaxis;
    store.XAxis = mapStore.yaxis;
    store.areaId = mapStore.areaId;
    store.storeSort = mapStore.storeSort;
    store.meter = mapStore.distanceFrom;
    store.axis = mapStore.axis;
    
    MapStorDetailViewController *MapStoreVC = [[[MapStorDetailViewController alloc] init] autorelease];
    MapStoreVC.store = store;
    [self.navigationController pushViewController:MapStoreVC animated:YES];
}



@end
