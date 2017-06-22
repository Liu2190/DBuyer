//
//  ShbjViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "EditReceivingViewController.h"
#import "DBManager.h"

#define CHECKISNULL_TAG 1025        // 检测是否为空
#define DELETEALERT_TAG 1021        // 删除AlertView

@interface EditReceivingViewController ()
@end

@implementation EditReceivingViewController
{
    UIImageView     *defaultImageView;
    UIButton        *_setDefaultBtn;
    UITextView      * detailAddressView;
    UIView          *jieguo;
    UIPickerView    * pickerView;
    NSMutableArray  * areaList;
    NSInteger       editType;               //
    NSString        * tempStr;
    AppDelegate     *mainDelegate;
    HttpDownload    *thisDownLoad;
    UIImageView     *_imageView;            //右侧按钮视图
    BOOL            isEdit;                 //是否为编辑状态
    
    id _target;                             // 控制器
    SEL _action;                            // 回调方法
    
    NSString *cityNmae;                     //地区
    UIView *pickerHeaderView;               //pickerview头视图
    
    int flag;             //定义标示
}

- (void)setDistrictButtonAction:(id)sender {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 是否为编辑状态
        isEdit = NO;
    }
    return self;
}

/**
 *  回调方法
 *
 *  @param target 控制器
 *  @param action 方法
 */
- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tempStr = [[NSString alloc]init];
    areaList = [[DBManager sharedDatabase] selectAreaListFromAreaId];
        //当前系统大于ios7.0
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    flag=0;

    // 设置默认按钮
    [self xiangqing];
    
    jieguo=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self setNavigationBarWithContent:@"地址管理" WithLeftButton:[UIImage imageNamed:@"global_back_button"] rightButton:[UIImage imageNamed:@"edit_button"]];
    
    // 初始化相关处理
    [self loadViewHandle];
}

-(void)setNavigationBarWithContent:(NSString *)content WithLeftButton:(UIImage *)leftImage rightButton:(UIImage *)rightImage
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
        _imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(580/2, 65/2-20-3+startPoint, 25, 25)] autorelease];
        _imageView.image = rightImage;
        [navigationBackView addSubview:_imageView];
        
        UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame=CGRectMake(320-60, 0, 60, 44+startPoint);
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [navigationBackView addSubview:rightButton];
    }
    
}

#pragma mark - 视图加载判断是否为默认地址
-(void)loadViewHandle{
    if (self.address.isDefault == 1) {
        self.setDefaultButton.userInteractionEnabled = NO;
        [self.setDefaultButton setTitle:@"（默认）" forState:UIControlStateNormal];
    } else {
        [self.setDefaultButton setTitle:@"设为默认地址" forState:UIControlStateNormal];
    }
    // 关闭用户交互
    [self setUserInteractionEnabled:NO];
    
    // 设置地址数据
    [self setMyAddress:_address];
    
    // 添加手势
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickFindAreaId:)];
    self.setDistrictLable.tag=882;
    [self.setDistrictLable addGestureRecognizer:tap2];
}

#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    if (!isEdit) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshAddressList)]) {
            [self.delegate refreshAddressList]; // 刷新数据
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView * deleteAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的信息尚未保存是否放弃此次编辑?" delegate:self cancelButtonTitle:@"不确定" otherButtonTitles:@"确定", nil];
        deleteAlert.tag = CHECKISNULL_TAG;
        [deleteAlert show];
    }
}


