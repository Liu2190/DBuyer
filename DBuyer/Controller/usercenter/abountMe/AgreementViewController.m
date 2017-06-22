//
//  XieyiViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AgreementViewController.h"
#import "HttpDownload.h"
#import "TimeStamp.h"
#import "MD5.h"
#import "UIDevice+Resolutions.h"
#import "LXD.h"
#import "NavigationBarView.h"
#import "StartPoint.h"
@interface AgreementViewController () <NavigationBarViewDelegate>
{
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    
}

@end

@implementation AgreementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    [hd downloadFromUrl:[NSString stringWithFormat:@"%@interface/userHelpView/queryAfter?type=1",serviceHost ]];
    [mainDelegate beginLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(void)downloadFail
{
    [mainDelegate endLoad];
}
-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        [mainDelegate endLoad];
        if([[dict objectForKey:@"status"]intValue]==0)
        {
            NSMutableArray *array=[dict objectForKey:@"list"];
            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight-[StartPoint startPoint])];
            NSString *textString = nil;
            for(NSDictionary *thisDict in array)
            {
                textString = [thisDict objectForKey:@"content"];
            }
            textView.text = textString;
            [self.view addSubview:textView];
            textView.userInteractionEnabled = YES;
            textView.showsHorizontalScrollIndicator = YES;
            textView.editable = NO;
            textView.bounces = YES;
            textView.scrollEnabled = YES;
            textView.backgroundColor = [UIColor clearColor];
            textView.textColor = RIGHTCOLOR;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // navigationBar视图
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor=BACKCOLOR;
    NavigationBarView * navigationView = [NavigationBarView navigationBarView];
    [navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"]
                      rightImage:nil
                      titleImage:nil
                           title:@"注册协议"];
    navigationView.delegate = self;
    [self.view addSubview:navigationView];
    [self addLoadView];
    mainDelegate = [self mainDelegate];
	// Do any additional setup after loading the view.
}
#pragma mark navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
