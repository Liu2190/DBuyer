//
//  BMKMapView+addAnnotation.h
//  DBuyer
//
//  Created by HeRongxin on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BMKMapView.h"

@class Store;
@interface BMKMapView (addAnnotation)
- (void)addAnnotationWithStore:(Store *)store;
@end
