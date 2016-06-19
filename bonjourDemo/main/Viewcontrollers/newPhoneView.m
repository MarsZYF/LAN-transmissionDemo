//
//  newPhoneView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/10.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "newPhoneView.h"
@interface newPhoneView()
@property (nonatomic,strong) UIButton * connectionBtn;
@property (nonatomic,strong) UILabel * phoneLabel;

@end

@implementation newPhoneView
-(instancetype)init
{
    self =[super init];
    if (self) {
        [self CustomView];
        
    }
    return self;
    
}
-(void)CustomView
{
    self.localIPLabel =({
        UILabel * IPLabel = [UILabel new];
        IPLabel.backgroundColor =[UIColor whiteColor];
        IPLabel;
    });
    [self addSubview:self.localIPLabel];
    
    self.phoneLabel = ({
        UILabel *label =[[UILabel alloc] init];
        label.backgroundColor = [UIColor redColor];
        label.text =@"手机";
        label.font =[UIFont systemFontOfSize:12];
        label.textAlignment =NSTextAlignmentCenter;
        label;
    });
    [self addSubview:self.phoneLabel];
    
    self.connectionBtn = ({
        UIButton * btn = [UIButton new];
        [btn setTitle:@"连接" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(listener:) forControlEvents:UIControlEventTouchUpInside];
        btn;
        
    });
    [self addSubview:self.connectionBtn];
    
    
    [self.localIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.localIPLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 70));
        make.centerX.equalTo(self.localIPLabel);
    }];

    [self .connectionBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.equalTo(self.phoneLabel);
    }];
  }

-(void)listener:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(listening)]) {
        [self.delegate listening];
        
    }
}

@end
