//
//  LLFanView.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/7/31.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLFanView.h"
#import "UILabel+LLLable.h"
#define radians(degrees)  (degrees)*M_PI/180.0f
@implementation LLFanView
{
    UILabel * _ZXLable;
    UILabel * _KXLable;
    UILabel * _JYCLLable;
}
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        
        _ZXLable = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3-25, 45, 25, 130)];
        [self addSubview:_ZXLable];
        _ZXLable.verticalText = @"咨询介绍";
        [_ZXLable sizeToFit];
        _ZXLable.textAlignment = NSTextAlignmentRight;
        _ZXLable.textColor = [UIColor whiteColor];
        _ZXLable.transform = CGAffineTransformMakeRotation(-0.8);
        _ZXLable.userInteractionEnabled = true;
        _ZXLable.tag = 0;
        [_ZXLable addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        
        _KXLable = [[UILabel alloc]init];
        _KXLable.verticalText = @"快讯";
        [_KXLable sizeToFit];
        _KXLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_KXLable];
        _KXLable.textColor = [UIColor whiteColor];
        _KXLable.frame = CGRectMake(self.frame.size.width/2-12.5, 10, 25, 130);
        _KXLable.userInteractionEnabled = true;
        _KXLable.tag = 0;
        [_KXLable addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        
        _JYCLLable = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.width/3, 45, 25, 130)];
        [self addSubview:_JYCLLable];
        _JYCLLable.verticalText = @"交易策略";
        [_JYCLLable sizeToFit];
        _JYCLLable.textAlignment = NSTextAlignmentLeft;
        _JYCLLable.textColor = [UIColor whiteColor];
        _JYCLLable.transform = CGAffineTransformMakeRotation(0.8);
        _JYCLLable.userInteractionEnabled = true;
        _JYCLLable.tag = 0;
        [_JYCLLable addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];

        
        
    }
    return self;
    
}

-(void)click:(UIGestureRecognizer *)recognizer{
    
    UIView * clickView = recognizer.view;
    
    switch (clickView.tag) {
        case 0:
            self.block(@"咨询介绍");
            break;
        case 1:
            self.block(@"快讯");
            break;
        case 2:
            self.block(@"交易策略");
            break;
        default:
            break;
    }

}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置矩形填充颜色：红色
    //CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    //设置画笔颜色：黑色
    CGContextSetRGBStrokeColor(context,1,0,1,1.0);    //设置画笔线条粗细
    CGContextSetLineWidth(context, 1);
    
    //扇形参数
    double radius=180;        //半径
    int startX=[UIScreen mainScreen].bounds.size.width /2;           //圆心x坐标
    int startY=self.frame.size.height;          //圆心y坐标
    double pieStart=-108;       //起始的角度
    double pieCapacity=-108+36;   //角度增量值
    int clockwise=0;         //0＝顺时针,1＝逆时针
    
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    //CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieCapacity), clockwise);
    CGContextClosePath(context);
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    //CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart+36), radians(pieCapacity+36), clockwise);
    CGContextClosePath(context);
    
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    //CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart-36), radians(pieCapacity-36), clockwise);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);
    
    
    
}



@end
