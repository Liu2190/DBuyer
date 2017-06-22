//
//  AddAddressViewController.m
//  DBuyer
//  添加地址
//  Created by liuxiaodan on 13-11-22.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AddAddressViewController.h"
#import "ChooseAddressViewController.h"
#import "DBManager.h"
#define kPickerRect CGRectMake(0,0,320,200)
#define kPickerViewRect CGRectMake(0,260,320,240)


@interface AddAddressViewController () {
    id _target;
    SEL _action;
    NSMutableDictionary *_resultDic; // 回调使用的字典
}

@end

@implementation AddAddressViewController
{
    NSString * tempStr;
    UIPickerView * pickerView;
    UIView * pickerBackView;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    LoadView * loadView;
    NSMutableArray * areaList;
    NSInteger editType;//1 _nameTextField 2 _phoneNumberTextField 3 _addressDetailInfoTextView
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = BACKCOLOR;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AllEditFieldResignFirstResponder)];
        [self.view addGestureRecognizer:tap];
        tempStr = [[NSString alloc]init];
        _areaId = [[NSString alloc]init];
        areaList = [[NSMutableArray alloc]init];
        _boutique = [[NSString alloc]init];
        _stores = [[NSString alloc]init];
        _resultDic = [NSMutableDictionary dictionary];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup aDfter loading the view from its nib.
    [self getAreaList];
    [self initPickerView];
    [self initKeyboardView];
    [self setNavigationBarWithContent:@"地址管理" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:[UIImage imageNamed:@"global_right_button"]];
}
#pragma mark - 设置pickView
-(void)initPickerView{
    pickerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, WindowHeight-180, WindowWidth, 200.0f)];
    pickerBackView.backgroundColor = BACKCOLOR;
    pickerBackView.hidden = YES;
    [self.view addSubview:pickerBackView];
    
    pickerView = [[UIPickerView alloc]initWithFrame:kPickerRect];
    pickerView.backgroundColor=[UIColor grayColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [pickerBackView addSubview:pickerView];

}
#pragma mark - 设置键盘
-(void)initKeyboardView{
    
    //在键盘上添加按钮
    UIView * keyboardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    keyboardView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];
    //设置完成按钮
    CGRect btnRect = CGRectMake(0, 0, 30, 24);
    LXD *complate=[[LXD alloc]initWithText:@"完成" font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0,5,30, 15) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    UIButton * compBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [compBtn addTarget:self action:@selector(didClickCompletedKeboard:) forControlEvents:UIControlEventTouchUpInside];
    compBtn.bounds = btnRect;
    compBtn.center = CGPointMake(320-10-15, 15);
    [compBtn addSubview:complate];
    [keyboardView addSubview:compBtn];
   //设置取消按钮
    LXD *cancel=[[LXD alloc]initWithText:@"取消" font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0,5,30, 15) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.center = CGPointMake(10+15, 15);
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(didClickCancelKeboard:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.bounds = btnRect;
    [cancelBtn addSubview:cancel];
    [keyboardView addSubview:cancelBtn];
    
    _nameTextField.inputAccessoryView =keyboardView;
    _phoneNumberTextField.inputAccessoryView =keyboardView;
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _addressDetailInfoTextView.inputAccessoryView =keyboardView;
}
#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 设置返回按钮
-(void)rightButtonClick:(UIButton  *)button{
    if (![self checkAddressInfo]) {
        return;
    }
    [self didClickAddAddress:button];
}

#pragma mark 设置回调方法
- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nameTextField release];
    [_phoneNumberTextField release];
    [_addressDetailInfoTextView release];
    [_findAreaIdBtn release];
    [_backGroundView release];
    [super dealloc];
}
- (IBAction)didClickAddAddress:(UIButton *)sender {
    //将地址信息发送给服务器
    [self requestAddressInfo];
    [self addLoadView];
    loadView = (LoadView *)[self.view viewWithTag:LoadViewFlag];
}
- (BOOL)checkTel:(NSString *)str

{
    //校验电话
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
    if (!(isMatch||isMatch2)) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的手机号码或座机号:\n13388888888或010-21212121" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

#pragma mark - textView methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
//    if (![textView.text isEqualToString:@""]) {
//        tempStr = textView.text;
//        textView.text = @"";
//    }
    pickerBackView.hidden = YES;
    editType =3;
    if(isIPhone5)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0, -50, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0, -130, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self endEdit];
}


- (void)endEdit
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}

#pragma mark - textField methods
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    pickerBackView.hidden = YES;
    if (![textField.text isEqualToString:@""]) {
        tempStr = textField.text;
        textField.text = @"";
    }
    if (textField.tag == 2201) {
        editType =1;
    }
    if (textField.tag == 2202) {
        editType =2;
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - PickView Delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return areaList.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[areaList objectAtIndex:row]objectForKey:@"name"];
}
#pragma mark - private methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.findAreaIdBtn setTitle:[[areaList objectAtIndex:row] objectForKey:@"name"] forState:UIControlStateNormal];
}

-(void)getAreaList{
    
    //向网络请求取得区域列表
    HttpDownload *hd=[[HttpDownload alloc]init];
    
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];

    //    [dict setObject:self.findAreaIdBtn.titleLabel.text forKey:@"address"];
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:kQueryCitys,serviceHost]];
    hd.type =10106;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
}

