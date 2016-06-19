//
//  ZYFSocket.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import "ZYFSocket.h"

@implementation ZYFSocket

+(ZYFSocket *)defaultScoket
{
    static ZYFSocket *socket =nil ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        socket =[[ZYFSocket alloc] init];
    });
    return socket;
}
@end
