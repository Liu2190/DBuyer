//
//  MapStorDetailViewController.h
//  DBuyer
//
//  Created by HeRongxin on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <CoreLocation/CoreLocation.h>
//#import "MapModelData.h"
#import "Store.h"
#import "NavigationBarView.h"
@interface MapStorDetailViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate,BMKGeneralDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel *countLable;
    UILabel *addressLable;
    UILabel *areaLable;
    UILabel *meterLable;
    UIImageView *dagouImg;
    NavigationBarView *navigationBar;

}
@property (nonatomic, assign) BMKCoordinateRegion region;

@property (nonatomic, retain) BMKMapManager * mapManager;
@property (nonatomic, retain) BMKMapView * mapView;
@property (nonatomic, retain) CLLocationManager * locManager;
@property (nonatomic, retain) UITableView * storeDetailTableView;

@property (nonatomic,retain) Store *store;
@end
