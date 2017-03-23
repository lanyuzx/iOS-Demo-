//
//  LLDataSource.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dataSourceBlock)(NSArray * resultArr);
@interface LLDataSource : NSObject


+(void)init:(dataSourceBlock)callBack;
@end
