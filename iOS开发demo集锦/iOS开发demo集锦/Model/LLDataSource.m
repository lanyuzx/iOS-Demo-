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
    
    
       
        NSArray * timeArr = @[@"2017-03-14更新",@"2017-03-15更新",@"2017-03-23更新",@"2017-03-29更新",@"2017-04-05更新",@"2017-05-12更新",@"2017-06-08更新",@"2017-09-22更新"];
        
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
                    model.demoArr = [NSMutableArray arrayWithObjects:@"自定义标题切换,根据文字的宽度确定一屏现实多少个",@"简单的MVVM设计模式",@"首页动画较为实用仿工商银行首页",@"tabView旋转90度使用" ,nil];
                    break;
                case 3:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"调用相机选择多张图片",@"断点下载，支持后台下载，再次打开程序、异常退出记录下载进度",@"模仿淘宝部分购物界面" ,@"模仿淘宝选衣服",@"时间轴",@"动画的微妙之处之贝塞尔曲线一部分",@"仿新浪微博图片选择器",nil];
                    break;
                    case 4:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"iOS股票折线图",@"仿京东商品选择器",@"iOS人脸识别",@"iOS加密+加盐",@"获取设备标识符 UDID IDFA等等",@"很好看的瀑布流展示效果图👍",@"使用GPUImage实现人脸美白和人脸识别(磨皮，人脸检测) ",@"新版上传照片功能", nil];
                    break;
                case 5:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"强大的pdf阅读器",@"星级评论",@"POP各种动画效果",@"跳转仿简书个人中心停靠",@"使用NSURLSession断点续传的实现",@"iOS多个异步网络请求,完成后,在做其他操作(比如结束刷新)",@"牛逼的二维码扫描框架",@"放淘宝订单页(tabView的使用)",@"多级下拉多选", nil];
                    break;
                
                case 6:
                model.demoArr = [NSMutableArray arrayWithObjects:@"LEEAlter弹框神器",@"蓝牙开发的demo",@"iOS中链式语法(Block)",@"仿京东文字轮播,监听点击跳转",@"iOS使用CGContextRef画扇子",@"下拉选中效果",nil];
                break;
                case 7:
                    model.demoArr = [NSMutableArray arrayWithObjects:@"iOS表格原生实现左固定右滑动",nil];
                    break;
                default:
                    break;
            }
            
            [tempArr addObject:model];
        }
        
       callBack(tempArr);
        
    
}

@end
