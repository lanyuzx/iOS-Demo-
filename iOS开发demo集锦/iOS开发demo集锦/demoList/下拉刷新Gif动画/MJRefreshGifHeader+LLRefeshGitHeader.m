//
//  MJRefreshGifHeader+LLRefeshGitHeader.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/16.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "MJRefreshGifHeader+LLRefeshGitHeader.h"

@implementation MJRefreshGifHeader (LLRefeshGitHeader)

-(void)prepare {
    [super prepare];
    
    self.stateLabel.hidden = false;
    self.lastUpdatedTimeLabel.hidden = false;
    
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh2"]] forState:MJRefreshStatePulling];
    [self setImages:@[[UIImage imageNamed:@"v2_pullRefresh1"],[UIImage imageNamed:@"v2_pullRefresh2"]] forState:MJRefreshStateRefreshing];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松手开始刷新" forState:MJRefreshStatePulling];

    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];


}
@end
