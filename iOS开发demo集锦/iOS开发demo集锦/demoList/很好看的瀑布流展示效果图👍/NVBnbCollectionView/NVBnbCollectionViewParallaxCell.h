//
//  NVCollectionViewParallaxCell.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

/**
 *  Base class for parallax cell in `NVBnbCollectionView`. This provides built-in image view with parallax effect.
 */
@interface NVBnbCollectionViewParallaxCell : UICollectionViewCell

/**
 *  Image view is used for parallax effect.
 */
@property (strong, nonatomic) UIImageView *parallaxImageView;

/**
 *  Image is used for parallax effect.
 */
@property (strong, nonatomic) UIImage *parallaxImage;

/**
 *  Current offset of parallax image view.
 */
@property (nonatomic) CGPoint parallaxImageOffset;

/**
 *  Maximum offset for parallax image view.
 */
@property (nonatomic) CGFloat maxParallaxOffset;

/**
 *  Current orientation, used to adjust parallax image view corresponding to orientation.
 */
@property (nonatomic) UIInterfaceOrientation currentOrienration;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com