- (BOOL)checkAddressInfo
{
    //将添加的地址信息发送给服务器
    if((self.phoneNumberTextField.text == nil)||[self.phoneNumberTextField.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"电话不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (![self checkTel:self.phoneNumberTextField.text]) {
        return NO;
    }
    if((self.nameTextField.text == nil)||[self.nameTextField.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"姓名不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if((self.addressDetailInfoTextView.text == nil)||[self.addressDetailInfoTextView.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"地址不能为空" delegate:self  cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(void)requestAddressInfo{

    if (![self checkAddressInfo]) {
        return;
    }
    
    //向网络请求待发货订单List
    HttpDownload *hd=[[HttpDownload alloc]init];
    
    hd.delegate=self;
    
    NSMutableDictionary *dict=[self httpDic];
     NSString *addressdetail=[NSString stringWithFormat:@"北京市%@%@",self.findAreaIdBtn.titleLabel.text,self.addressDetailInfoTextView.text];
    [dict setObject:self.nameTextField.text forKey:@"consignee"];
    [dict setObject:addressdetail forKey:@"address"];
    [dict setObject:self.phoneNumberTextField.text forKey:@"contact"];
    self.areaId = [[DBManager sharedDatabase]selectAreaIdWihtAreaname:self.findAreaIdBtn.titleLabel.text];
    [dict setObject:self.areaId forKey:@"areaId"];
    [dict setObject:self.boutique forKey:@"boutique"];
    [dict setObject:self.stores forKey:@"stores"];
    

    // 保存当前的字典
    _resultDic = dict;
    
    [hd getResultData:dict baseUrl:[NSString stringWithFormat:addCommoditityAddress,serviceHost]];
    hd.type =10100;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    loadView.beStop =NO;
    [[self mainDelegate] beginLoad];
    
}
-(void) AllEditFieldResignFirstResponder{
    //收起键盘
    [self.nameTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.addressDetailInfoTextView resignFirstResponder];
    pickerBackView.hidden = YES;
    [self endEdit];
    
}
-(NSMutableDictionary *)httpDic{
    //网络请求固定参数
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    
    return dict;
    
}

- (IBAction)didClickFindAreaId:(UIButton *)sender {
    //打开区域列表
    [self AllEditFieldResignFirstResponder];
    pickerBackView.hidden = NO;
    [pickerView selectRow:[self getCurrntpickerValues:sender.titleLabel.text] inComponent:0 animated:YES];
    
}
-(NSInteger) getCurrntpickerValues:(NSString * )titleStr
{
    //返回区域名对应的索引
    for (NSDictionary *  item in areaList) {
        if ([[item objectForKey:@"name"]isEqualToString:titleStr]) {
            return [areaList indexOfObject:item];
        }
    }
  return 0;
}
#pragma mark - 下载数据

-(void)downloadComplete:(HttpDownload *)hd1{
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    if(dict){
        [self.mainDelegate endLoad];
        
        if(hd1.type==10100){
            //接收添加地址的结果
            loadView.beStop = YES;
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0){
                if (_target && _action) {
                    AddressItem *address = [[AddressItem alloc] initWithDic:_resultDic];
                    address.addressId = [dict objectForKey:@"uuid"];
                    [_target performSelector:_action withObject:address];
                    [self.navigationController popToViewController:_target animated:YES];
                    return;
                }
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"添加成功" delegate:self cancelButtonTitle:@"返回上一页" otherButtonTitles:nil, nil];
                alert.delegate  = self;
                [alert show];
            }
        }
        if(hd1.type==10106){
           //接收区域列表信息
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0){
                NSArray * array = [dict objectForKey:@"resultList"];
                [areaList addObjectsFromArray:array];
                
                NSMutableArray * dbArray = [[DBManager sharedDatabase] selectAreaListFromAreaId];
                
                if (array.count != dbArray.count) {
                    [[DBManager sharedDatabase] deleteItemFromAreaIDList];
                    for (NSMutableDictionary * item in array) {
                        [[DBManager sharedDatabase] insertintoAreaIDlist:item];
                    }
                }
                [pickerView reloadAllComponents];
            }
        }
    }
}

#pragma mark - private methods
-(void)didClickCancelKeboard:(UIButton *)sender{
    //取消按钮的事件
    if (editType == 1) {
        _nameTextField.text = tempStr;
        [_nameTextField resignFirstResponder];

    }else if (editType == 2){
        _phoneNumberTextField.text = tempStr;
        [_phoneNumberTextField resignFirstResponder];

    }else if (editType ==3){
        _addressDetailInfoTextView.text = tempStr;
        [_addressDetailInfoTextView resignFirstResponder];

    }
    [self endEdit];
    
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

-(void)didClickCompletedKeboard:(UIButton *)sender{
    [self endEdit];
    //完成按钮的事件
    [_nameTextField resignFirstResponder];
    [_phoneNumberTextField resignFirstResponder];
    [_addressDetailInfoTextView resignFirstResponder];
}

- (IBAction)didClickBack:(id)sender {
    //返回按钮的事件
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:@"添加成功"]) {
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
