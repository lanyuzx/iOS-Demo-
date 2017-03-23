//
//  LLTempModel.h
//  cell的加载方式
//
//  Created by 周尊贤 on 16/10/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    
    loadingBefore = 0,
    loadIng ,
    loadingCompleted,
}TempModelEmun;
@interface LLTempModel : NSObject
@property(nonatomic,copy) NSString* name;
@property(nonatomic,assign) BOOL isClick;

@property(nonatomic,assign) TempModelEmun headViewEnum;
@end
