//
//  LLMVVMModel.h
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLMVVMDetailModel;
@interface LLMVVMModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *year;

@property (copy, nonatomic) NSArray <LLMVVMDetailModel*>*casts;



@end
