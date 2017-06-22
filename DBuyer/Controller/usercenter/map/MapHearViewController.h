//
//  MapHearViewController.h
//  DBuyer
//
//  Created by HeRongxin on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <CoreLocation/CoreLocation.h>
#import "Store.h"
@interface MapHearViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate,BMKGeneralDelegate,BMKSearchDelegate>

@property (nonatomic, assign) BMKCoordinateRegion region;

@property (nonatomic, retain) BMKMapManager * mapManager;
@property (nonatomic, retain) BMKMapView * mapView;
@property (nonatomic, retain) CLLocationManager * locManager;
@property (nonatomic, retain) UITableView * storeDetailTableView;

@property (nonatomic,retain) Store *store;
@end
