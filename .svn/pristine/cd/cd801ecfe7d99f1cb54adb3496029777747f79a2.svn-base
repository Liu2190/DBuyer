//
//  MapRouteViewController.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "MapRouteViewController.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
//BOOL isRetina = FALSE;

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end
@implementation UIImage(InternalMethod)
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    CGSize rotatedSize = self.size;
//    if (isRetina) {
//        rotatedSize.width *= 2;
//        rotatedSize.height *= 2;
//    }
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

@implementation MapRouteViewController
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarWithContent:self.store.name WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    float startPoint;
    if([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]==NSOrderedAscending)
    {
        startPoint=44.0f;
        
    }
    else
    {
        startPoint=64.0f;
        
    }
    
   // [self.leveyTabBarController hidesTabBar:YES animated:YES];
    navigationBar=[NavigationBarView navigationBarView];
    carButton=[UIButton buttonWithType:UIButtonTypeCustom];
    carButton.frame=CGRectMake(0,WindowHeight-90/2, 105, 44);
    //carButton.alpha=0.8;
    [carButton setBackgroundImage:[UIImage imageNamed:@"daohang_car_png"] forState:UIControlStateNormal];
    [carButton setBackgroundImage:[UIImage imageNamed:@"daohang_car_png_s"] forState:UIControlStateSelected];
    carButton.selected=NO;
    [carButton addTarget:self action:@selector(onClickDriveSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *carLable=[[UILabel alloc]initWithFrame:CGRectMake(60,6,30, 30)];
    carLable.text=@"驾车";
    carLable.backgroundColor=[UIColor clearColor];
    carLable.textColor=[UIColor whiteColor];
    carLable.font=[UIFont systemFontOfSize:14];
    [carButton addSubview:carLable];
    [self.view addSubview:carButton];
    
    busButton=[UIButton buttonWithType:UIButtonTypeCustom];
    busButton.frame=CGRectMake(107.5,WindowHeight-44.5, 105, 44);
    [busButton setBackgroundImage:[UIImage imageNamed:@"daohang_bus_png"] forState:UIControlStateNormal];
    [busButton setBackgroundImage:[UIImage imageNamed:@"daohang_bus_png_s"] forState:UIControlStateSelected];
    busButton.selected=YES;
    [busButton addTarget:self action:@selector(onClickBusSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *busLable=[[UILabel alloc]initWithFrame:CGRectMake(60,6,30, 30)];
    busLable.text=@"公交";
    busLable.backgroundColor=[UIColor clearColor];
    busLable.textColor=[UIColor whiteColor];
    busLable.font=[UIFont systemFontOfSize:14];
    [busButton addSubview:busLable];
    [self.view addSubview:busButton];
    
    walkButton=[UIButton buttonWithType:UIButtonTypeCustom];
    walkButton.frame=CGRectMake(215,WindowHeight-44.5, 105, 44);
    [walkButton setBackgroundImage:[UIImage imageNamed:@"daohang_walk_png"] forState:UIControlStateNormal];
    [walkButton setBackgroundImage:[UIImage imageNamed:@"daohang_walk_png_s"] forState:UIControlStateSelected];
    walkButton.selected=NO;
    [walkButton addTarget:self action:@selector(onClickWalkSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *walkLable=[[UILabel alloc]initWithFrame:CGRectMake(60,6,30, 30)];
    walkLable.text=@"步行";
    walkLable.backgroundColor=[UIColor clearColor];
    walkLable.textColor=[UIColor whiteColor];
    walkLable.font=[UIFont systemFontOfSize:14];
    [walkButton addSubview:walkLable];
    [self.view addSubview:walkButton];

    isRetina=YES;
    //终点地址
    areaStr=self.store.axis;
    self.mapView.showsUserLocation = NO;
    //[mapView setZoomLevel:14];
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,60, 320,WindowHeight-105)];
    [self.mapView setShowsUserLocation:YES];//显示定位的蓝点儿
    _search = [[BMKSearch alloc]init];//search类，搜索的时候会用到
    [self.view addSubview:self.mapView];

    fromeText.text=self.store.address;
    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
    if ((fabs(screenSize.width - 640.0f) < 0.1)
        && (fabs(screenSize.height - 960.0f) < 0.1))
    {
        
    }
    
    pathArray=[[NSMutableArray array] retain];  //用来记录路线信息的，以后会用到
}

//导航栏的左边返回按钮
-(void)leftButtonClick:(UIButton *)button
{
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    self.mapView.delegate=nil;
    _search.delegate=nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[[UIDevice currentDevice] systemVersion]compare:@"7.0"]==NSOrderedAscending)
    {
        self.mapView.frame = CGRectMake(0,44, 320,self.view.frame.size.height-44-45);
        carButton.frame=CGRectMake(0,self.view.frame.size.height-90/2, 105, 44);
        busButton.frame=CGRectMake(107.5,self.view.frame.size.height-90/2, 105, 44);
        walkButton.frame=CGRectMake(215,self.view.frame.size.height-90/2, 105, 44);

    }
    else
    {
        self.mapView.frame = CGRectMake(0,60, 320,WindowHeight-105);
        carButton.frame=CGRectMake(0,WindowHeight-90/2, 105, 44);
        busButton.frame=CGRectMake(107.5,WindowHeight-90/2, 105, 44);
        walkButton.frame=CGRectMake(215,WindowHeight-90/2, 105, 44);
    }
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate=self;
   // isRetina=NO;
   
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
     self.mapView.delegate = nil; // 不用时，置nil
    _search.delegate=nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.mapView.delegate=nil;
    _search.delegate=nil;
}


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"] autorelease];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
			if (view == nil) {
				view = [[[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"] autorelease];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
        }
            break;
		default:
			break;
	}
	
	return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
    [self onClickBusSearch:busButton];

	return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    
	return nil;
}

//百度定位获取经纬度信息
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    localLatitude=userLocation.location.coordinate.latitude;//把获取的地理信息记录下来
    localLongitude=userLocation.location.coordinate.longitude;
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        for (CLPlacemark *placemark in place) {
            cityStr=placemark.thoroughfare;
            cityName=placemark.locality;
            break;
        }
    };
    _region.center.longitude = userLocation.location.coordinate.longitude;
    _region.center.latitude = userLocation.location.coordinate.latitude;
    _region.span.latitudeDelta = 0.05;
    _region.span.longitudeDelta = 0.05;

    if(isRetina==YES)
    {
        [self onClickBusSearch:busButton];
        isRetina=NO;
    }
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
}


