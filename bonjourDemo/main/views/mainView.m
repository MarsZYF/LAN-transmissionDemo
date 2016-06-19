//
//  mainView.m
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "mainView.h"

@implementation mainView
{
    UIImageView * topImage;
    
    UIView * bottomView;
    
    UIButton * oldPhoneBtn;
    
    UIButton * newPhoneBtn;
    
}


-(instancetype)init
{
    self =[super init];
    if (self) {
        [self initCustomView];
    }
    return self;
}
-(void)initCustomView
{
    topImage = ({
        UIImageView * imageView =[UIImageView new];
        imageView.backgroundColor =[UIColor redColor];
        imageView;
    });
    [self addSubview:topImage];
    
    bottomView =({
        UIView * view  = [UIView new];
        view.backgroundColor =[UIColor whiteColor];
        view;
    });
    [self addSubview:bottomView];
    
    oldPhoneBtn = ({
        UIButton *oldBtn =[UIButton new];
        oldBtn.backgroundColor =[UIColor yellowColor];
        oldBtn.layer.cornerRadius =50;
        oldBtn.layer.borderWidth =1;
//        oldBtn.layer.borderColor =[]
        [oldBtn setTitle:@"旧手机" forState:UIControlStateNormal];
        [oldBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [oldBtn addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [oldBtn addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown & UIControlEventTouchDragInside];
        oldBtn;
    });
    [bottomView addSubview:oldPhoneBtn];
    
    newPhoneBtn = ({
        UIButton *newBt =[UIButton new];
        newBt.backgroundColor =[UIColor greenColor];
        [newBt addTarget:self action:@selector(clickNewPhone:) forControlEvents:UIControlEventTouchUpInside];
        [newBt setTitle:@"新手机" forState:UIControlStateNormal];
        newBt;
    });
    [bottomView addSubview:newPhoneBtn];
    
    /*
     先添加视图在用约束
     */

    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self).multipliedBy(0.6);
    }];

    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];

    /*
        两个button的间隔
     */
    int padding = SCREENWIDTH/8;
    
    
    [oldPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left).offset(padding);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];


    [newPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-padding);
        make.size.centerY.equalTo(oldPhoneBtn);
    }];

    
}
-(void)touchUp:(UIButton*)sender
{
//    if (self.btnBlock)
//    {
//        self.btnBlock();
//        
//   }
    sender.backgroundColor = [UIColor yellowColor];
    if ([self.delegate respondsToSelector:@selector(clickOldPhone)])
    {
        [self.delegate clickOldPhone];
    }
}
-(void)touchDown:(UIButton*)sender
{
    sender.backgroundColor =[UIColor  whiteSmoke];
}
-(void)clickNewPhone:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(clickNewPhone)]) {
        [self.delegate clickNewPhone];
    }
}
@end
