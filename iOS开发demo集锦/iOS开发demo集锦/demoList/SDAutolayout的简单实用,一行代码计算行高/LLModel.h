//
//  LLModel.h
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/6.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLModel : NSObject
@property (nonatomic,copy)  NSString * text;

@property (nonatomic,strong)  NSArray *  photoArr;

@property (nonatomic,assign)  BOOL  isLike;
@end
