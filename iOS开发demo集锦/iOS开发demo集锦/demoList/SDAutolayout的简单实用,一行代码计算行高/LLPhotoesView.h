//
//  LLPhotoesView.h
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/7.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLModel;
@interface LLPhotoesView : UICollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout  ;

@property (nonatomic,strong)  LLModel * model;
@end
