//
//  ZYFAdressBook.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/26.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
/**
 *  完成获取所有通讯录得block
 */
typedef void(^FinshGetAllPeopleBlock)(NSArray * allPeople);
@interface ZYFAdressBook : NSObject
/**
 *  获取所有联系人
 */
+(void)getAllPeopleWithFinshBlock:(FinshGetAllPeopleBlock)finshBlock;

@end
