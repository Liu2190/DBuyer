//
//  MapRouteViewController.h
//  DBuyer
//
//  Created by HeRongxin on 14-1-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "Store.h"
#import "NavigationBarView.h"
@interface MapRouteViewController : UIViewController<BMKSearchDelegate,BMKMapViewDelegate>
{
    BMKSearch* _search;//搜索要用到的
    
    
    IBOutlet UITextField* fromeText;
    
    NSString  *cityStr;//街道名
    NSString *subStr;//子街道名
    
    NSString *cityName;
    
    CLLocationCoordinate2D startPt;
    
    float localLatitude;
    
    float localLongitude;
    
    BOOL localJudge;
    
    NSMutableArray *pathArray;
    BOOL isRetina;
    
    NSString *areaStr;//商店所在的街道名
    NSString *walkStr;//步行的街道名
    NSMutableArray *walkStartStrArray;
    NSString *walkStartStr;//步行的开始地址
    UIButton *carButton;
    UIButton *busButton;
    UIButton *walkButton;
    NavigationBarView *navigationBar;

    
}

@property (nonatomic,retain) Store *store;
@property (nonatomic, assign) BMKCoordinateRegion region;
@property (nonatomic,retain) BMKMapView* mapView;//地图视图


@end
