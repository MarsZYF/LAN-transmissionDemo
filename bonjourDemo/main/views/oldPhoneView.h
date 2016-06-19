//
//  oldPhoneView.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/11.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pushDelegate<NSObject>
-(void)pushViewController ;
@end

@interface oldPhoneView : UIView
@property (nonatomic,copy) void (^tableArrayBlock)(NSMutableArray *arr);
@property (nonatomic ,strong) UITableView * IPTabelView ;
@property (nonatomic)NSNetService *service ;
@property (nonatomic,weak)id PushDelegate;

@property (nonatomic, weak) id delegate;

@end
