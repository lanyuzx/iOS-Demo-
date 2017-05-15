//
//  RightTableViewController.m
//  WeiboHomePage
//
//  Created by Maple on 16/10/16.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "RightTableViewController.h"

@interface RightTableViewController ()

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign) NSInteger  page;
@property (nonatomic,assign) BOOL  isUp,isOneTime;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation RightTableViewController

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

- (void)viewDidAppear:(BOOL)animated
{
    

    
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    ;
    
    cell.textLabel.text = @"44";
    
    
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZCLaoutTableViewCell *cell = (ZCLaoutTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGRect rect = [cell.rootLayout estimateLayoutRect:CGSizeMake(0, 0)];
//        NSLog(@"%f",rect.size.height);
//    return rect.size.height;
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    cell.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
}


//- (void)didseletImage:(NSInteger)num
//{
//    NSLog(@"%zd",num);
//    ArticleViewController *ar = [ArticleViewController new];
//    ar.type = @"article";
//    ar.articleId = [NSString stringWithFormat:@"%ld",(long)num];
//    [self.navigationController pushViewController:ar animated:YES];
//}

@end
