//
//  mainView.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mainViewDelegate <NSObject>

-(void)clickOldPhone;
-(void)clickNewPhone;

@end

@interface mainView : UIView

//@property (nonatomic,copy) void (^btnBlock)();
@property(nonatomic,assign) id<mainViewDelegate> delegate;

@end
