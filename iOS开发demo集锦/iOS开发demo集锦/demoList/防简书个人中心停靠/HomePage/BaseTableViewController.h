//
//  BaseTableViewController.h
//  WeiboHomePage
//
//  Created by Maple on 16/11/9.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewDelegate <NSObject>

- (void)tableViewDidScroll:(UIScrollView *)scrollView;
- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;
- (void)tableViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)tableViewDidScrollToTop:(UIScrollView *)scrollView;

@end

@interface BaseTableViewController : UITableViewController

// tableview滚动代理
@property (nonatomic, weak) id<BaseTableViewDelegate> scrollDelegate;
@property (nonatomic,strong)NSString *customer_id;
@property (nonatomic,strong)NSString *type;

@end