//geocode第一个参数是fromeText，默认我写的是新中关，withCity是定位获得的城市，调用这个方法以后，结果会传给代理方法:
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error{
    startPt = (CLLocationCoordinate2D){0, 0};
    startPt = result.geoPt;//把坐标传给startPt保存起来
}
//这里百度地图api的结果都不是直接获得的，而是传给对应的代理方法。接下来的路线获取也一样

//实现公交和驾车路线搜索

//当textfield里面默认是新中关的时候，我的驾乘按钮代码如下:
-(void)onClickDriveSearch :(UIButton *)button
{
    button.selected=!button.selected;
    if(button.selected==YES)
    {
        busButton.selected=NO;
        walkButton.selected=NO;
    }
    carButton.selected=YES;
    
    
    //清除之前的路线和标记
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
    //清楚路线方案的提示信息
    [pathArray removeAllObjects];
    //如果是从当前位置为起始点
    //if (localJudge) {
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        startPt.latitude=localLatitude;
        startPt.longitude=localLongitude;
        start.pt = startPt;
        start.name = cityStr;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.name =areaStr;
   // self.store.address;
        BOOL flag1 = [_search drivingSearch:cityName startNode:start endCity:@"北京市" endNode:end];
        if (!flag1) {

        }
        [start release];
        //[end release];

   // }
       // else {
//        //如果从textfield获取起始点，不定位的话主要看这里
//        BOOL flag = [_search geocode:fromeText.text withCity:cityStr];//通过搜索textfield地名获得地名的经纬度，之前已经讲过了，并存储在变量startPt里
//        if (!flag) {
//            NSLog(@"search failed");
//        }
//        BMKPlanNode* start = [[BMKPlanNode alloc]init];
//        start.pt = startPt;//起始点坐标
//        start.name = fromeText.text;//起始点名字
//        BMKPlanNode* end = [[BMKPlanNode alloc]init];
//        end.name = @"三里屯";//结束点名字
//        BOOL flag1 = [_search drivingSearch:cityName startNode:start endCity:@"北京市" endNode:end];//这个就是驾车路线查询函数，利用了startPt存储的起始点坐标，会调用代理方法onGetDrivingRouteResult
//        if (!flag1) {
//            NSLog(@"search failed");
//        }
//        [start release];
//        [end release];
//    }
}
//通过geocode函数得到地名坐标，然后通过drivingSearch函数设定起始点和结束点，并调用代理方法来利用这个路线结果，下面就是代理方法
//驾车的代理方法
- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    if (error == BMKErrorOk) {
        BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        RouteAnnotation* item = [[RouteAnnotation alloc]init];
        item.coordinate = result.startNode.pt;
        item.title =@"起点";//名字起点
        item.type = 0;
        [self.mapView addAnnotation:item];
        [item release];
        int index = 0;
        int size = [plan.routes count];
        for (int i = 0; i < 1; i++) {
            BMKRoute* route = [plan.routes objectAtIndex:i];
            for (int j = 0; j < route.pointsCount; j++) {
                int len = [route getPointsNum:j];
                index += len;
            }
        }
        BMKMapPoint* points = new BMKMapPoint[index];
        index = 0;
        for (int i = 0; i < 1; i++) {
            BMKRoute* route = [plan.routes objectAtIndex:i];
            for (int j = 0; j < route.pointsCount; j++) {
                int len = [route getPointsNum:j];
                BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
                memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
                index += len;
            }
            size = route.steps.count;
            for (int j = 0; j < size; j++) {
                BMKStep* step = [route.steps objectAtIndex:j];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = step.pt;
                item.title = step.content;
                item.degree = step.degree * 30;
                item.type = 4;
                [self.mapView addAnnotation:item];
                [item release];
                //把每一个步骤的提示信息存储到pathArray里，以后可以用这个内容实现文字导航
                [pathArray addObject:step.content];
            }
            
        }
        
        item = [[RouteAnnotation alloc]init];
        item.coordinate = result.endNode.pt;
        item.type = 1;
        item.title =@"终点";//终点名字
        [self.mapView addAnnotation:item];
        [item release];
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
        [self.mapView addOverlay:polyLine];
        delete []points;
    }
    
}
//这样驾车的路线就应该可以了，编译运行可以看到路线图，同时可以从打印的数组信息得到提示信息，内容就是地图上点击节点弹出的内容

