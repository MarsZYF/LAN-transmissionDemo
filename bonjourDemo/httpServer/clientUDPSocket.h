//
//  clientUDPSocket.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/13.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import <Foundation/Foundation.h>

@interface clientUDPSocket : NSObject
@property (nonatomic,copy)void (^ServerUDPBlock)(NSString*ip,uint16_t port,NSString*mesage);

@end
