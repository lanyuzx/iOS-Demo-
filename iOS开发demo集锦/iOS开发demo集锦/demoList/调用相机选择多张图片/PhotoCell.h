//
//  PhotoCell.h
//  GETPHOTO
//
//  Created by ZJF on 16/5/26.
//  Copyright © 2016年 ZJF. All rights reserved.
//


#import <UIKit/UIKit.h>



@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView * iv;

@property (nonatomic,strong)UIButton * btn;

@property (nonatomic,copy) void(^btnAction)();




@end
