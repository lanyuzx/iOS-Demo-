//
//  AlbumViewCell.m
//  相片相机
//
//  Created by ZJF on 16/6/1.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "AlbumViewCell.h"

@implementation AlbumViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{

    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 100 , 100)];
    
    [self.contentView addSubview:self.iv];
    
    self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(140, 50 ,100, 30)];
    

    [self.contentView addSubview:self.lbl];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
