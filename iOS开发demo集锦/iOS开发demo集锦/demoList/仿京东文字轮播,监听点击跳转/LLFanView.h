//
//  LLFanView.h
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/7/31.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^fanClick)(NSString*);
@interface LLFanView : UIView

@property (nonatomic,copy) fanClick  block;
@end