//公交按钮的代码：
-(void)onClickBusSearch:(UIButton *)button
{
    button.selected=!button.selected;

    if(button.selected==YES)
    {
        carButton.selected=NO;
        walkButton.selected=NO;
    }
    busButton.selected=YES;
    //清空路线
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
    
    [pathArray removeAllObjects];
   // if (localJudge) {
        //开始搜索路线，transitSearch调用onGetTransitRouteResult
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        startPt.latitude=localLatitude;
        startPt.longitude=localLongitude;
        start.pt = startPt;
        start.name = cityStr;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        end.name = areaStr;
        BOOL flag1 = [_search transitSearch:@"北京市" startNode:start endNode:end];
        if (!flag1) {

        }
        [start release];
        [end release];
   // }
//    else{
//        //由textfield内容搜索，调用onGetAddrResult函数，得到目标点坐标startPt
//        BOOL flag = [_search geocode:fromeText.text withCity:cityStr];
//        if (!flag) {
//            NSLog(@"search failed");
//        }
//        //开始搜索路线，transitSearch调用onGetTransitRouteResult
//        BMKPlanNode* start = [[BMKPlanNode alloc]init];
//        start.pt = startPt;
//        start.name = fromeText.text;
//        BMKPlanNode* end = [[BMKPlanNode alloc]init];
//        end.name = @"三里屯";
//        BOOL flag1 = [_search transitSearch:cityName startNode:start endNode:end];//公交路线对应的代理方法是onGetTransitRouteResult
//        if (!flag1) {
//            NSLog(@"search failed");
//        }
//        [start release];
//        [end release];
//        
//    }
}

