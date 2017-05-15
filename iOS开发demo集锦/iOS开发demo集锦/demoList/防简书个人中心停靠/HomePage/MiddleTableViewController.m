//
//  MiddleTableViewController.m
//  WeiboHomePage
//
//  Created by Maple on 16/10/16.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "MiddleTableViewController.h"

@interface MiddleTableViewController ()

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign) NSInteger  page;
@property (nonatomic,assign) BOOL  isUp,isOneTime;
@property (nonatomic, assign) BOOL canScroll;

@end


@implementation MiddleTableViewController

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

- (void)viewDidAppear:(BOOL)animated
{
//   这里请求数据
            [self loadUrl];
    
    
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
//    [self createFootView];
    
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

}




- (void)loadUrl
{
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  return 33;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    ;
    
    cell.textLabel.text = @"44";
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}







@end
