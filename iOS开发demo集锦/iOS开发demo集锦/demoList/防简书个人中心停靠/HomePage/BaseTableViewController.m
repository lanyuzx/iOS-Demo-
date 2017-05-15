//
//  BaseTableViewController.m
//  WeiboHomePage
//
//  Created by Maple on 16/11/9.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.tableView.scrollsToTop = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    NSLog(@"%f,%f",self.tableView.contentSize.height,kScreenHeight + kHeaderTopHeight - kTopBarHeight);
//    if (self.tableView.contentSize.height < kScreenHeight + kHeaderTopHeight - kTopBarHeight ) {
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kScreenHeight + kHeaderTopHeight - kTopBarHeight - self.tableView.contentSize.height, 0);
//    }
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if([self.scrollDelegate respondsToSelector:@selector(tableViewDidScroll:)])
  {
    [self.scrollDelegate tableViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if([self.scrollDelegate respondsToSelector:@selector(tableViewDidEndDragging:)])
  {
    [self.scrollDelegate tableViewDidEndDragging:scrollView];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if([self.scrollDelegate respondsToSelector:@selector(tableViewDidEndDecelerating:)])
  {
    [self.scrollDelegate tableViewDidEndDecelerating:scrollView];
  }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if([self.scrollDelegate respondsToSelector:@selector(tableViewDidScrollToTop:)])
    {
        [self.scrollDelegate tableViewDidScrollToTop:scrollView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    // 通过最后一个 Footer 来补高度
    if (section == [self numberOfSectionsInTableView:tableView] - 1) {
        return [self automaticHeightForTableView:tableView];
    }
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)automaticHeightForTableView:(UITableView *)tableView{
    
    // 36 是 segmentButtons 的高度 20 是segmentTopSpace的高度
    CGFloat height = 64+36;
    
    NSInteger section = [tableView.dataSource numberOfSectionsInTableView:tableView];
    for (int i = 0; i < section; i ++) {
        
        if ([tableView.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
            height += [tableView.delegate tableView:tableView heightForHeaderInSection:i];
        }
        
        NSInteger row = [tableView.dataSource tableView:tableView numberOfRowsInSection:i];
        for (int j= 0 ; j < row; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
                height += [tableView.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
            }
            
            if (height >= tableView.frame.size.height) {
                return 0.0001;
            }
        }
        
        if (i != section - 1) {
            
            if ([tableView.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
                height += [tableView.delegate tableView:tableView heightForFooterInSection:i];
            }
        }
        
    }
    
    if (height >= tableView.frame.size.height) {
        return 0.0001;
    }
    
    return tableView.frame.size.height - height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
