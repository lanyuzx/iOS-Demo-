//
//  XMGMeViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGMeCell.h"
#import "XMGMeFooterView.h"
#import "UIView+XMGExtension.h"
#import "PrefixHeader.pch"
@interface XMGMeViewController()<UITableViewDataSource>
@property (nonatomic,strong)  UITableView * tableView;
@end

@implementation XMGMeViewController

static NSString *XMGMeId = @"me";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
}


- (void)setupTableView
{
    // 设置背景色
    self.tableView.backgroundColor = XMGGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[XMGMeCell class] forCellReuseIdentifier:XMGMeId];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
   self.tableView.sectionFooterHeight = XMGTopicCellMargin;
    
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(XMGTopicCellMargin - 35, 0, 0, 0);

    self.tableView.contentOffset = CGPointMake(0, 500);
    
    self.tableView.dataSource =self;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGMeId];
    
    XMGMeFooterView * footerView = [[XMGMeFooterView alloc]init];
    
    footerView.frame = CGRectMake(0, 600, XMGScreenW, XMGScreenH);
    // 设置footerView
    self.tableView.tableFooterView = footerView;
}

- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick
{
    XMGLogFunc;
}

- (void)moonClick
{
    XMGLogFunc;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }else if (indexPath.section == 2){
        
        cell.textLabel.text = @"dkkskererre";
    
    }
    
    return cell;
}


-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XMGScreenW, XMGScreenH) style:UITableViewStyleGrouped];
    }
    return _tableView;

}

@end
