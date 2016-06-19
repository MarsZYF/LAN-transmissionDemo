//
//  NetworkMethos.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

/*
 *  未用到 写在viewcontroller 里面了
*/
#import <Foundation/Foundation.h>

@interface NetworkMethos : NSObject

//监听socket服务器
-(void)listenSocketServer;
@end


@interface clientSocket : NSObject

@property(nonatomic)GCDAsyncSocket * socket;

-(void)connecSocketServerWithHost:(NSString*)host ;
-(void)receiveData;
-(void)sendData:(NSData*)data;

@end