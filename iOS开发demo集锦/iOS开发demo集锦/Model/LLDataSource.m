//
//  LLDataSource.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLDataSource.h"
#import "LLDemoModel.h"
@implementation LLDataSource

+(void)init:(dataSourceBlock)callBack {
    
    
       
        NSArray * timeArr = @[@"2017-03-14更新",@"2017-03-15更新",@"2017-03-23更新"];
        
        NSMutableArray * tempArr = [NSMutableArray array];
        
        for (int i =0; i<timeArr.count; i++) {
            LLDemoModel * model = [LLDemoModel new];
            model.headFootClick = true;
            model.updateTime = timeArr[i];
            switch (i) {
                case 0:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"时间日历",@"购物车动画",@"AFN3.0封装,接口并缓存使用YYCace" ,@"仿简书个人中心页,带下拉刷新",@"自定义可拖动试图",@"优秀的图片轮播图",@"自定义button,文字在上,图片在上完全有你自己决定",@"网络同步请求,使用信号机制实现",@"SDAutolayout的简单实用,一行代码计算行高",nil];
                    break;
                case 1:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"百思不得姐项目小马哥MVC",@"ios瀑布流",@"下拉刷新git图",@"根据可重用标识符,加载不同的cell,实现cell的不同加载方式",@"侧滑栏" ,nil];
                    break;
                case 2:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"自定义标题切换,根据文字的宽度确定一屏现实多少个",@"简单的MVVM设计模式" ,nil];
                    break;
                default:
                    break;
            }
            
            [tempArr addObject:model];
        }
        
       callBack(tempArr);
        
    
}

@end
