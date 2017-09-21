//
//  LLRightTableViewCell.m
//  iOS表格原生实现左固定右滑动
//
//  Created by 周尊贤 on 17/9/22.
//  Copyright © 2017年 周尊贤. All rights reserved.
//
#define leftTabViewWith 100
#define titleHeight 45
#import "LLRightTableViewCell.h"

@implementation LLRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitles:(NSArray *)titles {
    _titles = titles;
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<self.titles.count; i++) {
        UILabel * leftTileLable = [UILabel new];
        [self.contentView addSubview:leftTileLable];
        leftTileLable.font = [UIFont systemFontOfSize:15];
        leftTileLable.text = self.titles[i];
        leftTileLable.textAlignment = NSTextAlignmentCenter;
        leftTileLable.textColor = [UIColor darkGrayColor];
        leftTileLable.frame = CGRectMake(i*leftTabViewWith, 0, leftTabViewWith, titleHeight);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

@end
