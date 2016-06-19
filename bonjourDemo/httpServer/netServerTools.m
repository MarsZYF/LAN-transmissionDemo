//
//  netServerTools.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/18.
//  Copyright © 2016年 ZYF. All rights reserved.
//
/*
 *  未用到 写在viewcontroller 里面了
 */
#import "netServerTools.h"

@interface netServerTools()<NSNetServiceDelegate>

@end

@implementation netServerTools
-(instancetype)init
{
    self =[super init];
    if (self) {
        [self creatServer];
    }
    return self;
}
-(void)creatServer
{
    self.server = [[NSNetService alloc] initWithDomain:KDomainString type:KBonjourType name:[UIDevice currentDevice].name];
    if (self.server!=nil) {
        [self.server scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    //一定要先开启
    self.server.includesPeerToPeer =YES;
    self.server .delegate=self;
    [self.server publishWithOptions:NSNetServiceListenForConnections];
}
//发布成功的回调
-(void)netServiceDidPublish:(NSNetService *)sender
{
    NSLog(@"____发布成功"); 
}
//发布失败的回调
-(void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    
}
-(void)netService:(NSNetService *)sender didAcceptConnectionWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream
{
    
}
-(void)netServiceDidResolveAddress:(NSNetService *)sender
{
    NSLog(@"didresolve:%@,%lu",sender.addresses ,sender.port);
    
}
-(void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"didnot: %@",errorDict);
    
    
}


@end
