//
//  YKDeviceKit.h
//  DeviceInfoDemo
//
//  Created by Daniel Yao on 17/3/23.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DYDeviceInfo : NSObject
/**
 *  auth    Daniel Yao
 *  method  获取设备IDFA
 *  @return 设备IDFA
 */
+(NSString *)dy_getDeviceIDFA;

/**
 *  auth    Daniel Yao
 *  method  获取设备IDFV
 *  @return 设备IDFV
 */
+(NSString *)dy_getDeviceIDFV;

/**
 *  auth    Daniel Yao
 *  method  获取设备IMEI
 *  @return 设备IMEI
 */
+(NSString*)dy_getDeviceIMEI;

/**
 *  auth    Daniel Yao
 *  method  获取设备MAC
 *  @return 设备MAC
 */
+(NSString*)dy_getDeviceMAC;

/**
 *  auth    Daniel Yao
 *  method  获取设备UUID
 *  @return 设备UUID
 */
+(NSString*)dy_getDeviceUUID;

/**
 *  auth    Daniel Yao
 *  method  获取设备UDID
 *  @return 设备UDID
 */
+(NSString*)dy_getDeviceUDID;
@end
