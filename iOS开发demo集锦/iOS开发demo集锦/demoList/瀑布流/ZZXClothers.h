//
//  ZZXClothers.h
//  瀑布流效果的实现
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 zunxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZXClothers : NSObject
/*
 <key>h</key>
 <integer>275</integer>
 <key>img</key>
 <string>http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg</string>
 <key>price</key>
 <string>¥169</string>
 <key>w</key>
 <integer>200</integer>
 */
//图片高度
@property(nonatomic,assign) CGFloat h;
//图片宽度
@property(nonatomic,assign)CGFloat w;
//图片的 url
@property(nonatomic,copy)NSString *img;
//衣服的价格
@property(nonatomic,copy)NSString *price;


@end
