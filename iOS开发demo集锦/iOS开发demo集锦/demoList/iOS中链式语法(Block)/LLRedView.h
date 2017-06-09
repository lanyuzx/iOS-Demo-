//
//  LLRedView.h
//  iOS中的链式语法
//
//  Created by 周尊贤 on 2017/6/6.
//  Copyright © 2017年 周尊贤. All rights reserved.
//
#import <UIKit/UIKit.h>
@class LLRedView;
typedef LLRedView*(^color)(UIColor*);
typedef LLRedView*(^title)(NSString*);
typedef LLRedView*(^type)(NSInteger);
typedef LLRedView*(^makeUp)(void);
typedef LLRedView*(^frame)(CGRect);
@interface LLRedView : UIView
@property (nonatomic,copy) color  colorBlock;
@property (nonatomic,copy) title  titleBlock;
@property (nonatomic,copy) type   typeBlock;
@property (nonatomic,copy) frame   frameBlock;
+(makeUp)makeDo;
@end
