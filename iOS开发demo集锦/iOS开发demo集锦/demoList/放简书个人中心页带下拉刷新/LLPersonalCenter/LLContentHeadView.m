//
//  LLContentHeadView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLContentHeadView.h"

@implementation LLContentHeadView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    UIView* view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIButton class]])
    {
        return view;
    }
    
    return nil;
}


@end
