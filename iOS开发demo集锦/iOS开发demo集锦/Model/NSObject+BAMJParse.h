//
//  NSObject+BAMJParse.h
//  BABaseProject
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ZUNXIAN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (BMJParse)

/*
 MJExtension 解析数组和字典需要使用不同的方法.
 我们自己合并,用代码判断
 */

+ (id)BAMJParse:(id)responseObj;


@end
