//
//  PublicClass.m
//  DBuyer
//
//  Created by lu gang on 13-11-21.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "PublicClass.h"
#import "WCAlertView.h"
#import "BtnDelegate.h"
#import "TLoginController.h"
@implementation PublicClass

@end

@implementation UIViewController (CategoryCon)
-(void)addTopBarWithTitle:(NSString *)title andBack:(BOOL)haveBack andExtend:(BOOL)hanveExtend{

    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 54)];
    topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"切片_06.png"]];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 68, 45);
    [left addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [left setBackgroundImage:[UIImage imageNamed:@"切片绿_向左.png"] forState:UIControlStateNormal];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(99, 12, 123, 21)];
    titleLabel.textColor = [UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1];
    titleLabel.text = title;
    [self.view addSubview:titleLabel];
    
    UIButton *extend = [UIButton buttonWithType:UIButtonTypeCustom];
    extend.frame = CGRectMake(267, 7, 43, 30);
    [extend addTarget:self action:@selector(toExtend) forControlEvents:UIControlEventTouchUpInside];
    [left setBackgroundImage:[UIImage imageNamed:@"切片绿_向左.png"] forState:UIControlStateNormal];
    [extend setTitle:@"分享" forState:UIControlStateNormal];
    
    if (haveBack) {
        
        [self.view addSubview:left];
    }
    if (hanveExtend) {
        
        [self.view addSubview:extend];
    }
}

//常规设置，如背景色等
-(void)customSet{
    
    self.view.backgroundColor=BACKCOLOR;
    self.navigationController.navigationBar.hidden = YES;
}

//注册‘取消数据请求’的通知
-(void)addLoadView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pleaseCancelLoad) name:@"pleaseCancelLoad" object:nil];
}

//全局AppDelegate
-(AppDelegate *)mainDelegate{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(BOOL)IsEmptyOfString:(NSString *)string{
    if(!(string==nil||string ==NULL) &&(![string isKindOfClass:[NSNull class]])){
        return NO;//字符串非空
    }
    return YES;
}

-(void)showError:(NSString *)errInfo{
    

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errInfo delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

-(BOOL)IsEmptyOfPrice:(NSString *)string{
    if(!(string==nil||string ==NULL) &&(![string isKindOfClass:[NSNull class]])) {
        return NO;
    }
    return YES;
}
- (NSString *)generateUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSMutableString *uuidString = (NSMutableString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    
    
    // release the UUID
    CFRelease(uuid);
    for(int i=0;i<[uuidString length];i++){
        char  a = [uuidString characterAtIndex:i];
        char  c = '-';
        if( a == c) {
            [uuidString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        
    }
    
    return uuidString;
}
-(NSString *)generateRemindTime{
    NSMutableDictionary *dict=[self generateTime];
    NSString *str=[NSString stringWithFormat:@"%d.%d 周五 21:00",[[dict objectForKey:@"month"] intValue],[[dict objectForKey:@"day"] intValue]];
    return str;
}
-(NSString *)generateCompareTime{
    NSMutableDictionary *dict=[self generateTime];
    NSString* timeStr = [NSString stringWithFormat:@"%d-%d-%d 21:00:00",[[dict objectForKey:@"year"] intValue],[[dict objectForKey:@"month"] intValue],[[dict objectForKey:@"day"] intValue]];//设置时间显示格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate* date1 = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
    return timeSp;
}
-(NSMutableDictionary *)generateTime{
    NSDate * date = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * comps;
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                       fromDate:date];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
                       fromDate:date];
    NSInteger hour = [comps hour];
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday];//星期几
    
    // 设置日期
    if(weekday!=6){
        if(weekday<=6){
            day=(6-weekday)+day;
            
            
        }
        else{
            day=day+6;
        }
    }
    if(month==1|month==3|month==5|month==7|month==8|month==10|month==12){
        if(day<=31){
            
        }
        else{
            day=day-31;
            if(month!=12){
                month=month+1;
            }
            else{
                month=1;
                year=year+1;
            }
            
        }
    }
    else if(month==2){
        if(year%4==0){
            if(day>29){
                day=day-29;
                month=month+1;
            }
            else{
                
            }
        }
        else{
            if(day>28){
                day=day-28;
                month=month+1;
            }
        }
        
        
    }else{
        if(day >30){
            day=day-30;
            month=month+1;
        }
        else{
            
        }
    }
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",year],@"year",[NSString stringWithFormat:@"%d",month],@"month",[NSString stringWithFormat:@"%d",day],@"day",[NSString stringWithFormat:@"%d",hour],@"hour",[NSString stringWithFormat:@"%d",week],@"week", nil];
    return dict;
}
-(void)getShoppingCarNumFromNet{
    NSString *url=[NSString stringWithFormat:@"%@interface/goodsCar/queryCarCount",serviceHost];
    HttpDownload *hd1=[[HttpDownload alloc]init];
    hd1.delegate=self;
    hd1.type=1989;
    hd1.method=@selector(downloadComplete:);
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    //[hd getResultData:dict baseUrl:[NSString stringWithFormat:planList,serviceHost]];
    [hd1 downloadFromUrlWithASI:url dict:dict];
}
-(void)isLogined{
    
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]||[[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] length]==0){
        [self showNotLoginAlertView];
    }
}
- (BOOL)isAlreadyLogined
{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]||[[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] length]==0){
        return NO;
    } else {
        return YES;
    }
}

