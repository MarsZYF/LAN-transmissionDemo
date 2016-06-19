//
//  OldPhoneViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "OldPhoneViewController.h"
#import "oldPhoneView.h"
#import <sys/socket.h>
#import <netdb.h>
#import "dataViewController.h"
@interface OldPhoneViewController ()<NSNetServiceBrowserDelegate, NSNetServiceDelegate,GCDAsyncSocketDelegate,pushDelegate>
@property(nonatomic ,strong)oldPhoneView * oPhoneView;
@property(nonatomic) clientSocket* net ;
@property(nonatomic)GCDAsyncSocket * clientSocket;
@property(nonatomic)NSNetServiceBrowser* browser;
@property (nonatomic)NSMutableArray * servers;
@property (nonatomic)netServerTools *netserver;
@property(nonatomic,copy)NSString * parsingIP;
@property(nonatomic,assign)NSInteger port;
@property(nonatomic)GCDAsyncSocket * socket;
//@property(nonatomic)NSNetService * localService;

@end

@implementation OldPhoneViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stop];
    
     
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"发送数据";
    
    NSString* IP=   [ipTools getIPAddress:YES IPArray:nil];
    NSLog(@"本机的IP:%@",IP);
    
    self.view.backgroundColor =[UIColor greenColor];
    if (!_servers)
    {
        self.servers =[[NSMutableArray alloc] init];

    }
    [self prepare];
//    self.localService = self.netserver.server;
    self.title = [UIDevice currentDevice].name;
    //把接受到的设备
    if (self.oPhoneView.tableArrayBlock) {
        self.oPhoneView.tableArrayBlock(self.servers);

    }
//    self.oPhoneView .service =self.localService;
}
-(void)prepare
{
    if (!self.oPhoneView)
    {
        self.oPhoneView =[[oldPhoneView alloc] init];
        self.oPhoneView.delegate = self;
        self.oPhoneView.PushDelegate =self;


    }
    [self.view addSubview:self.oPhoneView];
    [self.oPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.left.right.equalTo(self.view);
    }];
//    if (!_netserver)
//    {
//        self.netserver =[[netServerTools alloc] init];
//
//    }
    
 }

-(void)start
{
    if (!self.browser)
    {
        self.browser =[[NSNetServiceBrowser alloc] init];
    }
    self.browser.includesPeerToPeer =YES;
    self.browser.delegate=self;
    [self.browser searchForServicesOfType:KBonjourType inDomain:KBrowserDomainString];
    
}
-(void)stop
{
    
    [self.browser stop];
    self .browser =nil;
//    [self.localService stop];
//    self.localService=nil;
    [self.servers removeAllObjects];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing
{
        [self.servers addObject:service];
        NSLog(@"old:%lu",self.servers.count);

    if (!moreComing) {
        //刷新数据
        [self.oPhoneView.IPTabelView reloadData];
    }
}
-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing
{
    [self.servers removeObject:service];
    if (!moreComing) {
        //刷新数据
        [self.oPhoneView.IPTabelView reloadData];

    }
    
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"no search ");
}
-(void)dealloc
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)netServiceWillResolve:(NSNetService *)netService {
    
    NSLog(@"netServiceWillResolve");
    
}
//解析服务成功
- (void)netServiceDidResolveAddress:(NSNetService *)netService {
    
    
    //<1c1ee6b1 00000000 fe800000 00000000 10aaecff fe1249ac 08000000>
    // <1c1ee6b1 00000000 fe800000 00000000 10aaecff fe1249ac 08000000>
    
    NSLog(@"service ip:%@,------port:%ld",netService.addresses,(long)netService.port);
    self.port =netService.port;
    NSArray * addressArray = netService .addresses;
    if (addressArray !=nil) {
//        for (NSData  * data in addressArray) {
            struct sockaddr * addr = (struct sockaddr*)[addressArray[0] bytes];
//            if (addr->sa_family ==AF_INET) {
                [self nameWithSockaddr:addr];
                NSLog(@"%@",self.parsingIP);
//            }else if (addr ->sa_family==AF_INET6){
////                [self nameWithSockaddr:addr];
//                NSLog(@"IPV6 address is found!");
//                NSLog(@"%@",self.parsingIP);
//            }
//        }
        NSLog(@"%@",self.parsingIP);
        [self pushViewController];
    }
    else
    {
        NSLog(@"no address found!");
    }
    //连接服务器
//    [self connectionServer];
 }
//-(void)pushViewController
//{
//    [self.navigationController pushViewController:VC animated:YES];
//}

-(void)nameWithSockaddr:(struct sockaddr*)sadr
{
    char host[1024];
    char serv[20];
    NSInteger ss =0;
    ss= getnameinfo(sadr,sizeof sadr,host,sizeof( host),serv,sizeof (serv),NI_NUMERICHOST | NI_NUMERICSERV);
    self.parsingIP =[NSString stringWithUTF8String:host];
    
}
//解析服务失败，解析出错
- (void)netService:(NSNetService *)netService didNotResolve:(NSDictionary *)errorDict {
    
    NSLog(@"didNotResolve: %@",errorDict);
    
}
-(void)pushViewController
{
    dataViewController * vc = [[dataViewController alloc] init];
    vc .hostIP = self.parsingIP;
    [self.navigationController pushViewController:vc animated:YES];
}

//-(void)connectionServer
//{
//    if (!self.socket)
//    {
//        self.socket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    NSError *error =nil;
//    BOOL result = [self .socket connectToHost:self.parsingIP onPort:SOCKETPORT error:&error];
//    if (result) {
//        NSLog(@"客户端连接服务器成功");
//    }else
//    {
//        NSLog(@"客户端连接服务器失败%@",error);
//    }
//
//}
//-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
//{
//    NSLog(@"%@",[NSString stringWithFormat:@"连接成功服务器%@",host]);
//    [self.socket readDataWithTimeout:-1 tag:0];
//    //发送数据（模拟）
//    [self sendMessage];
//}
//-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
//{
//    NSLog(@"消息发送成功");
//    [self pushViewController];
//}
//-(void)sendMessage
//{
//    NSString * str =@"赵一帆是好人";
//    NSData* data  =[str dataUsingEncoding:NSUTF8StringEncoding];
//    [self.socket writeData:data withTimeout:-1 tag:0];
//}
//

@end
