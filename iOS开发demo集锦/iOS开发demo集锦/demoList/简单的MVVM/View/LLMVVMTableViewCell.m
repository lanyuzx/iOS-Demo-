//
//  LLMVVMTableViewCell.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/23.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLMVVMTableViewCell.h"
#import "LLMVVMModel.h"
#import "UIImageView+WebCache.h"
#import "LLMVVMDetailModel.h"
@interface LLMVVMTableViewCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *yearLabel;
@property (nonatomic,strong) UIImageView *imgView;
@end
@implementation LLMVVMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 120, 80)];
        [self.contentView addSubview:_imgView];
        _imgView.layer.masksToBounds = true;
        _imgView.layer.cornerRadius = 30;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame), 10, 200, 20)];
        [self.contentView addSubview:_nameLabel];
        
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame), CGRectGetMaxY(self.nameLabel.frame), 100, 20)];
        _yearLabel.textColor = [UIColor lightGrayColor];
        _yearLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_yearLabel];
    }
    return self;

}

-(void)setModel:(LLMVVMModel *)model {
    
    _model =model;
    
    _nameLabel.text = _model.title;
    _yearLabel.text = _model.year;
    
    
    LLMVVMDetailModel * detailModel = model.casts.firstObject;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[detailModel.avatars objectForKey:@"small"]]];



}

@end
