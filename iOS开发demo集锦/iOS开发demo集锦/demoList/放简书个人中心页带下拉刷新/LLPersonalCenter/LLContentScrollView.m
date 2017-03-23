//
//  LLContentScrollView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//
#define HeadViewHeight 200
#import "LLContentScrollView.h"

@implementation LLContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = NO;
    }
    return self;
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//
//
//    return YES;
//}

- (void)setOffset:(CGPoint)offset
{
    _offset = offset;
    NSLog(@"%@", NSStringFromCGPoint(offset));
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    UIView* view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (HeadViewHeight - self.offset.y);
    if (hitHead || !view)
    {
        NSLog(@"no view");
        self.scrollEnabled = NO;
        if (!view)
        {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x)
                {
                    view = subView;
                }
            }
        }
        return view;
    }else{
        NSLog(@"view = %@", view);
        self.scrollEnabled = YES;
        return view;
        
    }
}



@end
