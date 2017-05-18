//
//  LLListModel.h
//  测试
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 毛织网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "LLCartVoListModel.h"
@interface LLListModel : NSObject
@property (nonatomic,assign) BOOL  isSelected;
@property (nonatomic,strong) NSArray * cartVoList;
@property (nonatomic,copy) NSString * supplierName;
@property (nonatomic,copy) NSString * companyName;

@end