- (void)showNotLoginAlertView
{
    [WCAlertView showAlertWithTitle:@"提示" message:@"还没有登录!" customizationBlock:^(WCAlertView * alertView1) {
        alertView1.style=WCAlertViewStyleBlack;
    }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
        if(buttonIndex==0){
            
        }
        if(buttonIndex==1){
            TLoginController *loginController = [[TLoginController alloc]initWithNavigationTitle:@"登录"];
            // loginController.delegate = self;
            UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:loginController]autorelease];
            [self.navigationController presentViewController:navi animated:YES completion:nil];
        }
    }cancelButtonTitle:@"我知道了" otherButtonTitles:@"立即登录",nil];
}

- (void)setNavigationBarWithContent:(NSString *)content WithLeftButton:(UIImage *)leftImage AndRightButton:(UIImage *)rightImage
{
    [self setNavigationBarWithContent:content WithLeftButton:leftImage AndRightButton:rightImage AndCenterButton:nil];
}

-(void)setNavigationBarWithContent:(NSString *)content WithLeftButton:(UIImage *)leftImage AndRightButton:(UIImage *)rightImage AndCenterButton:(UIImage *)centerImage
{
    self.view.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1];
    float startPoint;
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending){
        startPoint = 0.0f;
        //当前系统小于IOS7.0
    }
    else
    {
        startPoint = 20.0f;
        //当前系统大于ios7.0
        
    }
    UIImageView *navigationBackView=[[UIImageView alloc]init];
    navigationBackView.userInteractionEnabled=YES;
    navigationBackView.backgroundColor=[UIColor colorWithRed:0.0f green:97.0/255.0 blue:77.0/255.0 alpha:1];
    navigationBackView.frame=CGRectMake(0, 0, 320, 44+startPoint);
    [self.view addSubview:navigationBackView];
    
    if (centerImage == nil) {
        LXD *titleLabel=[[LXD alloc]initWithText:content font:16 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 33+4-20+startPoint, WindowWidth, 16) backColor:[UIColor clearColor] textColor:[UIColor whiteColor]];
        [navigationBackView addSubview:titleLabel];
    } else {
        UIButton *centerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.frame=CGRectMake(0, 33+4-20+startPoint, WindowWidth, 14);
        [centerButton setBackgroundImage:centerImage forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [navigationBackView addSubview:centerButton];
    }
    
    if(leftImage!=nil ){
        UIImageView * imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 65/2-20+startPoint, 20, 20)] autorelease];
        imageView.image = leftImage;
        [navigationBackView addSubview:imageView];
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 60, 44+startPoint);
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [navigationBackView addSubview:leftButton];
    }
    if(rightImage!=nil){
        UIImageView * imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(580/2, 65/2-20-3+startPoint, 23, 25)] autorelease];
        imageView.image = rightImage;
        [navigationBackView addSubview:imageView];
        
        UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame=CGRectMake(320-60, 0, 60, 44+startPoint);
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [navigationBackView addSubview:rightButton];        
    }
}
@end

@implementation NSString (IsEmptyJudgmen)

-(BOOL)IsEmptyOfString:(NSString *)string{
    if(!(string==nil||string ==NULL) &&(![string isKindOfClass:[NSNull class]]) && (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)){
        return NO;//字符串非空
    }
        return YES;
}
@end

@implementation UIButton (UIButtonCategory)

-(void)setImage:(NSString *)imageName{
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end

@implementation UILabel (UILabelCategory)

-(void)setTitle:(NSString *)title frame:(CGRect)rect{
    
    self.frame = rect;
    self.text = title;
    self.backgroundColor = [UIColor clearColor];
}

@end
