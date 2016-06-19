//
//  ipTools.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/20.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ipTools : NSObject
+ (NSString *)getIPAddress:(BOOL)preferIPv4 IPArray:(NSArray*)arr;

+ (BOOL)isValidatIP:(NSString *)ipAddress;
+ (NSDictionary *)getIPAddresses;

@end
