//
//  ZYFContactModel.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/26.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ZYFContactModel : NSObject
//联系人唯一id
@property(nonatomic,assign) NSInteger contactID;

//kABPersonPhoneProperty
@property(nonatomic,strong) NSArray *phones;

//kABPersonFirstNameProperty
@property(nonatomic,copy) NSString *firstName;

//kABPersonLastNameProperty
@property(nonatomic,copy) NSString *lastName;

//kABPersonOrganizationProperty，组织名
@property(nonatomic,copy) NSString *organization;

//kABPersonJobTitleProperty，头衔
@property(nonatomic,copy) NSString *jobTitle;

//kABPersonDepartmentProperty，部门
@property(nonatomic,copy) NSString *department;

//kABPersonNoteProperty，备注
@property(nonatomic,copy) NSString *note;

@property (nonatomic,copy) NSArray *emails;

@property (nonatomic,copy)NSString * brithDay;

@property (nonatomic,strong)NSArray * adress;

@property (nonatomic,strong)NSData * imageData;

+(ZYFContactModel *)contactModelWithABRecord:(ABRecordRef)record;


@end