//公交路线代理方法,这里和驾车路线不同的是，获取的提示信息不在一起，分上车信息和下车信息：
- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error
{

    if (error == BMKErrorOk) {
        BMKTransitRoutePlan* plan = (BMKTransitRoutePlan*)[result.plans objectAtIndex:0];
        
        RouteAnnotation* item = [[RouteAnnotation alloc]init];
        item.coordinate = plan.startPt;
        item.title = @"起点";
        item.type = 0;
        [self.mapView addAnnotation:item];
        [item release];
        item = [[RouteAnnotation alloc]init];
        item.coordinate = plan.endPt;
        item.type = 1;
        item.title = @"终点";
        [self.mapView addAnnotation:item];
        [item release];
        
        int size = [plan.lines count];
        int index = 0;
        for (int i = 0; i < size; i++) {
            BMKRoute* route = [plan.routes objectAtIndex:i];
            for (int j = 0; j < route.pointsCount; j++) {
                int len = [route getPointsNum:j];
                index += len;
            }
            BMKLine* line = [plan.lines objectAtIndex:i];
            index += line.pointsCount;
            if (i == size - 1) {
                i++;
                route = [plan.routes objectAtIndex:i];
                for (int j = 0; j < route.pointsCount; j++) {
                    int len = [route getPointsNum:j];
                    index += len;
                }
                break;
            }
        }
        
        BMKMapPoint* points = new BMKMapPoint[index];
        index = 0;
        
        for (int i = 0; i < size; i++) {
            BMKRoute* route = [plan.routes objectAtIndex:i];
            for (int j = 0; j < route.pointsCount; j++) {
                int len = [route getPointsNum:j];
                BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
                memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
                index += len;
            }
            BMKLine* line = [plan.lines objectAtIndex:i];
            memcpy(points + index, line.points, line.pointsCount * sizeof(BMKMapPoint));
            index += line.pointsCount;
            
            item = [[RouteAnnotation alloc]init];
            item.coordinate = line.getOnStopPoiInfo.pt;
            item.title = line.tip;
            [pathArray addObject:line.tip];
            if (line.type == 0) {
                item.type = 2;
            } else {
                item.type = 3;
            }
            
            [self.mapView addAnnotation:item];
            [item release];
            route = [plan.routes objectAtIndex:i+1];
            item = [[RouteAnnotation alloc]init];
            item.coordinate = line.getOffStopPoiInfo.pt;
            item.title = route.tip;
            [pathArray addObject:item.title];
            if (line.type == 0) {
                item.type = 2;
            } else {
                item.type = 3;
            }
            [self.mapView addAnnotation:item];
            [item release];
            if (i == size - 1) {
                i++;
                route = [plan.routes objectAtIndex:i];
                for (int j = 0; j < route.pointsCount; j++) {
                    int len = [route getPointsNum:j];
                    BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
                    memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
                    index += len;
                }
                break;
            }
        }
        
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
        [self.mapView addOverlay:polyLine];
        delete []points;
    }
}
//步行方法
-(void)onClickWalkSearch :(UIButton *)button
{
    button.selected=!button.selected;
    if(button.selected==YES)
    {
        carButton.selected=NO;
        busButton.selected=NO;
    }
    walkButton.selected=YES;
	BMKPlanNode* start = [[[BMKPlanNode alloc]init] autorelease];
    startPt.latitude=localLatitude;
    startPt.longitude=localLongitude;
    start.pt = startPt;
    start.name=cityStr;
	//start.name =[NSString stringWithFormat:@"%@%@",];;
	BMKPlanNode* end = [[[BMKPlanNode alloc]init] autorelease];
	end.name =areaStr;
	BOOL flag = [_search walkingSearch:@"北京市" startNode:start endCity:@"北京市" endNode:end];
	if (flag) {

	}
    else{

    }
	
}
//步行代理
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
	[self.mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:self.mapView.overlays];
	[self.mapView removeOverlays:array];
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[self.mapView addAnnotation:item];
		[item release];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[self.mapView addAnnotation:item];
				[item release];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[self.mapView addAnnotation:item];
		[item release];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[self.mapView addOverlay:polyLine];
		delete []points;
        [self.mapView setCenterCoordinate:result.startNode.pt animated:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.mapView = nil;
    _search=nil;

    [super dealloc];
}
@end
