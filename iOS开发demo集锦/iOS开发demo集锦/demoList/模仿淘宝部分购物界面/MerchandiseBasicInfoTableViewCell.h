//
//  MerchandiseBasicInfoTableViewCell.h
//  Demo
//
//  Created by 张德雄 on 16/6/4.
//  Copyright © 2016年 GroupFly. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMerchandiseBasicInfoTableViewCellIdentifier;

typedef void(^MerchandiseBasicInfoBlock)(NSInteger index);

@interface MerchandiseBasicInfoTableViewCell : UITableViewCell

@property (copy, nonatomic) MerchandiseBasicInfoBlock block;

@property (copy, nonatomic) NSString *endTime;    // 活动结束时间

@property (assign, nonatomic) BOOL isEnd;   // 活动是否结束

// 更新活动结束时间
- (void)updateActivityDateWithComponent:(NSDateComponents *)component;

@end
