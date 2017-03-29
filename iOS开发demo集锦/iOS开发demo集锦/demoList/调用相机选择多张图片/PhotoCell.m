//
//  PhotoCell.m
//  GETPHOTO
//
//  Created by ZJF on 16/5/26.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "PhotoCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PhotoCell

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        

        [self createUI];
    }
    
    return self;
}

- (void)createUI{


    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH-2)/3,(WIDTH-2)/3)];
    
    self.iv.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.iv];
    
    CGFloat ivX = self.iv.frame.size.width;
    
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(ivX*3/4, 0, ivX/4,ivX/4 )];
    
   //[self.btn setImage:[UIImage imageNamed:@"p1.png"] forState:UIControlStateNormal];
    
   [self.btn setBackgroundImage:[UIImage imageNamed:@"p1.png"] forState:UIControlStateNormal];

    [self.btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.btn];

    
}


- (void)touchBtn:(UIButton *)sender{

   
    self.btnAction();
}

@end
