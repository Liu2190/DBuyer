//
//  EasyWebViewViewController.h
//
//  Created by lugang on 8/26/13.
//  Copyright (c) 2013 lugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyWebViewViewController : UIViewController<UIWebViewDelegate>{
    UIActivityIndicatorView * activityIndicatorView;
}
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *buyUrl;
@property (retain, nonatomic) NSString *shareString;

@end
