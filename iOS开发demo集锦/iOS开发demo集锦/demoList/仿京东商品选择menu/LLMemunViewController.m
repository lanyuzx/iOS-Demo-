//
//  ViewController.m
//  test
//
//  Created by Mac on 17/4/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "LLMemunViewController.h"
#import "SMKDropSelectMenu.h"

@interface LLMemunViewController ()

@property (nonatomic, strong) SMKDropSelectMenu *menu;

@end

@implementation LLMemunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.menu = [SMKDropSelectMenu dropSelectMenu];
    self.menu.isShowFirstButtonImage = NO;
    self.menu.isFirstResetButton = YES;
    self.menu.backgroundColor = [UIColor whiteColor];
    self.menu.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:self.menu];
    
    self.menu.titleArray = @[@"全部", @"类型", @"风格", @"费用"];
    NSMutableDictionary *menuCategoryDict = [@{
                               
                               @"price" : @[@"全部", @"5万以下",@"5-10万",@"10-20万",@"20-50万",@"50-100万",@"100万以上"],
                               
                               @"type" : @[@"全部类型",@"女歌手",@"男歌手",@"组合/乐队"],
                               
                               @"style" : @[@"全部风格",@"流行",@"R&B",@"摇滚",@"古典",@"舞曲",@"民谣",@"中国风"]
                               
                               } mutableCopy];
    
    self.menu.menuDataArray = [@[@[],menuCategoryDict[@"price"], menuCategoryDict[@"type"], menuCategoryDict[@"style"]] mutableCopy];
    
    __weak typeof(self) _weakSelf = self;
    
    [self.menu setHandleSelectButtonBlock:^(NSUInteger selectIndex) {
        if (selectIndex == 0) {
            [_weakSelf.menu resetAction];

        }
    }];
    
    [self.menu setHandleSelectDataBlock:^(NSString *selectTitle, NSUInteger selectIndex, NSUInteger selectButtonTag) {
        NSLog(@"选中文字：%@   ======   选中索引：%zd", selectTitle, selectIndex);
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