#pragma mark 网络请求失败
-(void)downloadFail{
    [mainDelegate endLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}

#pragma mark 设置返回按钮
-(void)rightButtonClick:(UIButton  *)button{
    if (!isEdit) {
        // 打开用户交互
        [self setUserInteractionEnabled:YES];
        isEdit = !isEdit;
        _imageView.image = [UIImage imageNamed:@"global_right_button"];
        [self resignFirstResponderOfAll];
        
       //
    } else {
        if((self.contactsTel.text == nil)||[self.contactsTel.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"电话不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if (![self checkTel:self.contactsTel.text]) {
            return;
        }
        if((self.consigneeTextField.text == nil)||[self.consigneeTextField.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"姓名不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if((self.addressContent.text == nil)||[self.addressContent.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"地址不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        isEdit = !isEdit;
        [self setUserInteractionEnabled:NO];
        _imageView.image = [UIImage imageNamed:@"edit_button"];
        //发送编辑地址API
        [self editAddress];
        pickerView.hidden=YES;
        pickerHeaderView.hidden=YES;
    }
}
#pragma mark - 设置默认地址Button
- (IBAction)setDefaultButtonAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    [btn setTitle:@"(默认)" forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    //发送设定默认地址的api
    [self setDefaultAddress];
}

#pragma mark - 设置收货区域按钮
- (IBAction)setDistrictLableAction:(id)sender {
}


#pragma mark - 删除按钮事件(此页面无用)
- (IBAction)deleteButtonAction:(id)sender
{
    UIAlertView * deleteAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否删除地址?" delegate:self cancelButtonTitle:@"不删除" otherButtonTitles:@"删除", nil];
    [deleteAlert show];
}
#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if(buttonIndex == 1){
        if (alertView.tag != CHECKISNULL_TAG) {
            [self deleteAddress];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void) deleteAddress
{
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:self.address.addressId forKey:@"addreId"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kDetelAddressList,serviceHost]];
    hd.type =10109;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    [[self mainDelegate] beginLoad];
}

//00000000000

#pragma mark -
-(void)buttonC:(UIButton *)sender{
    switch (sender.tag) {
        case 612:
        {//确定
            //发送修改地址API
            [self editAddress];
            //页面跳转回去
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 611:
        {//取消
            //去掉jieguo浮层
            [self setUserInteractionEnabled:YES];
        }
            break;
        default:
            break;
    }
}

-(void)xiangqing{
    //在键盘上添加按钮
        UIView * keyboardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        keyboardView.userInteractionEnabled=YES;
        keyboardView.tag=110;
        keyboardView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];

       LXD *wanchenglabel=[[LXD alloc]initWithText:@"完成" font:15 textAlight:NSTextAlignmentCenter frame:CGRectMake(280,0, 30, 24) backColor:[UIColor clearColor] textColor:[UIColor grayColor]];
        wanchenglabel.userInteractionEnabled=YES;
        [keyboardView addSubview:wanchenglabel];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickCompletedKeboard:)];
        [wanchenglabel addGestureRecognizer:tap];
    
        LXD *quxiaolabel=[[LXD alloc]initWithText:@"取消" font:15 textAlight:NSTextAlignmentCenter frame:CGRectMake(0,0, 30, 24) backColor:[UIColor clearColor] textColor:[UIColor grayColor]];

        [keyboardView addSubview:quxiaolabel];
        UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickCancelKeboard:)];
        [quxiaolabel addGestureRecognizer:tap1];
        quxiaolabel.userInteractionEnabled=YES;
        
        // 设置keyboardView
        self.addressContent.delegate = self;
        self.consigneeTextField.inputAccessoryView = keyboardView;
        self.addressContent.inputAccessoryView = keyboardView;
        self.contactsTel.inputAccessoryView = keyboardView;
        self.addressContent.inputAccessoryView = keyboardView;
    

}
-(void)jieguo{
    /*
    //未保存退出时的对话框
//    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    jieguo.hidden=NO;
//    [readerView1 stop];
    jieguo.backgroundColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.8];
    UIImageView *im1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_14"]];
    [jieguo addSubview:im1];
    im1.frame=CGRectMake(0, (self.view.bounds.size.height-452/2)/2-10, 320, 17);
    
    UIImageView *im2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_16"]];
//    [jieguo addSubview:im2];
    
    im2.frame=CGRectMake(0, (self.view.bounds.size.height-452/2)/2+17-10, 320, 197+20);
    UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 155, 120)];
    textLabel.center = CGPointMake(160, CGRectGetMidY(im2.bounds)-50);
    textLabel.text = @"您的信息尚未保存是否放弃此次编辑？";
    textLabel.font = [UIFont systemFontOfSize:17.0f];
    textLabel.numberOfLines = 2;
    [im2 addSubview:textLabel];
    
    UIImageView *im3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_18"]];
    [jieguo addSubview:im3];
    im3.frame=CGRectMake(0, (self.view.bounds.size.height-452/2)/2+17+197+10, 320, 33);
    

    
    UIImageView *im4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切片_30"]];
    im4.frame=CGRectMake(10, (self.view.bounds.size.height-452/2)/2+290/2, 300, 2);
    [jieguo addSubview:im4];
    
    NSArray *ar=[NSArray arrayWithObjects:@"取消",@"确定",nil];
    for(int i=0;i<2;i++){
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(62/2+288/2*i, (self.view.bounds.size.height-452/2)/2+330/2, 232/2, 43);
        if(i==0){
            [button setImage:[UIImage imageNamed:@"切片_29"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"切片_31"] forState:UIControlStateHighlighted];
            
        }
        else{
            [button setImage:[UIImage imageNamed:@"切片_117"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"切片_119"] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(buttonC:) forControlEvents:UIControlEventTouchUpInside];
        [jieguo addSubview:button];
        button.tag=611+i;
        
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(0,10+2, 232/2, 16)];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.backgroundColor=[UIColor clearColor];
        lable1.text=[ar objectAtIndex:i];
        if(i==0){
            lable1.textColor=[UIColor colorWithRed:3.0/255.0 green:96.0/255.0 blue:75.0/255.0 alpha:1];
        }
        else{
            lable1.textColor=[UIColor whiteColor];
        }
        
        lable1.font=[UIFont systemFontOfSize:15];
        [button addSubview:lable1];
    }
    [self.view addSubview:jieguo];
     
     */
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        pickerView.hidden = YES;
        pickerHeaderView.hidden=YES;
        return NO;
    }
    return YES;
}
#pragma mark - 按钮点击事件
-(void)pushDetail:(UIButton *)button{
    switch (button.tag) {
        case 801:
        {
            //编辑按钮的事件
            if ([sView.fenx.text isEqualToString:@"完成"]) {
                [self jieguo];
                return;
            }
            if (self.chooseFlag == 1) {
                [self.delegate refreshAddressList];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }    break;
            
        case 800:   // 打开交互
        {
 
            
        }    break;
        default:
            break;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    pickerView.hidden = YES;
    pickerHeaderView.hidden=YES;
    return  YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setDefaultAddress{
//    kSetDeAddrss
    [[self mainDelegate] beginLoad];
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    thisDownLoad = hd;
    hd.delegate=self;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:self.address.addressId forKey:@"addreId"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kSetDeAddrss,serviceHost]];
    hd.type =10108;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}

#pragma mark - 设置数据
-(void)setMyAddress:(AddressItem *)address{
//    _address = address;
    self.consigneeTextField.text = address.name;    // 名称
    self.contactsTel.text = address.phoneNumber;    // 电话
    self.setDistrictLable.text=address.areaName;  // 区域
    self.addressContent.text = address.address;     // 详细地址
}

#pragma mark - 设置用户交互
-(void)setUserInteractionEnabled:(BOOL)isEnabled
{
    self.consigneeTextField.userInteractionEnabled =  isEnabled;    // 名称
    self.contactsTel.userInteractionEnabled = isEnabled;    // 电话
    self.setDistrictLable.userInteractionEnabled = isEnabled;
    self.addressContent.userInteractionEnabled = isEnabled;     // 详细地址
    self.addressContent.backgroundColor = (isEnabled == YES)?[UIColor lightGrayColor]:[UIColor whiteColor];
}

#pragma mark - 检查电话号码
- (BOOL)checkTel:(NSString *)str

{
    if ([str length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSString * regex2 = @"(\\d{3}-|\\d{4}-)?(\\d{8}|\\d{7})?";
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    BOOL isMatch2 = [pred2 evaluateWithObject:str];
    if (!isMatch&&!isMatch2) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示提示" message:@"请输入正确的手机号码或座机号:\n13388888888或010-21212121" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

#pragma mark - 编辑地址
-(void) editAddress{
    //向网络请求待发货订单List
    [[self mainDelegate] beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:_consigneeTextField.text forKey:@"consignee"];
    [dict setObject:_addressContent.text forKey:@"address"];
    [dict setObject:_contactsTel.text forKey:@"contact"];
    [dict setObject:self.address.areaId forKey:@"areaId"];
    [dict setObject:self.address.addressId forKey:@"addreId"];
    [dict setObject:self.address.boutique forKey:@"boutique"];
    [dict setObject:self.address.stores forKey:@"stores"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kGetUpdateStatus,serviceHost]];
    hd.type =10110;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
}
-(void)requestAddressInfo
{
    [[self mainDelegate] beginLoad];
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    thisDownLoad = hd;
    NSMutableDictionary *dict=[self httpDic];
    [dict setObject:_consigneeTextField.text forKey:@"consignee"];
    [dict setObject:detailAddressView.text forKey:@"address"];
    [dict setObject:_contactsTel.text forKey:@"contact"];
    //    [dict setObject:self.findAreaIdBtn.titleLabel.text forKey:@"address"];
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kGetUpdateStatus,serviceHost]];
    hd.type =10105;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
//    loadView.beStop =NO;
    
}
-(NSMutableDictionary *)httpDic{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}

#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    switch (hd.type) {
        case 10108:
            [[self mainDelegate] endLoad];
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"取得地址列表失败,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            break;
        case 10109:
            [[self mainDelegate] endLoad];
            if ([[dict objectForKey:@"status"] intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"取得地址列表失败,请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            break;
        case 10110:
            [[self mainDelegate] endLoad];
            if ([[dict objectForKey:@"status"] intValue] == 0) {
//                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改不成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        default:
            break;
    }
    
}
-(void)didClickresignFirstResponder:(id)sender{
    
    pickerView.hidden = YES;
    pickerHeaderView.hidden=YES;

}

- (void)resignFirstResponderOfAll
{
    [_consigneeTextField resignFirstResponder];
    [_contactsTel resignFirstResponder];
    [_addressContent resignFirstResponder];
}

- (void)didClickFindAreaId:(UITapGestureRecognizer *)sender {
    pickerHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0,WindowHeight-20-44-170, 320, 30)];
    pickerHeaderView.userInteractionEnabled=YES;
    pickerHeaderView.tag=110;
    pickerHeaderView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];

    
    LXD *wanchenglabel=[[LXD alloc]initWithText:@"完成" font:15 textAlight:NSTextAlignmentCenter frame:CGRectMake(280,0, 30, 24) backColor:[UIColor clearColor] textColor:[UIColor grayColor]];
    wanchenglabel.userInteractionEnabled=YES;
    [pickerHeaderView addSubview:wanchenglabel];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickCompletedKeboard:)];
    [wanchenglabel addGestureRecognizer:tap];
    
    LXD *quxiaolabel=[[LXD alloc]initWithText:@"取消" font:15 textAlight:NSTextAlignmentCenter frame:CGRectMake(0,0, 30, 24) backColor:[UIColor clearColor] textColor:[UIColor grayColor]];
    
    [pickerHeaderView addSubview:quxiaolabel];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickCancelKeboard:)];
    [quxiaolabel addGestureRecognizer:tap1];
    quxiaolabel.userInteractionEnabled=YES;
    
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,WindowHeight -150-60, 320, 150)];
    pickerView.hidden=NO;
    pickerView.backgroundColor=[UIColor grayColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];

   [ self.view addSubview:pickerHeaderView];

    
    [self resignFirstResponderOfAll];
   UILabel * la = (UILabel * )[self.view viewWithTag:882];
    
    [pickerView selectRow:[self getCurrntpickerValues:la.text] inComponent:0 animated:YES];
    UITapGestureRecognizer * tapall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickresignFirstResponder:)];
    [self.view addGestureRecognizer:tapall];
}
-(NSInteger) getCurrntpickerValues:(NSString * )titleStr
{
    for (NSDictionary *  item in areaList) {
        if ([[item objectForKey:@"areaName"]isEqualToString:titleStr]) {
            return [areaList indexOfObject:item];
        }
    }
    return 0;
}
#pragma mark - PickView Delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [areaList count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[areaList objectAtIndex:row]objectForKey:@"areaName"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
        cityNmae=[[areaList objectAtIndex:row] objectForKey:@"areaName"];
        self.address.areaId =[[areaList objectAtIndex:row] objectForKey:@"areaId"];
    
}
#pragma mark - textView methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
    editType =3;
    tempStr = textView.text;
    if(isIPhone5)
    {
        
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0, -85, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEdit];
}

