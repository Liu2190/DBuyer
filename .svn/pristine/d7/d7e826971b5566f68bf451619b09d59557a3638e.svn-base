//
//  MapHearViewController.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "MapHearViewController.h"
#import "BMKMapView.h"
#import "BMKMapView+addAnnotation.h"
#import "Store.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface MapHearViewController ()
@end

@implementation MapHearViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarWithContent:@"身边华联" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    float startPoint;
    if([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]==NSOrderedAscending)
    {
        startPoint=44.0f;
    }
    else
    {
        startPoint=64.0f;
    }
    [self.leveyTabBarController hidesTabBar:YES animated:YES];

    [self initMapView];
    
}
//导航栏的左边返回按钮
-(void)leftButtonClick:(UIButton *)button
{
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    [self.mapView addAnnotationWithStore:self.store];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.mapView.delegate=nil;
}


//初始化百度地图
-(void)initMapView
{
    self.mapView.showsUserLocation=NO;
    self.mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, 320, 550)];
    
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate=self;
    [self.mapView setZoomLevel:12];
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    [self.view addSubview:self.mapView];
    //self.mapView.showsUserLocation=NO;
}


- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    
    //BMKCoordinateRegion region;
    _region.center.longitude = userLocation.location.coordinate.longitude;
    
    _region.center.latitude = userLocation.location.coordinate.latitude;
    
    _region.span.latitudeDelta =0.5;
    
    _region.span.longitudeDelta =0.5;
    
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    static NSString *identifier = @"Annotation";
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"MapIcon"];
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
    }
    return annotationView;
}

//定位失败后，会调用此函数

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error

{
    if (error != nil) {
        
    }
    else {
    }
}

- (void)dealloc
{
    self.mapManager = nil;
    self.mapView = nil;
    self.locManager = nil;
    
    [super dealloc];
}



@end
