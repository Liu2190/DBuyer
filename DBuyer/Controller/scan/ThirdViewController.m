//
//  ThirdViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//  2013年12月29日 李伟重新渲染页面UI

#import "ThirdViewController.h"
#import "LeveyTabBarController.h"
#import "ScanResultNilViewController.h"
#import "LXD.h"
#import "ScanWebViewController.h"
#import "ScanSearchViewController.h"
#import "StartPoint.h"
#import "GuideOperationView.h"
@interface ThirdViewController ()
@property(nonatomic,assign)GuideOperationView *guideView;
@end

@implementation ThirdViewController
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
    [thisReaderView start];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ThirdViewController"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"ThirdViewController"];
        [self firstOpenScanView];
    }
    else
    {
        [self loadScanView];
    }
}
-(void)guideOperationDidClick
{
    [self loadScanView];
}
-(void)firstOpenScanView
{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"scanIntroduct_Image.png", nil];
    self.guideView = [[GuideOperationView alloc]initGuideOperationViewWith:array];
    self.guideView.delegate = self;
    [[self mainDelegate].window addSubview:self.guideView];
}
-(void)loadScanView
{
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
    self.view.backgroundColor=[UIColor clearColor];
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"扫一扫" WithLeftButton:nil AndRightButton:nil];
    thisReaderView=[[ZBarReaderView alloc]init];
    thisReaderView.readerDelegate=self;
    [self setOverlayPickerView:thisReaderView];
    thisReaderView.torchMode=0;//关闪光灯
    [self.view addSubview:thisReaderView];
    thisReaderView.frame=CGRectMake((320-241)/2,(self.view.bounds.size.height-478/2)/2, 482/2, 478/2);
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = thisReaderView;
    }
    thisReaderView.scanCrop=CGRectMake(0, 0, 1, 1);
    [thisReaderView start];
    resultView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self.view addSubview:resultView];
    resultView.hidden=YES;
    scanResultLabel=[[UILabel alloc]init];
    mainDelegate = [self mainDelegate];
    
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
-(void)setOverlayPickerView:(ZBarReaderView *)reader{
   
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 482/2, 478/2)];
    line.image=[UIImage imageNamed:@"ScanSearch_border"];
    [reader addSubview:line];
    scanBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ScanSearch_line"]];
    scanBackgroundView.frame=CGRectMake(0, -237/2, 482/2, 237/2);
    [line addSubview:scanBackgroundView];
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}
static int i;
-(void)runTimePage{
    
    if (i<280) {
        scanBackgroundView.frame=CGRectMake(0,2+1*i - 237/2, 482/2, 237/2);
        i++;
    }
    else{
        scanBackgroundView.frame=CGRectMake(0, -237/2, 482/2, 237/2);
        i=0;
    }
    
}

- (void)readerView: (ZBarReaderView*) readerView
    didReadSymbols: (ZBarSymbolSet*) symbols
         fromImage: (UIImage*) image
{
    ZBarSymbol *symbol=nil;
    for(symbol in symbols){
        break;
    }
    NSString *str=[NSString stringWithFormat:@"%@",symbol.data];
    ZBarType=symbol.type;
    scanResultLabel.text=str;
    if(str && [str length]!=0){
        [thisReaderView stop];
        //[self resultView];
        [self resultData];
    }
}

-(void)viewDidDisappear:(BOOL)animated{

    [thisReaderView stop];
}

-(void)resultData
{
    if(ZBarType==5 || ZBarType == 8 || ZBarType == 9 || ZBarType == 12 || ZBarType == 13 || ZBarType == 8){
        [mainDelegate beginLoad];
        //商品列表
        HttpDownload *hd=[[HttpDownload alloc]init];
        hd.delegate=self;
        thisDownLoad=hd;
        hd.type=1;
        hd.method=@selector(downloadComplete:);
        hd.failMethod = @selector(downloadFail);
        [hd downloadFromUrl:[NSString stringWithFormat:@"%@interface/commodity/queryCommodityByBarCode?barCode=%@",serviceHost,scanResultLabel.text]];
        
    }else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                             message:@"请扫描有效的商品条码。"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
        [alertView show];
        [thisReaderView start];
    }
    
//    else if(ZBarType==64){
//        
//        
//    }
//        /*
//        NSError *error;
//        NSRegularExpression *regx=[NSRegularExpression regularExpressionWithPattern:@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?" options:0 error:&error];
//        if(regx != nil){
//            NSArray *array=[regx matchesInString:scanResultLabel.text options:0 range:NSMakeRange(0, [scanResultLabel.text length])];
//            if([array count]!=0){
//                for(NSTextCheckingResult *match in array){
//                    NSRange firstHalfRange=[match rangeAtIndex:0];
//                    NSString *result1=[scanResultLabel.text substringWithRange:firstHalfRange];
//                    ScanWebViewController *sc=[[ScanWebViewController alloc]init];
//                    sc.searchText=result1;
//                    [self.navigationController pushViewController:sc animated:YES];
//                }
//            }else{
//                ScanWebViewController *sc=[[ScanWebViewController alloc]init];
//                sc.searchText=scanResultLabel.text;
//                [self.navigationController pushViewController:sc animated:YES];
//            }
//        }
//        //二维码
//        //webview;
//    } */
//         
//         else {
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                             message:@"请扫描有效的商品条码。"
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"确定"
//                                                   otherButtonTitles:nil, nil];
//        [alertView show];
//        [thisReaderView start];
//    }
// 
    
}

#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
#pragma mark - 下载数据
-(void)downloadFail {
    [mainDelegate endLoad];
}

#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd{
    [mainDelegate endLoad];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        if(hd.type==1){
            if([[dict objectForKey:@"status"] intValue]==0){
                //有数据
                ScanSearchViewController *sc=[[ScanSearchViewController alloc]init];
                sc.searchArray=[dict objectForKey:@"goods_list"];
                
                [self.navigationController pushViewController:sc animated:YES];
            }
            else if ([[dict objectForKey:@"status"] intValue]==1){
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"没有此商品"
                                                                     message:@"请您继续扫描其他的商品。"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil, nil];
                [alertView show];
                [thisReaderView start];
/*
                ScanResultNilViewController *smk=[[ScanResultNilViewController alloc]init];
                smk.searchText=scanResultLabel.text;
                [self.navigationController pushViewController:smk animated:YES];
 */
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