- (void)endEdit
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - textField methods
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    tempStr = textField.text;
    if (textField.tag == 880) {
        editType =1;
    }
    if (textField.tag == 881) {
        editType =2;
    }
}

#pragma mark -
#pragma mark inputAccessoryView 取消按钮事件
-(void)didClickCancelKeboard:(id)sender{
    
    if (editType == 1) {
        _consigneeTextField.text = tempStr;
        [_consigneeTextField resignFirstResponder];
        
    }else if (editType == 2){
        _contactsTel.text = tempStr;
        [_contactsTel resignFirstResponder];
        
    }else if (editType ==3){
        detailAddressView.text = tempStr;
        [detailAddressView resignFirstResponder];
    }
    if( pickerView.hidden==NO)
        
    {
        pickerHeaderView.hidden=YES;
        pickerView.hidden=YES;
        
    }
    [self endEdit];
}
#pragma mark inputAccessoryView 完成按钮事件
-(void)didClickCompletedKeboard:(UIButton *)sender
{
    if( pickerView.hidden==NO)
    {
        pickerHeaderView.hidden=YES;
        pickerView.hidden=YES;
    self.setDistrictLable.text=cityNmae;
       // flag=0;
    }
    
      self.setDistrictLable.text=cityNmae;
        [self resignFirstResponderOfAll];
        [self endEdit];
    
}
- (void)dealloc {
    [_setDistrictLable release];
    [super dealloc];
}
@end
