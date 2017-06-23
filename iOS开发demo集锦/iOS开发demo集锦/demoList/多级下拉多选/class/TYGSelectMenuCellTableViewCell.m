//
//  TYGSelectMenuCellTableViewCell.m
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/7.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import "TYGSelectMenuCellTableViewCell.h"

@implementation TYGSelectMenuCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    if (isSelected) {
        self.bg_mainView.backgroundColor = [UIColor clearColor];
        self.bg_leftView.backgroundColor = [UIColor redColor];
    }
    else{
        self.bg_mainView.backgroundColor = [UIColor whiteColor];
        self.bg_leftView.backgroundColor = [UIColor whiteColor];
    }
}

@end
