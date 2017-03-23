//
//  NSObject+BAMJParse.m
//  BABaseProject
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 ZUNXIAN. All rights reserved.
//

#import "NSObject+BAMJParse.h"
#import "MJExtension.h"
@implementation NSObject (BAMJParse)


 
+ (id)BAMJParse:(id)responseObj
{
    //转字典
    if ([responseObj isKindOfClass:[NSDictionary class]])
    {
        return [self objectWithKeyValues:responseObj];
        
        
    }
    //转数组
    if ([responseObj isKindOfClass:[NSArray class]])
    {
        return [self objectArrayWithKeyValuesArray:responseObj];
    }
    //转 plist
    if ([responseObj isKindOfClass:[NSString class]]) {
        return [self objectWithFilename:responseObj];
    }
    
    return responseObj;
}




@end
