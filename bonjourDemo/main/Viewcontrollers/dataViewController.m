//
//  dataViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/24.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "dataViewController.h"
#import "ZYFAdressHeader.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface dataViewController ()<GCDAsyncSocketDelegate,ABPersonViewControllerDelegate>
@property(nonatomic)NSMutableArray*arrayContacts;
@property(nonatomic)GCDAsyncSocket * socket;
@property(nonatomic)NSData *adressBookData;
@end

@implementation dataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayContacts =@[].mutableCopy;
    self.count.text = [NSString stringWithFormat:@"通讯录数量%lu",self.arrayContacts.count];
//    [self getData];
    [self connectionServer];
    [self loadPerson];
    // Do any additional setup after loading the view from its nib.
}
-(void)connectionServer
{
    if (!self.socket)
    {
        self.socket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    NSError *error =nil;
    BOOL result = [self .socket connectToHost:self.hostIP onPort:SOCKETPORT error:&error];
    if (result) {
        NSLog(@"客户端连接服务器成功");
    }else
    {
        NSLog(@"客户端连接服务器失败%@",error);
    }
    
}
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%@",[NSString stringWithFormat:@"连接成功服务器%@",host]);
    [self.socket readDataWithTimeout:-1 tag:0];
}
- (IBAction)sendData:(UIButton *)sender
{
    ABPeoplePickerNavigationController *peoleVC = [[ABPeoplePickerNavigationController alloc] init];
    peoleVC.peoplePickerDelegate = self;
    [self presentModalViewController:peoleVC animated:YES];
    //特别注意，这里要使用膜态弹出。
//    [peoleVC release];
    [self.socket writeData:self.adressBookData withTimeout:-1 tag:0];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    
}
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"消息发送成功");
}
-(void)getData
{
    [ZYFAdressBook getAllPeopleWithFinshBlock:^(NSArray * allPeople){
        if (allPeople)
        {
            self.adressBookData= [NSKeyedArchiver archivedDataWithRootObject:allPeople];
        }
    }];
}
- (void)loadPerson
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, error);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            [self copyAddressBook:addressBookRef];
            //            CFRelease(addressBookRef);
        });
    }else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBookRef];
        CFRelease(addressBookRef);
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法获取您的联系人\n请在设置中修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        });
    }
}
- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
//    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
//    NSArray *peopleArray = (__bridge NSArray *)people;
//    NSInteger peopleCount =peopleArray.count;
//    for ( NSInteger i = 0; i < peopleCount; i++){
//        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
//        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
//        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
//        
//        //读取电话多值
//        ABMultiValueRef phone = ABRecordCopyValue((__bridge ABRecordRef)(peopleArray[i]), kABPersonPhoneProperty);
//        for (NSInteger k = 0; k<ABMultiValueGetCount(phone); k++){
////            获取該Label下的电话值
//            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
//            if ((firstName || lastName) && personPhone) {
//                NSString *strName=firstName;
//                if (!strName) {
//                    strName=lastName;
//                }
//                [_arrayContacts addObject:@{strName:personPhone}];
//            }
//            CFBridgingRelease((__bridge CFTypeRef)(personPhone));
//        }
//        CFBridgingRelease((__bridge CFTypeRef)(firstName));
//        CFBridgingRelease((__bridge CFTypeRef)(lastName));
//        CFRelease((phone));
//    }
//    CFRelease(people);
    //    这个地方是在backgroundThread里面的
//    self.adressBookData = [NSKeyedArchiver archivedDataWithRootObject:peopleArray];
//    dispatch_async(dispatch_get_main_queue(), ^{
//       self .adressBookData = [NSKeyedArchiver archivedDataWithRootObject:(__bridge id _Nonnull)(addressBook)];
//        self.adresshj BookData = [NSJSONSerialization dataWithJSONObject:_arrayContacts options:NSJSONWritingPrettyPrinted error:nil];
//        NSLog(@"%@",self.adressBookData);
//        NSArray *array = [NSJSONSerialization JSONObjectWithData:self.adressBookData options:NSJSONReadingAllowFragments error:nil];
//    });
    CFArrayRef persons = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFDataRef vcards = (CFDataRef)ABPersonCreateVCardRepresentationWithPeople(persons);
    self.adressBookData=(__bridge NSData *)vcards ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
