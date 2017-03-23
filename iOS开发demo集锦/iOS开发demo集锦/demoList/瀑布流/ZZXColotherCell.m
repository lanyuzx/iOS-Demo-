//
//  ZZXColotherCell.m
//  瀑布流效果的实现
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 zunxian. All rights reserved.
//

#import "ZZXColotherCell.h"
#import "ZZXClothers.h"
#import "UIImageView+WebCache.h"
@interface ZZXColotherCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@end
@implementation ZZXColotherCell

-(void)setClothers:(ZZXClothers *)clothers{
    _clothers = clothers;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:clothers.img] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    self.priceLable.text = clothers.price;

}
@end
