//
//  UILabel+LLLable.m
//  JLCSteelProject
//
//  Created by 周尊贤 on 2017/7/27.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "UILabel+LLLable.h"
#import <objc/runtime.h>
@implementation UILabel (LLLable)
- (NSString *)verticalText{
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}


@end
