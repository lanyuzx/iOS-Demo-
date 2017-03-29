//
//  SelectedCell.m
//  相片相机
//
//  Created by ZJF on 16/6/3.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

-(instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;

}

- (void)createUI{

    
    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)]
    ;
    
    //self.iv.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.iv];
    

}

@end
