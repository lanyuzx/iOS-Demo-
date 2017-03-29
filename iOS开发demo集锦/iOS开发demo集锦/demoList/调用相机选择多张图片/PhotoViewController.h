//
//  PhotoViewController.h
//  相片相机
//
//  Created by ZJF on 16/6/1.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (nonatomic,copy) void(^popSelectArr)(NSMutableArray*arr);

//所选图片数组
@property (nonatomic,strong)NSMutableArray * selectArr;


@end
