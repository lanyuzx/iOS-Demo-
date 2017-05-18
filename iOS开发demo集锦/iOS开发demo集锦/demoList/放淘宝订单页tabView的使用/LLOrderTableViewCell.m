//
//  LLOrderTableViewCell.m
//  测试
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 毛织网. All rights reserved.
//

#import "LLOrderTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
@implementation LLOrderTableViewCell
{
    UIImageView *_prductImage;
    UILabel *_category;
    UILabel *_price;
    UILabel *_realPrice;
    


}

-(void)setModel:(LLCartVoListModel *)model {
    
    _model = model;
    [_prductImage sd_setImageWithURL:[NSURL URLWithString:@"http://image.315i.com/fileManager/pub/images/2017/0517/14950243898279601_0.jpg"]];
    _category.text = model.category ;
    _price.text =[NSString stringWithFormat:@"¥%@",model.realPrice] ;
    _realPrice.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    [self setupAutoHeightWithBottomView:_prductImage bottomMargin:8];
    

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
        _prductImage = [UIImageView new];
        [self.contentView addSubview:_prductImage];
        _prductImage.layer.masksToBounds = true;
        _prductImage.layer.cornerRadius = 3;
        _prductImage.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 8)
        .heightIs(120)
        .widthIs(100);
        
        _price = [UILabel new];
        _price.textColor = [UIColor darkGrayColor];
        _price.font = [UIFont boldSystemFontOfSize:14];
        _price.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_price];
        _price.sd_layout
        .topEqualToView(_prductImage)
        .rightSpaceToView(self.contentView, 5)
        .widthIs(80)
        .heightIs(25);
        
        _realPrice = [UILabel new];
        _realPrice.textColor = [UIColor darkGrayColor];
        _realPrice.font = [UIFont boldSystemFontOfSize:13];
        _realPrice.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_realPrice];
        _realPrice.sd_layout
        .topSpaceToView(_price, 8)
        .rightSpaceToView(self.contentView, 5)
        .widthIs(80)
        .heightIs(25);

        
        _category = [UILabel new];
        _category.textColor = [UIColor darkGrayColor];
        _category.font = [UIFont boldSystemFontOfSize:14];
        _category.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_category];
        _category.sd_layout
        .leftSpaceToView(_prductImage, 5)
        .topEqualToView(_prductImage)
        .rightSpaceToView(_price, 5)
        .autoHeightRatio(0);
        
        
        
    }
    
    return self;

}

@end
