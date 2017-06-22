//
//  TMapViewController.h
//  DBuyer
//
//  Created by dilei liu on 14-4-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TMapStoreView.h"
#import "WCAlertView.h"
#import "TActivityView.h"

@interface TMapViewController : TRootViewController<BMKMapViewDelegate,BMKSearchDelegate,
    BMKGeneralDelegate, UITableViewDataSource,UITableViewDelegate> {
        
        TMapStoreView *_mapStoreView;
        UITableView *_tableView;
        BMKMapView *_mapView;
        
        BMKCoordinateRegion _region;
        CLLocationCoordinate2D _mylocation2D;
        TActivityView *activityView;
        UIButton *button;
        
        BOOL allowPosition;
        BOOL isHadLocal;
}

@property (nonatomic,retain) NSMutableArray *visiableDatas;
@property (nonatomic,retain) NSMutableArray *allDatas;



@end
