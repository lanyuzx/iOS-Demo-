//
//  ViewController.m
//  IOS 密码
//
//  Created by lujh on 2017/3/15.
//  Copyright © 2017年 lujh. All rights reserved.
//
#define HKLoginUserId @"HKLoginUserId"
#define HKLoginSeverceBuID @"HKLoginSeverceBuID"
#import "LLEncryptionController.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"

//盐 足够长 足够复杂
static NSString *salt = @"^^^^&GUHKUJHKJHJKHKJ)!_@_)()@(_)!@!MKMSLN";
@interface LLEncryptionController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation LLEncryptionController

- (IBAction)login:(id)sender {
    NSString *userID = self.name.text;
    NSString *pwd = self.pwd.text;
    [self.name resignFirstResponder];
    [self.pwd resignFirstResponder];
    
//    //1.MD5加密 不安全 被破解
//    pwd = pwd.md5String;
//    NSLog(@"%@",pwd);
    
//    //2.MD5 加盐 不足:盐是固定的，写死在程序中，泄露不安全
//    pwd = [pwd stringByAppendingString:salt].md5String;
//    
//    NSLog(@"%@",pwd);
      //3.HAMC 加密 key :密钥 从服务器获取
    //hamc 之后的密码
    pwd = [pwd hmacMD5StringWithKey:@"lujh"];
    //将这个密码，再拼接字符串然后md5
    pwd = [pwd stringByAppendingString:@"201703151431"].md5String;
    NSLog(@"%@",pwd);
    
    if ([self isSuccessWithUseId:userID Pwd:pwd]) {
        NSLog(@"登录成功");
        //1.记住密码，直接发送给服务器 pwd
        
        [self saveUserInfo];
        
    }else {
    
        NSLog(@"登录失败");
    }
    
    
}

- (void)saveUserInfo {
    //保存账号
    NSString *userID = self.name.text;
    //沙盒
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:HKLoginUserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //钥匙串访问 保存密码
    //1.密码明文 2.app的唯一标识 3.账号
    NSString *pwd = self.pwd.text;
    [SSKeychain setPassword:pwd forService:HKLoginSeverceBuID account:userID];
}

- (BOOL)isSuccessWithUseId:(NSString*)userId Pwd:(NSString*)pwd {

    if ([userId isEqualToString:@"lanyuzx"]&&[pwd isEqualToString:@"9872da5b8768746b1b60ec87e274a74f"]) {
        return YES;
        
    }else {
    
        return NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载本地的账号密码
    [self loadUserInfo];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];

}

- (void)loadUserInfo {
//设置账号
    self.name.text = [[NSUserDefaults standardUserDefaults] stringForKey:HKLoginUserId];
//密码
    self.pwd.text = [SSKeychain passwordForService:HKLoginSeverceBuID account:self.name.text];
}

@end
