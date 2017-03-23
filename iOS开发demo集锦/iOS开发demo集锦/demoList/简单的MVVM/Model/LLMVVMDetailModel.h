//
//  LLMVVMDetailModel.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLMVVMDetailModel : NSObject
@property (copy, nonatomic) NSString *alt;
@property (nonatomic,strong)  NSDictionary * avatars;
@property (nonatomic,copy)  NSString * name;
@property (nonatomic,assign)  NSInteger  id;
@end
