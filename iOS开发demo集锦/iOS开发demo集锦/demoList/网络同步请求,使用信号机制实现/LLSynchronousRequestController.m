//
//  LLSynchronousRequestController.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLSynchronousRequestController.h"
#import "PPNetworkHelper.h"
@interface LLSynchronousRequestController ()

@end

@implementation LLSynchronousRequestController
static NSString *const dataUrl = @"http://api.budejie.com/api/api_open.php";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    
    UILabel * detaiLable = [UILabel new];
    [self.view addSubview:detaiLable];
    detaiLable.numberOfLines = 0;
    detaiLable.textColor = [UIColor orangeColor];
    detaiLable.frame = CGRectMake(0, 200, 120, 35);
    
    
    //该方法一定要使用开启一个异步线程,不然会卡死主线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id reuset = [self sendSynchronousRequest:dataUrl :para];
        NSLog(@"%@",[reuset objectForKey:@"list"]);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            detaiLable.text =@"请求结果见LOG 哈哈.....";
        });
       
    });
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) sendSynchronousRequest:(NSString *)requsetUrlStr :(NSDictionary *)dict
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block id  tempDict = nil;
    [PPNetworkHelper GET:requsetUrlStr parameters:dict responseCache:^(id responseCache) {
         tempDict = responseCache;
    } success:^(id responseObject) {
        tempDict = responseObject;
      dispatch_semaphore_signal(semaphore);
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];
   
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return tempDict;
    
}

@end
