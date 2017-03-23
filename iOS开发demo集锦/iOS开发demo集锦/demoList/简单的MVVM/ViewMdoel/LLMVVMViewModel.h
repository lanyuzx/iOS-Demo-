//
//  LLMVVMViewModel.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

typedef void(^SuccessBlock)(id );
typedef void(^ErrorBlock)(id );
@class LLMVVMModel;
#import <UIKit/UIKit.h>

@interface LLMVVMViewModel : NSObject
//回调网络请求的模型数据
-(void)setupRequsetDate :(NSInteger)pageIndex :(SuccessBlock)successblock :(ErrorBlock) errorblock;
//创建该类的单例,防止重复创建
+(LLMVVMViewModel *)shareViewModel;
//跳转到电影详情页
- (void)movieDetailWithPublicModel: (LLMVVMModel *)movieModel WithViewController: (UIViewController *)superController;
@end
