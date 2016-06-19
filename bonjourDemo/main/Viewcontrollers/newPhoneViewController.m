//
//  newPhoneViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "newPhoneViewController.h"
#import "newPhoneView.h"
#import <AddressBook/AddressBook.h>
#import "ZYFAdressHeader.h"
@interface newPhoneViewController ()<NSNetServiceDelegate,NSNetServiceBrowserDelegate,GCDAsyncSocketDelegate,newPhoneViewDelegate>
{
    NSString * ip;
}
@property (nonatomic ,strong) newPhoneView * nPhoneView;
@property (nonatomic)NSNetService *localService ;
@property(nonatomic)GCDAsyncSocket * serverSocket;
@property(nonatomic)GCDAsyncSocket * clientSocket;
@property(nonatomic)NSMutableArray* adressBookArray;

@end

@implementation newPhoneViewController
-(void)viewWillDisappear:(BOOL)animated
{
   [super viewDidDisappear:animated];
    [self stop];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.adressBookArray= @[].mutableCopy;
    
    self.title = @"接收数据";
    ip=   [ipTools getIPAddress:YES IPArray:nil
           ];
    self.view.backgroundColor =[UIColor yellowColor];
    [self prepare];
    self.nPhoneView.localIPLabel.text = [NSString stringWithFormat:@"%@ %@",self.localService.name,ip];
}
-(void)prepare
{
    if (!self.nPhoneView)
    {
        self.nPhoneView =[[newPhoneView alloc] init];
    }
    [self.view addSubview: self.nPhoneView];
    self.nPhoneView .delegate=self;
    [self.nPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.height.equalTo(self.view);
    }];
    [self creatServer];
    
}
-(void)creatServer
{
    if (!self.localService) {
        
        self.localService = [[NSNetService alloc] initWithDomain:KDomainString type:KBonjourType name:[UIDevice currentDevice].name ];

    }
    //一定要先开启
    self.localService.includesPeerToPeer =YES;
   
    self.localService .delegate=self;

    [self.localService publishWithOptions:NSNetServiceListenForConnections];
}

//发布成功的回调
-(void)netServiceDidPublish:(NSNetService *)sender
{
    NSLog(@"_____发布成功______");
    [self startListening];
}
//发布失败的回调
-(void)netService:(NSNetService *)sender didNotPublish:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"————————发布失败——————————");
}
//解析成功
-(void)netServiceDidResolveAddress:(NSNetService *)sender
{
    NSLog(@"%@,%lu",sender.addresses,sender.port);
}
//解析失败（一开始会失败的因为有一方没有开启）
-(void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"didnot: %@",errorDict);
}
-(void)stop
{
    [self.localService stop];
    self.localService =nil;
}

-(void)startListening
{
    //1.创建服务器socket
    if (!self.serverSocket) {
        self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    //2.开始监听（开放哪一个端口）
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:SOCKETPORT error:&error];
    if (result) {
        //开放成功
        NSLog(@"开放监听成功");
    }else{
        //开放失败
        NSLog(@"开放监听失败");
    }
}
#pragma mark  socketdelegate
//监听到客户端socket链接
//当客户端链接成功后，生成一个新的客户端socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    NSLog(@"连接成功");
    //connectedHost:地址IP
    //connectedPort:端口
   NSLog(@"%@",[NSString stringWithFormat:@"链接地址:%@",newSocket.connectedHost]);
    //保存客户端socket
    self.clientSocket = newSocket;
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
//成功读取客户端发过来的消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@+++",message);
//    CFArrayRef persons = ABAddressBookCopyArrayOfAllPeople(addressBook);
//    CFDataRef vcards = (CFDataRef)ABPersonCreateVCardRepresentationWithPeople(persons);
    
    
    CFDataRef vcard=(__bridge CFDataRef)data ;
    CFArrayRef person = ABPersonCreatePeopleInSourceWithVCardRepresentation(NULL,vcard);
    NSLog(@"%@",person);
    
    self.adressBookArray = (__bridge NSMutableArray*)person;
    
    NSLog(@"%lu",self.adressBookArray.count);
    

    [self.clientSocket readDataWithTimeout:-1 tag:0];
    [self inputAdressBook];
    
}
-(void)inputAdressBook
{
//    for (NSDictionary  * dict in self.adressBookArray) {
//        NSString *name =dict.allKeys[0];
//        NSString * number =dict.allValues[0];
//        
//        CFErrorRef error = NULL;
//        
//        //创建一个通讯录操作对象
//        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//        
//        //创建一条新的联系人纪录
//        ABRecordRef newRecord = ABPersonCreate();
//        
//        //为新联系人记录添加属性值
//        ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
//        
//        //创建一个多值属性
//        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
//        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)number, kABPersonPhoneMobileLabel, NULL);
//        //将多值属性添加到记录
//        ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
//        CFRelease(multi);
//        
//        //添加记录到通讯录操作对象
//        ABAddressBookAddRecord(addressBook, newRecord, &error);
//        
//        //保存通讯录操作对象
//        ABAddressBookSave(addressBook, &error);
//        CFRelease(newRecord);
//        CFRelease(addressBook);
//    }


        //创建一个通讯录操作对象
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    for ( id record in self.adressBookArray) {
        ABRecordRef p = (__bridge ABRecordRef)record;
        ABAddressBookAddRecord(addressBook, p, NULL);
        bool isSucess = ABAddressBookSave(addressBook, NULL);
        NSLog(@"%d",isSucess);
    }
    if (addressBook) {
        CFRelease(addressBook);
    }
   

}
//-(void)getterWith:(ZYFContactModel*)model
//{
//    NSString * firstName = model.firstName;
//    NSString * lastName  =model.lastName;
//    
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
