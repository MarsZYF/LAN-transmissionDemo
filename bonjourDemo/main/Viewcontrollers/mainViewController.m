//
//  mainViewController.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "mainViewController.h"
#import "mainView.h"
#import "OldPhoneViewController.h"
#import "newPhoneViewController.h"

@interface mainViewController ()<mainViewDelegate>
{
    mainView * main;
    
}


@end
@implementation mainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.subviews.firstObject.alpha=0;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareWork];
    self.title = @"首页";
    //暂时的方案
    UIBarButtonItem * moreItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:nil];
    self.navigationItem.rightBarButtonItem =moreItem;
    
    /*
        自定义导航栏右边的按钮，这个有图填上图片
     */
//    UIButton *rightBtn =[UIButton new];
//    rightBtn.bounds =CGRectMake(0, 0, 33, 33);
//    [rightBtn  setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
//    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    
}
-(void)prepareWork
{

    main = [mainView new];
    [self.view addSubview:main];
    [main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.height.equalTo(self.view);
    }];
    main.delegate =self;
    
//    main.btnBlock = ^ {
//        WeakSelf.navigationController
//    }
}
#pragma mark --mianViewDelegate 
-(void)clickOldPhone
{
    OldPhoneViewController * oldVC =[[OldPhoneViewController alloc] init];
    
    [self.navigationController pushViewController:oldVC animated:YES];
}
-(void)clickNewPhone
{
    newPhoneViewController * newVC =[[newPhoneViewController alloc] init];
    [self.navigationController pushViewController:newVC animated:YES];
}
@end
