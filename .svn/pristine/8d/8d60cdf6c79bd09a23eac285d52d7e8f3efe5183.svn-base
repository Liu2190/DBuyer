//
//  ThirdViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-9-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ThirdViewController : UIViewController<ZBarReaderViewDelegate, UIImagePickerControllerDelegate,UINavigationBarDelegate>{
    UILabel *scanResultLabel;
    UIView *resultView;
    UIImageView * scanBackgroundView;
    ZBarReaderView *thisReaderView;
    ZBarCameraSimulator *cameraSim;
    int ZBarType;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    UIImageView *firstImage;
}

@end
