//
//  ShortageViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShortageViewController.h"
#import "StartPoint.h"
#import "ASIFormDataRequest.h"
#import "PictureUpload.h"
@interface ShortageViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,assign)int imageID;
@property (nonatomic,retain)NSString *comFilePath;
@property (nonatomic,retain)NSString *barFilePath;
@property (nonatomic,retain)NSString *comName;
@property (nonatomic,retain)NSString *barName;
@end

@implementation ShortageViewController
NSString * LXD_UPLOAD_IMG_PATH2 = @"";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.imageID = 1;
        self.comFilePath = [[NSString alloc]init];
        self.barFilePath = [[NSString alloc]init];
        self.comName = [[NSString alloc]init];
        self.barName = [[NSString alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self setNavigationBarWithContent:@"缺货反馈" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:[UIImage imageNamed:@"global_right_button"]];
    self.backView.frame = CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight);
    UITapGestureRecognizer *zhengmian = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionsheetAppear:)];
    self.commodityPositiveImage.userInteractionEnabled = YES;
    [self.commodityPositiveImage addGestureRecognizer:zhengmian];
    UITapGestureRecognizer *tiaoma = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionsheetAppear:)];
    self.barCodeImage.userInteractionEnabled = YES;
    [self.barCodeImage addGestureRecognizer:tiaoma];
}
-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonClick:(UIButton *)button
{
    NSArray *filePathValues = [[NSArray alloc]initWithObjects:self.comFilePath,self.barFilePath, nil];
    NSArray *filePathKeys = [[NSArray alloc]initWithObjects:@"file",@"file", nil];
    NSArray *fileNameValues = [[NSArray alloc]initWithObjects:self.comName,self.barName,nil];
    NSArray *fileNameKeys = [[NSArray alloc]initWithObjects:@"name",@"name",nil];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:filePathValues,@"filePathValues",filePathKeys,@"filePathKeys",fileNameValues,@"fileNameValues",fileNameKeys,@"fileNameKeys",nil];
    //将图片提交到服务器
    if(self.wifiSwitch.on == YES)
    {
        //仅wifi情况下上传商品图片
        [[NSUserDefaults standardUserDefaults]setValue:dict forKeyPath:@"valueToUpload"];
    }
    else
    {
        PictureUpload *pc = [[PictureUpload alloc]init];
        [pc uploadPictureWithDictionary:dict WithURL:@"fileurl"];
    }
}
-(void)actionsheetAppear:(UITapGestureRecognizer *)sender
{
    self.imageID = sender.view.tag;
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.view];
}
#pragma mark - UIImagePickerController delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{[self.leveyTabBarController hidesTabBar:YES animated:NO];}];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    UIImage *newImage = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    [self saveUIImagePickerControllerImageWithImage:newImage];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(originalImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    UIImage *newImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveUIImagePickerControllerImageWithImage:newImage];
}
-(void)saveUIImagePickerControllerImageWithImage:(UIImage*)thisImage
{
    UIImage *newImg=[self imageWithImageSimple:thisImage scaledToSize:CGSizeMake(300, 300)];
    NSString *name=[NSString stringWithFormat:@"%@%@",[self generateUuidString],@".jpg"];
    NSData* imageData = UIImagePNGRepresentation(newImg);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:name];
    LXD_UPLOAD_IMG_PATH2=fullPathToFile;
    NSArray *nameAry=[LXD_UPLOAD_IMG_PATH2 componentsSeparatedByString:@"/"];
    [imageData writeToFile:fullPathToFile atomically:YES];
    NSString *imagePath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[nameAry objectAtIndex:[nameAry count]-1]];
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.imageID == 1)
        {
           self.commodityPositiveImage.image = [UIImage imageWithContentsOfFile:imagePath];
            self.comFilePath = imagePath;
            self.comName = name;
        }
        else
        {
            self.barCodeImage.image = [UIImage imageWithContentsOfFile:imagePath];
            self.barFilePath = imagePath;
            self.barName = name;
        }
        [self.leveyTabBarController hidesTabBar:YES animated:NO];}];
}
-(UIImage *)imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize
{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.allowsEditing = YES;
    if (buttonIndex == 0)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [self presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error)
    {
        NSLog(@"Image written to photo album");
    }
    else
    {
        NSLog(@"Error writing to photo album: %@",[error localizedDescription]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
