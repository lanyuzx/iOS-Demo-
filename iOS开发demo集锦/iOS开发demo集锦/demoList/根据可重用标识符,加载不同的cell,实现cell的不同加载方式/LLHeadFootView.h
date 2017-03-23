//
//  LLHeadFootView.h
//  cell的加载方式
//
//  Created by 周尊贤 on 16/10/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLTempModel;
@class LLHeadFootView;


@protocol headFootViewDelegate <NSObject>

-(void)headFootViewDelegateClick:(LLTempModel *)modle :(NSInteger)section :(LLHeadFootView *)headView;

@end
@interface LLHeadFootView : UITableViewHeaderFooterView
@property(nonatomic,strong) LLTempModel* model;
@property(nonatomic,weak) id<headFootViewDelegate> delegate;
@property(nonatomic,assign) NSUInteger section;

@end
