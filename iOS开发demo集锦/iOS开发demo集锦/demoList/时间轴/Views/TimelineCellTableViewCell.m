//
//  TimelineCellTableViewCell.m
//  Timeline_Demo
//
//  Created by TOMO on 16/8/3.
//  Copyright © 2016年 TOMO. All rights reserved.
//

#import "TimelineCellTableViewCell.h"
#import "UIColor+Hex.h"
@implementation TimelineCellTableViewCell


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:YES];
    self.lineLabel.textColor = highlighted ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#3F7813"];
    self.lineLabel.adjustsFontSizeToFitWidth = YES;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
