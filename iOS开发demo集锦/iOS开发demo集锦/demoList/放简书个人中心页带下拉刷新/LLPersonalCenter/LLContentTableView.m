//
//  LLContentTableView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLContentTableView.h"
#import "MJRefresh.h"
#define TitleHeight 45
@interface LLContentTableView()<UITableViewDataSource>
@end
@implementation LLContentTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dataSource = self;
        self.backgroundColor = [UIColor orangeColor];
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 结束刷新
                [self.mj_header endRefreshing];
            });
        }];
        // self.mj_header.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc
{
    
}


- (void)didMoveToWindow
{
    [super didMoveToWindow];
}



- (void)setContentOffset:(CGPoint)contentOffset
{
    
    if (self.window)
    {
        [super setContentOffset:contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"contentCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"content - %zd", indexPath.row];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


@end
