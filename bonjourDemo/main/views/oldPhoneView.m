//
//  oldPhoneView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "oldPhoneView.h"
@interface oldPhoneView()<UITableViewDataSource,UITableViewDelegate,NSStreamDelegate,NSNetServiceDelegate>

@property (nonatomic,strong) NSMutableArray * IPArray;
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
@property (nonatomic, strong, readwrite) NSInputStream *        inputStream;
@property (nonatomic, strong, readwrite) NSOutputStream *       outputStream;
@property (nonatomic, assign, readwrite) NSUInteger             streamOpenCount;
@property (nonatomic)NSMutableData * data ;


@end

@implementation oldPhoneView
-(instancetype)init
{
    self =[super init];
    if(self)
    {
        [self customView];
        self.IPTabelView .delegate=self;
        self.IPTabelView.dataSource=self;
        self.IPArray = [[NSMutableArray alloc] init];
        WeakSelf;
        self.tableArrayBlock =^(NSMutableArray *arr){
            weakSelf.IPArray=arr;            
            };
        
            
        }
    return self;
}
-(void)customView
{
    self.IPTabelView = ({
        UITableView * tableview = [UITableView new];
        tableview;
    });
    [self addSubview: self.IPTabelView];
    [self.IPTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.height.equalTo(self);
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"ipArray:%lu",self.IPArray.count);
    return self.IPArray.count+1;
   
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    }
    if (indexPath.row==0)
    {
        cell.textLabel.text= [NSString stringWithFormat:@"本机的IP地址为:%@",[ipTools getIPAddress:YES IPArray:nil]];
    }else
    {
       self.service = self.IPArray[indexPath.row-1];
        NSString * str  =[NSString stringWithFormat:@"%@,%@",_service.name,_service.addresses];
        cell.textLabel.text = str;
          }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row>=1)
    {
        [self.IPTabelView deselectRowAtIndexPath:indexPath animated:YES];
        
        _service = [self.IPArray objectAtIndex:indexPath.row-1];
        _service.delegate = self.delegate;
        [_service resolveWithTimeout:1.0];
//        if ([self.PushDelegate respondsToSelector:@selector(pushViewController)]) {
//            [self.PushDelegate pushViewController];
//        }
//

    }
    

    
//    BOOL success;
//    NSInputStream * inputStream;
//    NSOutputStream * outputStream;
//    success  =[self.service getInputStream:&inputStream outputStream:&outputStream];
//    if (!success) {
//        [self closeStreams];
//    }
//    [self.service publishWithOptions:NSNetServiceListenForConnections];
//

}
//-(void)netServiceDidResolveAddress:(NSNetService *)sender
//{
//    NSLog(@"didresolve:%@,%lu",sender.addresses ,sender.port);
//    
//}
//- (void)openStreams
//{
//    assert(self.inputStream != nil);            // streams must exist but aren't open
//    assert(self.outputStream != nil);
//    assert(self.streamOpenCount == 0);
//    
//    [self.inputStream  setDelegate:self];
//    [self.inputStream  scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [self.inputStream  open];
//    
//    [self.outputStream setDelegate:self];
//    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [self.outputStream open];
//}
//
//- (void)closeStreams
//{
//    assert( (self.inputStream != nil) == (self.outputStream != nil) );      // should either have both or neither
//    if (self.inputStream != nil) {
//        [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [self.inputStream close];
//        self.inputStream = nil;
//        
//        [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [self.outputStream close];
//        self.outputStream = nil;
//    }
//    self.streamOpenCount = 0;
//}
//
//-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
//{
//    switch (eventCode) {
//        case NSStreamEventHasBytesAvailable:
//        {
//            uint8_t buf[1024];
//            NSInteger len = 0;
//            len =[(NSInputStream*)aStream read:buf maxLength:1024];
//            if (len) {
//                [self.data appendBytes:(const void *)buf length:len];
//                
//            }
//        }
//        break;
//        case NSStreamEventEndEncountered:{
//            [self closeStreams];
//        }
//        break;
//        case NSStreamEventErrorOccurred:
//        {
//            NSLog(@"fall");
//            
//        }
//        case NSStreamEventHasSpaceAvailable:
//        {
//            //可以发送字节
//            
//        }
//            
//        default:
//            break;
//    }
//}
//-(void)send:(NSData*)data
//{
//    if ([self.outputStream hasSpaceAvailable]) {
//        NSInteger bytesWrite;
//        bytesWrite =[self.outputStream write:data.bytes maxLength:data.length];
//        if (bytesWrite != data.length)
//        {
//            [self closeStreams];
//        }
//    }
//}
//-(void)test
//{
//    NSString * str  =@"123";
//    NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
//    [self send:data];
//    
//}
@end
