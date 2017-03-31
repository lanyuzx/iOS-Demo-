//
//  LLMainTableViewCell.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/30.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMainTableViewCell.h"
#import "LLDemoModel.h"
#import "UIView+SDAutoLayout.h"
@implementation LLMainTableViewCell
{
    UILabel * _nameLable;
}


-(void)setModel:(LLDemoModel *)model {
    _model = model;
    _nameLable.text = model.demoArr[self.indexPath.row];
    [self setupAutoHeightWithBottomView:_nameLable bottomMargin:12];
      }
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _nameLable = [UILabel new];
        _nameLable.textColor = [UIColor darkGrayColor];
        _nameLable.font = [UIFont systemFontOfSize:16];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.numberOfLines = 0;
        [self.contentView addSubview:_nameLable];
        _nameLable.sd_layout
        .leftSpaceToView(self.contentView,12)
        .topSpaceToView(self.contentView,12)
        .rightSpaceToView(self.contentView,12)
        .autoHeightRatio(0);

    }
    return self;

}
@end
