//
//  SDupimageViewController.m
//  upImega
//
//  Created by shy on 16/4/12.
//  Copyright © 2016年 shy. All rights reserved.
//

#import "SDupimageViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"


@interface SDupimageViewController () <UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate,NSXMLParserDelegate>

//图片框1
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
//图片框2
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
//反馈信息文字框
@property (weak, nonatomic) IBOutlet UITextView *fankuiTextView;
@property (nonatomic, strong) UILabel *fankuiLabel;
//城市1
@property (weak, nonatomic) IBOutlet UILabel *cityLabel1;
//城市2
@property (weak, nonatomic) IBOutlet UILabel *cityLabel2;

//判断图片
@property (nonatomic, assign) BOOL imgYesAndNo;
//判断城市
@property (nonatomic, assign) BOOL cityYesAndNo;

//地址
@property (nonatomic, strong) CLLocationManager *mgr;

//经纬度
@property (nonatomic, assign) double jingdu1;
@property (nonatomic, assign) double jingdu2;
@property (nonatomic, assign) double weidu1;
@property (nonatomic, assign) double weidu2;


//图片位置
@property (nonatomic, assign) CGRect imgViewFrame;
//变大后 view
@property (nonatomic, strong) UIView *bigView;

//第二张图片赋值
@property (nonatomic, assign) BOOL isYesAndNo;


@end

@implementation SDupimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(132 / 255.0) green:(161 / 255.0) blue:(252 / 255.0) alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    
    label.enabled = NO;
    
    label.text = @"在此输入反馈意见...";
    
    label.font =  [UIFont systemFontOfSize:15];
    
    label.textColor = [UIColor lightGrayColor];
    
    self.fankuiLabel = label;
    
    [self.fankuiTextView addSubview:label];
    
    self.fankuiTextView.delegate = self;
    
    
    
    UITapGestureRecognizer *tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView1)];
    
    [self.imgView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView2)];
    
    [self.imgView1 addGestureRecognizer:tap1];
    
    [self.imgView2 addGestureRecognizer:tap2];
    
    self.imgView1.userInteractionEnabled = YES;
    
    self.imgView2.userInteractionEnabled = YES;
    
    self.imgYesAndNo = YES;
    
    self.cityYesAndNo = YES;
    
    self.isYesAndNo = NO;
    
//    [self GPS];
}

#pragma mark textView 的代理方法
-(void) textViewDidChange:(UITextView *)textView {
    
    if (self.fankuiTextView.text.length == 0 ) {
        
        [self.fankuiLabel setHidden:NO];
        
    } else {
        
        [self.fankuiLabel setHidden:YES];
    }
}

#pragma mark 点击第一个 imageView
-(void) clickImgView1 {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示:" message:@"必须开始定位功能,否则无法上传照片" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *xiangjiAction = [UIAlertAction actionWithTitle:@"上传照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self upimg];
        
    }];
    
    UIAlertAction *datuAction = [UIAlertAction actionWithTitle:@" 查看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self datu:self.imgView1.image];
        
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        return ;
        
    }];
    
    [alertController addAction:xiangjiAction];
    [alertController addAction:datuAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark 点击第二个 imageView
-(void) clickImgView2 {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示:" message:@"必须开始定位功能,否则无法上传照片" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *xiangjiAction = [UIAlertAction actionWithTitle:@"上传照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self upimg];
        
    }];
    
    UIAlertAction *datuAction = [UIAlertAction actionWithTitle:@" 查看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self datu:self.imgView2.image];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        return ;
        
    }];
    
    [alertController addAction:xiangjiAction];
    [alertController addAction:datuAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark  相机拍照
-(void) upimg {
    
    if (![UIImagePickerController isSourceTypeAvailable:
          
            UIImagePickerControllerSourceTypeCamera]) {

          [MBProgressHUD showError:@"没有摄像头"];

          return ;
      };

      UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

      imagePicker.delegate = self;

      imagePicker.allowsEditing = YES;
    
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      
      [self presentViewController:imagePicker animated:YES completion:nil];

    
}

#pragma mark 图片完成执行的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (self.imgYesAndNo) {
        
        self.imgView1.image = image;
        
        self.imgYesAndNo = NO;
        
    } else {
        
        self.imgView2.image = image;
        
        self.imgYesAndNo = YES;
        
        self.isYesAndNo = YES;
    }
    
    [self GPS];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark 开始定位
-(void) GPS {
    
    //1. 创建CLLocationManager对象
    self.mgr = [CLLocationManager new];
    
    //2. 请求用户授权 --> 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        //当用户使用的使用授权
        [self.mgr requestWhenInUseAuthorization];
    }
    
    //3. 设置代理 --> 获取用户位置
    self.mgr.delegate = self;
    
    //4. 调用开始定位方法
    [self.mgr startUpdatingLocation];
}

#pragma mark  定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    
//    location.coordinate.latitude;//纬度
//    location.coordinate.longitude;//经度
    if (self.jingdu1 == 0) {
        
        self.jingdu1 = location.coordinate.latitude;
        self.weidu1 = location.coordinate.longitude;
        
    } else {
        
        self.jingdu2 = location.coordinate.latitude;
        self.weidu2 = location.coordinate.longitude;
    }
    
    [self cityLocation:location];
    
    //5. 停止定位
    [self.mgr stopUpdatingLocation];
}

