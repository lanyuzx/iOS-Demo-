//
//  LLMVVMTabView.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLMVVMModel;
typedef void(^MVVMTabViewBlock)(LLMVVMModel*);
typedef void(^refreshHeaderBlock)(NSInteger pageNum);
typedef void(^refreshFooterBlock)(NSInteger pageNum);
@interface LLMVVMTabView : UITableView

@property (nonatomic,strong)  NSArray * modelArr;

@property (nonatomic,copy)  MVVMTabViewBlock  block;

@property (nonatomic,copy)  refreshHeaderBlock blockHeader ;
@property (nonatomic,copy)  refreshHeaderBlock  blockFooter;


@end
