//
//  NetworkMethos.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

/*
 *  未用到 写在viewcontroller 里面了
 */
#import "NetworkMethos.h"

@interface NetworkMethos ()<GCDAsyncSocketDelegate>
@property(nonatomic) GCDAsyncSocket *clientSocket;//为客户端生成的socket
@property(nonatomic) GCDAsyncSocket * serverSocket;//服务器socket
@end

@implementation NetworkMethos

-(instancetype)init{
    self =[super init];
    
    if (self) {
    
    }
    return self;
    
}
-(void)listenSocketServer
{
    //创建服务器Socket
    _serverSocket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error =nil;
    BOOL result = [self.serverSocket acceptOnPort:SOCKETPORT error:&error];
    NSLog(@"_______端口号::%lu",SOCKETPORT);
    if (result) {
        NSLog(@"端口开放成功");
    }else{
        NSLog(@"端口开放失败error:%@",error);
        
    }
}
#pragma mark - GCDAsyncSocketDelegate

//-(void)socket:(GCDAsyncSocket*)sock didConnectToHost:(NSString *)host port:(uint16_t)port
//{
//    NSString * suceesMsg =[NSString stringWithFormat:@"连接成功服务器:%@",host];
//    NSLog(@"%@",suceesMsg);
//    
//    [self.clientSocket readDataWithTimeout:-1 tag:0];
//}
//-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    NSLog(@"消息发送成功");
//}
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"___%@____",message);
    
}

//当客户端链接服务器端的Socket，为客户端生成一个socket



-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"链接成功");
    NSLog(@"链接地址：%@",newSocket.connectedHost);
    NSLog(@"端口号:%hu",newSocket.connectedPort);
    self.clientSocket =newSocket;
}

@end


@interface clientSocket ()<GCDAsyncSocketDelegate>


@end

@implementation clientSocket

-(void)connecSocketServerWithHost:(NSString*)host
{
    self.socket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error =nil;
    BOOL result = [self .socket connectToHost:host onPort:SOCKETPORT error:&error];
    if (result) {
        NSLog(@"客户端连接服务器成功");
    }else
    {
        NSLog(@"客户端连接服务器失败%@",error);
        
    }
}

#pragma mark -- GCDAsyncSocketDelegate 
//客户端链接服务器端成功，客户端获取地址和端口号
//客户端已经获取到内容
#pragma mark  socketdelegate
//监听到客户端socket链接
//当客户端链接成功后，生成一个新的客户端socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"链接成功");
    //connectedHost:地址IP
    //connectedPort:端口
    NSLog(@"%@",[NSString stringWithFormat:@"链接地址:%@",newSocket.connectedHost]);
    //保存客户端socket
    self.socket = newSocket;
    [self.socket readDataWithTimeout:-1 tag:0];
}
//成功读取客户端发过来的消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",message);
    [self.socket readDataWithTimeout:-1 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"消息发送成功");
}

@end

