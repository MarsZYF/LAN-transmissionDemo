//
//  serverUDPSocket.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/13.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import "serverUDPSocket.h"
@interface serverUDPSocket()<GCDAsyncUdpSocketDelegate>

@property(nonatomic)GCDAsyncUdpSocket * udpSocket;

@end

@implementation serverUDPSocket
-(instancetype)init
{
    self =[super init];
    if (self) {
        [self setUDPSocket] ;
    }
    return self;
    
}
-(void)setUDPSocket
{
    self.udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError * errror =nil ;
    if (![self.udpSocket bindToPort:SOCKETPORT error:&errror])
    {
        return;
    }
    if (![_udpSocket beginReceiving:&errror])
    {
        [self.udpSocket close];
        return;
    }
    [self.udpSocket bindToPort:SOCKETPORT error:&errror];
        
}
#pragma mark -- GCDAsyncUdpSocketDelegate


- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag;
{
    
}
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
}
//接收
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
}
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
}

@end
