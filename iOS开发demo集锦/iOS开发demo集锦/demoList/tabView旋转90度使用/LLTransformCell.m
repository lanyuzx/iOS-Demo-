//
//  TableViewCell.m
//  tableview旋转90度
//
//  Created by LJP on 17/3/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SL_SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SL_SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)

#import "LLTransformCell.h"

@implementation LLTransformCell

//cell创建会走的方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.label1];
    
//    self.label1.transform = CGAffineTransformRotate(self.label1.transform, -M_PI_2);
    
    [self addSubview:self.label2];
    
    self.label2.transform = CGAffineTransformRotate(self.label2.transform, -M_PI_2);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.alpha = 0.5;
    }else{
        self.alpha = 1.0;
    }
}

-(void)setString:(NSString *)string {
    for (int i = 0 ; i<string.length; i++) {
        UILabel * l = [[UILabel alloc]initWithFrame:CGRectMake(i*20, 0, 20, 20)];
        
        
        NSRange range = NSMakeRange(i, 1);
        NSString * string1 = [string substringWithRange:range];
        l.text =string1;
        l.textColor = [UIColor orangeColor];
        l.textAlignment = NSTextAlignmentCenter;
        
        l.transform = CGAffineTransformRotate(l.transform, -M_PI_2);
        [self.label1 addSubview:l];
    }
}




- (UILabel *)label1 {
    if (_label1 == nil) {
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SL_SCREEN_WIDTH-100, 30)];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (_label2 == nil) {
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(SL_SCREEN_WIDTH-90, 10, 70, 30)];
        _label2.text =@"星期几";
        _label2.textColor = [UIColor lightGrayColor];
    }
    return _label2;
}


@end
