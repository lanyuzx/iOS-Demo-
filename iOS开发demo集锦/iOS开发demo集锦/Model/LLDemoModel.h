//
//  LLDemoModel.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLDemoModel : NSObject
@property (nonatomic,copy)  NSString * updateTime;
@property (nonatomic,strong)  NSMutableArray * demoArr;
@property (nonatomic,assign)  BOOL  headFootClick;
@end