#pragma mark  通过经纬度获取具体位置
- (void)cityLocation:(CLLocation *)citylocation
{
    
    //    NSLog(@"具体位置");
    
    CLGeocoder *geocoder = [CLGeocoder new];
    
    CLLocation *location = citylocation;
    
    //    NSLog(@"latitude: %f, longitude: %f",location.coordinate.latitude, location.coordinate.longitude);
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *placemark in placemarks)
        {
            NSDictionary *addressDic = placemark.addressDictionary;
            
            //            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city = [addressDic objectForKey:@"City"];
            
            NSString *subLocality = [addressDic objectForKey:@"SubLocality"];
            
            NSString *street = [addressDic objectForKey:@"Street"];
            
            if (self.cityYesAndNo) {
                
                self.cityLabel1.text = [NSString stringWithFormat:@"%@%@%@",city,subLocality,street];
                
                self.cityYesAndNo = NO;
            
            } else {
                
                self.cityLabel2.text = [NSString stringWithFormat:@"%@%@%@",city,subLocality,street];
            }
            
        }
        
    }];
    
}

#pragma mark 查看大图的方法
-(void) datu :(UIImage *) img {
    
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5;
    
    UIView *bigView = [[UIView alloc] init];
    
    bigView.frame = self.view.bounds;
    
    bigView.backgroundColor = [UIColor blackColor];
    
    bigView.alpha = 0;
    
    self.bigView = bigView;
    
    UITapGestureRecognizer *viewTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    
    [bigView addGestureRecognizer:viewTap];
    
    [self.view addSubview:bigView];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    
    imgView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    imgView.image = img;
    
    [bigView addSubview:imgView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        bigView.alpha = 1;
        
    }];
    
    
}



#pragma mark 大图变回小图
-(void) clickView {
    
    [UIView animateWithDuration:1.0 animations:^{
        // 1. 通过动画的方式,设置遮罩透明度为 0,
        self.bigView.alpha = 0;
    } completion:^(BOOL finished) {
        // 2. 动画执行完毕之后要执行的代码
        // 动画执行完毕之后,将遮罩从父控件中移除,并清空
        [self.bigView removeFromSuperview];
        self.bigView = nil;
    }];
    
}

#pragma mark 点击提交
- (IBAction)clickEndBtn:(id)sender {
    
    if (!self.isYesAndNo) {
        
        [MBProgressHUD showError:@"请您上传两个张片"];
        
        return;
    }
    
    if (self.jingdu2 == 0) {
        
        [MBProgressHUD showError:@"没有获取到您的当前位置"];
        
        return;
    }
    
    
    
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *userid = [ud objectForKey:@"USERID"];
//    NSString *password = [ud objectForKey:kPassWordKey];
//    
//    if (userid.length == 0) {
//        UIAlertController *alVC = [UIAlertController alertControllerWithTitle:@"你的账户还没有登陆" message:@"是否要登录" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//            LoginViewController *loginVC = [story instantiateInitialViewController];
//            [self.navigationController pushViewController:loginVC animated:YES];
//            
//        }];
//        
//        [alVC addAction:action1];
//        [alVC addAction:action2];
//        
//        [self presentViewController:alVC animated:YES completion:nil];
//        
//        
//    }
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgView1.image, 0.5);
    
    NSData *imageData2 = UIImageJPEGRepresentation(self.imgView2.image, 0.5);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *jingweidu = [NSString stringWithFormat:@"经度:%lf纬度:%lf@#经度:%lf纬度:%lf",self.jingdu1,self.weidu1,self.jingdu2,self.weidu2];
    
    NSString *dizhi = [NSString stringWithFormat:@"%@@#%@",self.cityLabel1.text,self.cityLabel2.text];
    
    NSString *xmlPar = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><Request><RequestParameter><PARAMETERS><taskId>1</taskId><userId>25</userId><password>7694f4a66316e53c8cdd9d9954bd611d</password><address>%@</address><gpsaddress>%@</gpsaddress><feedbackMsg>%@</feedbackMsg></PARAMETERS></RequestParameter></Request>",dizhi,jingweidu,self.fankuiTextView.text];
    
//    if (userid.length == 0) {
//        userid = @"0";
//    }
    
    NSArray *value1 = @[xmlPar,@"0033",@"25"];
    
    NSArray *param1 = @[@"param",@"interfaceNo",@"userid"];
    
    
    NSDictionary *paras = [NSDictionary dictionaryWithObjects:value1 forKeys:param1 ];
    
    [manager POST:@"http://192.168.0.107:8080/szfpServer/szfp/MobileServer" parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSString *pic = [NSString stringWithFormat:@"%@.jpg",self.cityLabel1.text];
        
        [formData appendPartWithFileData:imageData name:@"tupian" fileName:pic mimeType:@"application/octet-stream"];
        
        NSString *pic2 = [NSString stringWithFormat:@"%@.jpg",self.cityLabel2.text];
        
        [formData appendPartWithFileData:imageData2 name:@"tupian2" fileName:pic2 mimeType:@"application/octet-stream"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"网络请求成功: responseObject:%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        [MBProgressHUD showMessage:@"接收成功"];
        
//        [[self navigationController] popViewControllerAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        NSLog(@"网络请求失败");
        
    }];
    


}

//点击屏幕隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
