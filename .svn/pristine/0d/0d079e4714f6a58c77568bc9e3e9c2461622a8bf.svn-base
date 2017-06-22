//
//  BMKMapView+addAnnotation.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BMKMapView+addAnnotation.h"
#import "BMKPointAnnotation.h"
#import "Store.h"
@implementation BMKMapView (addAnnotation)

- (void)addAnnotationWithStore:(Store *)store
{
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];//添加图标
    CGFloat latitude = store.YAxis;
    CGFloat longitude = store.XAxis;
    NSString * title = store.name;
    NSString *subTitle=store.address;
    CLLocationCoordinate2D nearStore;
    nearStore.latitude = latitude;
    nearStore.longitude = longitude;
    annotation.coordinate = nearStore;
    annotation.title = title;
    annotation.subtitle=subTitle;
    [self addAnnotation:annotation];
}

@end
