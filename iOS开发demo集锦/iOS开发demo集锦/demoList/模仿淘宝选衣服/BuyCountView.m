
//
//  BuyCountView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "BuyCountView.h"

@implementation BuyCountView
@synthesize bt_add,bt_reduce,tf_count,lb;
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        lb.text = @"购买数量";
        lb.textColor = [UIColor blackColor];
        lb.font = [UIFont systemFontOfSize:14];
        [self addSubview:lb];
        
        bt_add= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_add.frame = CGRectMake(self.frame.size.width-10-40, 10,40, 30);
        [bt_add setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        
        [bt_add setTitleColor:[UIColor blackColor] forState:0];
        bt_add.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_add setTitle:@"+" forState:0];
        [self addSubview:bt_add];
        
        tf_count = [[UITextField alloc] initWithFrame:CGRectMake(bt_add.frame.origin.x -45, 10, 40, 30)];
        tf_count.text = @"1";
        tf_count.textAlignment = NSTextAlignmentCenter;
        tf_count.font = [UIFont systemFontOfSize:15];
        tf_count.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [self addSubview:tf_count];
        
        bt_reduce= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_reduce.frame = CGRectMake(tf_count.frame.origin.x -45, 10, 40, 30);
        [bt_reduce setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [bt_reduce setTitleColor:[UIColor blackColor] forState:0];
        bt_reduce.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_reduce setTitle:@"-" forState:0];
        [self addSubview:bt_reduce];
        
        
       UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
