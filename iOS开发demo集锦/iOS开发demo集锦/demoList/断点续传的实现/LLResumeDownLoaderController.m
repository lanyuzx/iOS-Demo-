//
//  LLResumeDownLoaderController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/15.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLResumeDownLoaderController.h"
#import "MQLResumeManager.h"
@interface LLResumeDownLoaderController ()
//下载的按钮
@property (nonatomic,strong) UIButton * downLoaderBtn;
//暂停的按钮
@property (nonatomic,strong) UIButton * stopBtn;
//进度条
@property (nonatomic,strong) UIProgressView * progressView;
//进度百分比
@property (nonatomic,strong) UILabel * currentProgressLable;
//删除的按钮
@property (nonatomic,strong) UIButton * deleteBtn;
@property (nonatomic,strong) MQLResumeManager * manager;
@property (nonatomic, strong) NSString *targetPath;
@end

@implementation LLResumeDownLoaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:self.downLoaderBtn];
     [self.view addSubview:self.deleteBtn];
     [self.view addSubview:self.stopBtn];
     [self.view addSubview:self.currentProgressLable];
     [self.view addSubview:self.progressView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    self.targetPath = [documentsDirectory stringByAppendingPathComponent:@"myPic"];
    long fileSize = [self fileSizeForPath:self.targetPath];
    if (fileSize < 1) {
        self.deleteBtn.hidden = true;
        _currentProgressLable.hidden = true;
        _progressView.hidden = true;
        _currentProgressLable.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.stopBtn.frame) + 15, 200, 35);
        _progressView.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.currentProgressLable.frame) + 15, 200, 35);
        
        
    }else {
        self.progressView.progress = fileSize;
         self.deleteBtn.hidden = false;
        _currentProgressLable.hidden = false;
        _progressView.hidden = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (long long)fileSizeForPath:(NSString *)path {
    
    long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}


-(void)simpleRequest:(id)sender{
    
    //1.准备
    if (self.manager) {
        
        [self cancelRequest:nil];
    }
    
    if ([self fileSizeForPath:self.targetPath] > 1) {
        
        UIAlertController * alterView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"文件已经下载,请不要重复下载" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterView addAction:action];
        [self presentViewController:alterView animated:true completion:nil];
        
        
        return;
        
    }
    _currentProgressLable.hidden = false;
    _progressView.hidden = false;
    _currentProgressLable.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.stopBtn.frame) + 15, 200, 35);
    _progressView.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.currentProgressLable.frame) + 15, 200, 35);
   
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/androidstudio23.dmg"];
    
    self.manager = [MQLResumeManager resumeManagerWithURL:url targetPath:self.targetPath success:^{
        
        NSLog(@"success");
        self.deleteBtn.hidden = NO;
        _currentProgressLable.hidden = false;
        _progressView.hidden = false;
        _currentProgressLable.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.deleteBtn.frame) + 15, 200, 35);
        _progressView.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.currentProgressLable.frame) + 15, 200, 35);
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure");
        
    } progress:^(long long totalReceivedContentLength, long long totalContentLength) {
        
        float percent = 1.0 * totalReceivedContentLength / totalContentLength;
        NSString *strPersent = [[NSString alloc]initWithFormat:@"%.f", percent *100];
        self.progressView.progress = percent;
        self.currentProgressLable.text = [NSString stringWithFormat:@"已下载%@%%", strPersent];
    }];
    
    //2.启动
    [self.manager start];
    
}

-(void)cancelRequest:(id)sender{
    
    [self.manager cancel];
    self.manager = nil;
}

-(void)deleteImage:(id)sender{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    [manager removeItemAtPath:self.targetPath error:&error];
    
    if (error == nil) {
        self.progressView.progress = 0;
        self.currentProgressLable.text = nil;
    
        self.deleteBtn.hidden = YES;
        _currentProgressLable.hidden = true;
        _progressView.hidden = true;
        
    }
    
}
 /// MARK: ---- 懒加载
-(UIButton *)downLoaderBtn {
    if (_downLoaderBtn == nil) {
        _downLoaderBtn = [UIButton new];
        [_downLoaderBtn setTitle:@"下载" forState:UIControlStateNormal];
        [_downLoaderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_downLoaderBtn setBackgroundColor:[UIColor redColor]];
        _downLoaderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_downLoaderBtn addTarget:self action:@selector(simpleRequest:) forControlEvents:UIControlEventTouchUpInside];
        _downLoaderBtn.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 100, 30, 200, 35);
    }
    return _downLoaderBtn;

}
-(UIButton *)stopBtn {
    if (_stopBtn == nil) {
        _stopBtn = [UIButton new];
        [_stopBtn setTitle:@"暂停按钮" forState:UIControlStateNormal];
        [_stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopBtn setBackgroundColor:[UIColor redColor]];
        _stopBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _stopBtn.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.downLoaderBtn.frame) + 15 , 200, 35);
        [_stopBtn addTarget:self action:@selector(cancelRequest:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _stopBtn;
    
}
-(UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setTitle:@"删除按钮" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor redColor];
        _deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
         _deleteBtn.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.stopBtn.frame) + 15 , 200, 35);
         [_deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
    
}
-(UILabel *)currentProgressLable {
    if (_currentProgressLable == nil) {
        _currentProgressLable = [UILabel new];
        _currentProgressLable.font = [UIFont boldSystemFontOfSize:16];
        _currentProgressLable.textColor = [UIColor whiteColor];
        _currentProgressLable.backgroundColor = [UIColor redColor];
        _currentProgressLable.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.deleteBtn.frame) + 15, 200, 35);
        _currentProgressLable.text = @"下载了";
        _currentProgressLable.textAlignment = NSTextAlignmentCenter;
    }
    return _currentProgressLable;
    
}

-(UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [UIProgressView new];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        _progressView.progressTintColor = [UIColor blueColor];
        _progressView.frame = CGRectMake(CGRectGetMinX(self.downLoaderBtn.frame), CGRectGetMaxY(self.currentProgressLable.frame) + 15, 200, 35);
    }
    return _progressView;
}


@end
