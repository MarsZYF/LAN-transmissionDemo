//
//  ZYFSocket.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import <Foundation/Foundation.h>
@class ZYFSocket;

@interface ZYFSocket : NSObject
@property (nonatomic,strong) GCDAsyncSocket * mySocket;
+(ZYFSocket *)defaultScoket;
@end
