//
//  LLLeftTableViewCell.m
//  iOS表格原生实现左固定右滑动
//
//  Created by 周尊贤 on 17/9/22.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLLeftTableViewCell.h"
#import "Masonry.h"
@implementation LLLeftTableViewCell
{
    UILabel * _textLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    _textLable.text = titleName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _textLable = [UILabel new];
        [self.contentView addSubview:_textLable];
        _textLable.text = @"LEE家族";
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.font = [UIFont systemFontOfSize:15];
        _textLable.textColor = [UIColor darkGrayColor];
        [_textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
