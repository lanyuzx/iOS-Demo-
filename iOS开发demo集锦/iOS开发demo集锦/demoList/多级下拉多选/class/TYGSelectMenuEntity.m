//
//  TYGSelectMenuEntity.m
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/6.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import "TYGSelectMenuEntity.h"

@implementation TYGSelectMenuEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.childMenuArray = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

@end
