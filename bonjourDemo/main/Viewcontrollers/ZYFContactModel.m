//
//  ZYFContactModel.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/26.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "ZYFContactModel.h"


@implementation ZYFContactModel
MJExtensionCodingImplementation
+(ZYFContactModel *)contactModelWithABRecord:(ABRecordRef)record
{
    ZYFContactModel *model = [[ZYFContactModel alloc] init];
    if (model) {
        model.contactID = (NSInteger)ABRecordGetRecordID(record);
        model.firstName = [self getValueWithRecord:record Property:kABPersonFirstNameProperty];
        model.lastName = [self getValueWithRecord:record Property:kABPersonLastNameProperty];
        model.organization = [self getValueWithRecord:record Property:kABPersonOrganizationProperty];
        model.jobTitle = [self getValueWithRecord:record Property:kABPersonJobTitleProperty];
        model.department = [self getValueWithRecord:record Property:kABPersonDepartmentProperty];
        model.note = [self getValueWithRecord:record Property:kABPersonNoteProperty];
        model.brithDay = [self getValueWithRecord: record Property:kABPersonBirthdayProperty];
        model.imageData = (__bridge NSData *)(ABPersonCopyImageData (record));
        //单独对phones做处理
        ABMultiValueRef phone =  ABRecordCopyValue(record, kABPersonPhoneProperty);
        NSArray* phones = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phone));
        model.phones = phones;
        //邮箱
        ABMultiValueRef email =ABRecordCopyValue(record, kABPersonInstantMessageProperty);
        NSArray * emails = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(email));
        model.emails =emails;
        //地址
        ABMultiValueRef adresss =ABRecordCopyValue(record, kABPersonAddressProperty);
        NSArray * adress = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(adresss));
        model.adress =adress;
    }
    return model;
}
+(id)getValueWithRecord:(ABRecordRef)record Property:(ABPropertyID)property
{
    return CFBridgingRelease(ABRecordCopyValue(record, property));
}

@end
