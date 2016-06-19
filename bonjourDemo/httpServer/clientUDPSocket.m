//
//  clientUDPSocket.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/13.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import "clientUDPSocket.h"
@interface clientUDPSocket()<GCDAsyncUdpSocketDelegate>

@property(nonatomic)GCDAsyncUdpSocket *udpsocket;

@end

@implementation clientUDPSocket
-(instancetype)init
{
    self =[super init] ;
    if (self) {
        [self setUDPSocket];
    }
    return self;
    
}
-(void)setUDPSocket
{
    self.udpsocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    if (![self.udpsocket bindToPort:SOCKETPORT error:&error])
    {
        return;
    }
    if (![self.udpsocket beginReceiving:&error])
    {
        return;
    }
    [self.udpsocket bindToPort:SOCKETPORT error:&error];
}
#pragma mark --GCDAsyncUdpSocketDelegate
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString * ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    NSString *msg  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ip-----%@\nport------%hu\nmsg------%@",ip,port,msg);
    if (msg) {
        //处理收到的msg
    }else
    {
        //处理接收到的空msg
    }
    [self.udpsocket sendData:data toHost:ip port:port withTimeout:-1 tag:0];
    
    if (self.ServerUDPBlock)
    {
        self.ServerUDPBlock(ip,port,msg);
    }


}


@end
